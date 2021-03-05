
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.helper;

import static com.sinaif.king.common.TwoKeyValues.N_NUM;
import static com.sinaif.king.common.TwoKeyValues.Y_NUM;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sinaif.king.common.lock.KingRedisLock;
import com.sinaif.king.common.utils.DateUtils;
import com.sinaif.king.common.utils.HNUtil;
import com.sinaif.king.enums.common.CommonEnum;
import com.sinaif.king.enums.common.LoanProgressTypeEnum;
import com.sinaif.king.finance.service.helper.CommonServiceHelper;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;
import com.sinaif.king.finance.${classNameLower}.utils.UnitConversionUtil;
import com.sinaif.king.model.finance.bill.BillDetailBean;
import com.sinaif.king.model.finance.bill.BillInfoBean;
import com.sinaif.king.model.finance.bill.BillItemBean;
import com.sinaif.king.model.finance.vo.BillCommonVo;
import com.sinaif.king.model.finance.vo.BillCreateVo;
import com.sinaif.king.model.finance.withdraw.WithdrawApplyBean;
import com.sinaif.king.service.loan.LoanProgressBeanService;
import com.sinaif.king.service.repay.BillVoService;


<#include "/java_imports.include" />
@Service
public class ${className}BillServiceHelper {
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private CommonServiceHelper commonServiceHelper;
	@Autowired
	private BillVoService billVoService;
	@Autowired
    private ${className}CreditApplyProcessHelper ${className}CreditApplyProcessHelper;
	@Autowired
	private KingRedisLock kingRedisLock;
	@Autowired
	private LoanProgressBeanService loanProgressBeanService;
	
	final static int BILL_STATUS_UNPAY = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_UNPAY.getCode());//未还款
	final static int BILL_STATUS_PAYSUCCESS = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_PAYSUCCESS.getCode());//已还款
	final static int BILL_STATUS_OVER = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_OVER.getCode());//已逾期
	final static int BILL_STATUS_OVERPAYSUCCESS = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_OVERPAYSUCCESS.getCode());//逾期还款成功
	
	final static String SHOULD_PAY_TYPE = CommonEnum.BILL_ITEM_FEETYPE_PAY.getCode();//应还
	final static String REAL_PAY_TYPE = CommonEnum.BILL_ITEM_FEETYPE_REALPAY.getCode();//实还


	public void syncBillInfo(BillInfoBean billInfoBean) {
		String orderid = billInfoBean.getOrderid();
		String userid = billInfoBean.getUserid();
		String terminalid = billInfoBean.getTerminalid();
		final String key = billInfoBean.getId();
		final String requestId = System.currentTimeMillis()+""; 
		boolean locked = kingRedisLock.tryLock(key, requestId);
		if(!locked) {
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "账单同步请求已在处理中");
			return;
		}
		try {
			//资方还款计划
			List<${className}RepayPlan> repayPlanList = ${className}CreditApplyProcessHelper.query${className}RepayPlanList(userid, orderid, terminalid);
			if (CollectionUtils.isEmpty(repayPlanList)) {
				logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "资方还款计划信息为空");
				return;
			}
			BillCreateVo billCreateVo = commonServiceHelper.initBillCreateVo(billInfoBean);// 初始化总账单信息
			String billOperatetype = CommonEnum.BILL_OPERATETYPE_SYN_BILL.getCode();
			Integer source = billInfoBean.getSource();
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "获取到资方账单，准备初始化组装");
			BillCommonVo httpBillCommonVo = getInitHttpCommonBill(billCreateVo, repayPlanList, billOperatetype, source);
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "初始化组装成功，准备更新");
			// 更新账单，订单，流程流转
			billVoService.updateBillCommonVo(httpBillCommonVo, terminalid);
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "账单更新成功");
		}finally {
			kingRedisLock.releaseLock(key, requestId);
		}
		
	}

	private BillCommonVo getInitHttpCommonBill(BillCreateVo billCreateVo, List<${className}RepayPlan> repayPlanList,
			String billOperatetype, Integer source) {
		BillCommonVo billCommonVo = new BillCommonVo();
		billCommonVo.setOperateType(billOperatetype);
		
		BillInfoBean billInfoBean = new BillInfoBean();
		billInfoBean.setId(HNUtil.getId());
		// 账单明细
		List<BillDetailBean> billDetailBeanList = new ArrayList<BillDetailBean>();
		for (${className}RepayPlan repaymentPlan : repayPlanList){
			BillDetailBean billDetailBean = initBillDetailBean(billCreateVo, repaymentPlan);
		    /** 账单ID，引用自t_bill_info表的id字段*/
			billDetailBean.setBillid(billInfoBean.getId());
			// 来源
			billDetailBean.setSource(source);
			billDetailBeanList.add(billDetailBean);
		}
		
		// 初始化基本信息
		commonServiceHelper.initBillInfoBean(billCreateVo, billInfoBean);
		// 根据明细加载其他信息
		this.initBillInfoBeanByDetailList(billCreateVo, billInfoBean, billDetailBeanList);
		// 放款金额
		billInfoBean.setLoanamount(billCreateVo.getApplyamount());//放款金额=申请金额
		// 到账金额
		billInfoBean.setArrivalamount(billInfoBean.getLoanamount());//应还款总金额
		// 来源
		billInfoBean.setSource(source);
		
		// 组装bean信息
		billCommonVo.setBillDetailBeans(billDetailBeanList);
		billCommonVo.setBillInfoBean(billInfoBean);
		
		return billCommonVo;
	}

	private void initBillInfoBeanByDetailList(BillCreateVo billCreateVo, BillInfoBean billInfoBean,
			List<BillDetailBean> billDetailBeanList) {
		// 应还本金
		BigDecimal planReppayAmt = BigDecimal.ZERO;
		// 应还利息
		BigDecimal interestAmt = BigDecimal.ZERO;
		// 应还服务费
		BigDecimal serviceFee = BigDecimal.ZERO;
		// 应还逾期费用
		BigDecimal overservice = BigDecimal.ZERO;
		// 实还本金
		BigDecimal planReppayAmtR = BigDecimal.ZERO;
		// 实还利息
		BigDecimal interestAmtR = BigDecimal.ZERO;
		// 实还服务费
		BigDecimal serviceFeeR = BigDecimal.ZERO;
		// 实还逾期费用
		BigDecimal overserviceR = BigDecimal.ZERO;

		/** 逾期天数 */
		int overduedays = 0;
		String feeType;//费用类型
		String content;//内容项
		
		// 账单明细
		for (BillDetailBean bean : billDetailBeanList) {
			// 逾期天数，取最大天数
			if (!StringUtils.isEmpty(bean.getOverdueDays())){
				overduedays = Integer.parseInt(bean.getOverdueDays()) > overduedays ? Integer.parseInt(bean.getOverdueDays()) : overduedays;
			}
			// 费用项
			for (BillItemBean detailBillItemBean : bean.getBillItemBeans()) {
				feeType = detailBillItemBean.getFeetype().toString();
				content = detailBillItemBean.getContent().toString();
				// 本金
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode().equals(content)) {
					planReppayAmt = planReppayAmt.add(detailBillItemBean.getDueamount());
					continue;
				}
				// 利息
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_INT.getCode().equals(content)) {
					interestAmt = interestAmt.add(detailBillItemBean.getDueamount());
					continue;
				}
				// 服务费
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode().equals(content)) {
					serviceFee = serviceFee.add(detailBillItemBean.getDueamount());
					continue;
				}
				// 逾期费用
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode().equals(content)) {
					overservice = overservice.add(detailBillItemBean.getDueamount());
					continue;
				}
				// 实还本金
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode().equals(content)) {
					planReppayAmtR = planReppayAmtR.add(detailBillItemBean.getDueamount());
					continue;
				}
				// 实还利息
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_INT.getCode().equals(content)) {
					interestAmtR = interestAmtR.add(detailBillItemBean.getDueamount());
					continue;
				}
				// 实还服务费
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode().equals(content)) {
					serviceFeeR = serviceFeeR.add(detailBillItemBean.getDueamount());
					continue;
				}
				// 实还逾期费用
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode()
								.equals(detailBillItemBean.getContent().toString())) {
					overserviceR = overserviceR.add(detailBillItemBean.getDueamount());
					continue;
				}
			}
		}
		//放款金额
		billInfoBean.setLoanamount(planReppayAmt);
		//到账金额
		billInfoBean.setArrivalamount(billInfoBean.getLoanamount());
		//应还金额
		BigDecimal dueamount = planReppayAmt.add(interestAmt).add(serviceFee).add(overservice);
		billInfoBean.setDueamount(dueamount);
		// 实还金额
		BigDecimal realamount = planReppayAmtR.add(interestAmtR).add(serviceFeeR).add(overserviceR);
		billInfoBean.setRealamount(realamount);
		//实还本金
		billInfoBean.setRealcaptal(planReppayAmtR);
		// 逾期天数
		billInfoBean.setOverduedays(overduedays);

		// 费用项
		List<BillItemBean> billItemBeans = new ArrayList<BillItemBean>();
		// 本金
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), planReppayAmt.toString(), 0));
		// 利息
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), interestAmt.toString(), 0));
		// 服务费
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode(), serviceFee.toString(), 0));
		// 逾期费用
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode(), overservice.toString(), 0));
		// 本金
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), planReppayAmtR.toString(), 0));
		// 利息
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), interestAmtR.toString(), 0));
		// 服务费
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode(), serviceFeeR.toString(), 0));
		// 实还逾期费用
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode(), overserviceR.toString(), 0));
		// 费用明细项
		billInfoBean.setBillItemBeans(billItemBeans);
		// 下一还款日
		commonServiceHelper.findBillInfoStatus(billDetailBeanList, billInfoBean);

	}

	private BillDetailBean initBillDetailBean(BillCreateVo billCreateVo, ${className}RepayPlan repayPlan) {
		BillDetailBean bean = new BillDetailBean();
		/** 主键ID */
		final String detailId = HNUtil.getId();
		bean.setId(detailId);
		/** 用户ID，引用自t_user_account表的id字段 */
		bean.setUserid(billCreateVo.getUserid());
		/** 产品ID，引用自t_product_info表的id字段 */
		bean.setProductid(billCreateVo.getProductid());
		/** 订单号，引用自t_app_applyloan_record表的id字段 */
		bean.setOrderid(billCreateVo.getOrderid());
		/** 期数 */
		int period = repayPlan.getPeriod();
		bean.setPeriod(period);
		/** 还款日 */
		Date paydateDate = DateUtils.string2Date(repayPlan.getPlanRepayDate(), DateUtils.DATE_FORMAT_12);
		bean.setPaydate(paydateDate);
		/** 当期金额 */
		BigDecimal preAmount= UnitConversionUtil.fenToYuan(repayPlan.getPlanRepayAmount());
		bean.setAmount(preAmount);
		/** 应还金额=当期金额 */
		bean.setDueamount(bean.getAmount());

		/** 实还金额=默认0 实际存在bill_item里面*/
		BigDecimal preRealamount = BigDecimal.ZERO;
		bean.setRealamount(preRealamount);

		/** 还款终端:-1银行代扣，取t_terminal_info对应值 */
		bean.setTerminalid(billCreateVo.getTerminalid());
		// 实际还款时间
		if(repayPlan.getIsRepaid() == Y_NUM) {
			Date realRepayDate = new Date(repayPlan.getRepayTime()*1000);
			bean.setRealrepaydate(realRepayDate);
			/** 实还金额 */
			bean.setRealamount(UnitConversionUtil.fenToYuan(repayPlan.getRepayAmount()));
		}

		/** 状态：1未还款，2还款成功，3已逾期，4逾期还款成功 */
		int status = switchStatus(repayPlan);
		bean.setStatus(status);
		
		/** 创建时间 */
		bean.setCreatetime(new Date());
		/** 更新时间 */
		bean.setUpdatetime(bean.getCreatetime());
		/** 资金方还款计划ID:订单ID */
		bean.setFinanceplanid("");
		/** 逾期天数 */
		if(status == BILL_STATUS_OVER) {
			String overdueDays = getOverdueDays(repayPlan.getPlanRepayDate());
			bean.setOverdueDays(overdueDays);
		}
		// 账单费用项
		List<BillItemBean> billItemBeans = new ArrayList<BillItemBean>();
		String capital = UnitConversionUtil.fenToYuan(repayPlan.getPlanRepayPrincipal()).toString();
		String interest = UnitConversionUtil.fenToYuan(repayPlan.getPlanRepayFee()).toString();
		
		//账单明细
		// 本金
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(),
						detailId, SHOULD_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), capital, period));
		// 利息
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(),
				detailId, SHOULD_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), interest, period));
		
		//已还款
		if(repayPlan.getIsRepaid() == Y_NUM) {
			String repayCapital = UnitConversionUtil.fenToYuan(repayPlan.getRepayPrincipal()).toString();
			String repayInterest = UnitConversionUtil.fenToYuan(repayPlan.getRepayFee()).toString();
			// 实还本金
			billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(), detailId, 
					REAL_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), repayCapital, period));
			// 实还利息
			billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(), detailId, 
					REAL_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), repayInterest, period));
		}
		
		bean.setBillItemBeans(billItemBeans);
		return bean;
	}

	
	private int switchStatus(${className}RepayPlan repayPlan) {
		if(N_NUM == repayPlan.getIsRepaid()) { //未还款
			if(Y_NUM == repayPlan.getIsOverdue()) {//已逾期
				return BILL_STATUS_OVER;
			}
			return BILL_STATUS_UNPAY;
		}else if(Y_NUM == repayPlan.getIsRepaid()) {//已还款
			if(Y_NUM == repayPlan.getIsOverdue()) {//逾期后还款
				return BILL_STATUS_OVERPAYSUCCESS;
			}
			return BILL_STATUS_PAYSUCCESS;
		}
		return BILL_STATUS_UNPAY;
	}
	
	private String getOverdueDays(String shouldTime) {
		Date date = new Date();
		String nowStr = DateUtils.dateToString(date, DateUtils.DATE_FORMAT_12);
		long days = 0;
		try {
			days = DateUtils.getDistanceDays(shouldTime, nowStr, DateUtils.DATE_FORMAT_12);
		} catch (Exception e) {
		}
		return String.valueOf(days);
	}
	
	public String saveInitBillInfo(WithdrawApplyBean withdrawApplyBean,List<${className}RepayPlan> repayPlanList) {
		String terminalid = withdrawApplyBean.getTerminalid();
		String orderid = withdrawApplyBean.getOrderid();
		String userid = withdrawApplyBean.getUserid();
		// 生成待还款账单， 构建账单所需对象
		BillCreateVo billCreateVo = commonServiceHelper.initBillCreateVo(withdrawApplyBean);
		String billOperatetype = CommonEnum.BILL_OPERATETYPE_SYN_BILL.getCode();
		Integer source = Integer.valueOf(CommonEnum.BILL_SOURCE_MASTER.getCode());
		logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "获取到资方账单，准备初始化组装");
		BillCommonVo mainBillCommonVo = getInitHttpCommonBill(billCreateVo, repayPlanList, billOperatetype, source);
		BillInfoBean tempBillInfoBean = mainBillCommonVo.getBillInfoBean();
		// 判断账单是否已存在
		BillCommonVo oldBillCommonVo = billVoService.selectBillCommonVo(orderid, tempBillInfoBean.getSource().toString(), terminalid);
		if (oldBillCommonVo != null) {
			logger.error("账单已存在，保存账单失败 | orderId={}", orderid);
			return null;
		}
		logger.info("开始生成账单 | orderId={}", orderid);
		billVoService.insertBillCommonVo(mainBillCommonVo);
		logger.info("结束生成账单 | orderId={}", orderid);
		// 保存进度
		loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.WITHDRAWSUCCESS, withdrawApplyBean.getUserid(),
				withdrawApplyBean.getProductid(), mainBillCommonVo.getBillInfoBean().getId(), null,
				withdrawApplyBean.getOrderid(), null, 1, null, 1, null, withdrawApplyBean.getTerminalid());
		logger.info("【提现进度同步】：状态：提现成功| orderId={}", orderid);
		String billId = mainBillCommonVo.getBillInfoBean().getId();
		return billId;
	}
	
}
