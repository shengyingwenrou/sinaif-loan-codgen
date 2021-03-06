
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
	
	final static int BILL_STATUS_UNPAY = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_UNPAY.getCode());//?????????
	final static int BILL_STATUS_PAYSUCCESS = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_PAYSUCCESS.getCode());//?????????
	final static int BILL_STATUS_OVER = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_OVER.getCode());//?????????
	final static int BILL_STATUS_OVERPAYSUCCESS = Integer.parseInt(CommonEnum.BILL_DETAIL_STATUS_OVERPAYSUCCESS.getCode());//??????????????????
	
	final static String SHOULD_PAY_TYPE = CommonEnum.BILL_ITEM_FEETYPE_PAY.getCode();//??????
	final static String REAL_PAY_TYPE = CommonEnum.BILL_ITEM_FEETYPE_REALPAY.getCode();//??????


	public void syncBillInfo(BillInfoBean billInfoBean) {
		String orderid = billInfoBean.getOrderid();
		String userid = billInfoBean.getUserid();
		String terminalid = billInfoBean.getTerminalid();
		final String key = billInfoBean.getId();
		final String requestId = System.currentTimeMillis()+""; 
		boolean locked = kingRedisLock.tryLock(key, requestId);
		if(!locked) {
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "?????????????????????????????????");
			return;
		}
		try {
			//??????????????????
			List<${className}RepayPlan> repayPlanList = ${className}CreditApplyProcessHelper.query${className}RepayPlanList(userid, orderid, terminalid);
			if (CollectionUtils.isEmpty(repayPlanList)) {
				logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "??????????????????????????????");
				return;
			}
			BillCreateVo billCreateVo = commonServiceHelper.initBillCreateVo(billInfoBean);// ????????????????????????
			String billOperatetype = CommonEnum.BILL_OPERATETYPE_SYN_BILL.getCode();
			Integer source = billInfoBean.getSource();
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "?????????????????????????????????????????????");
			BillCommonVo httpBillCommonVo = getInitHttpCommonBill(billCreateVo, repayPlanList, billOperatetype, source);
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "????????????????????????????????????");
			// ????????????????????????????????????
			billVoService.updateBillCommonVo(httpBillCommonVo, terminalid);
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "??????????????????");
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
		// ????????????
		List<BillDetailBean> billDetailBeanList = new ArrayList<BillDetailBean>();
		for (${className}RepayPlan repaymentPlan : repayPlanList){
			BillDetailBean billDetailBean = initBillDetailBean(billCreateVo, repaymentPlan);
		    /** ??????ID????????????t_bill_info??????id??????*/
			billDetailBean.setBillid(billInfoBean.getId());
			// ??????
			billDetailBean.setSource(source);
			billDetailBeanList.add(billDetailBean);
		}
		
		// ?????????????????????
		commonServiceHelper.initBillInfoBean(billCreateVo, billInfoBean);
		// ??????????????????????????????
		this.initBillInfoBeanByDetailList(billCreateVo, billInfoBean, billDetailBeanList);
		// ????????????
		billInfoBean.setLoanamount(billCreateVo.getApplyamount());//????????????=????????????
		// ????????????
		billInfoBean.setArrivalamount(billInfoBean.getLoanamount());//??????????????????
		// ??????
		billInfoBean.setSource(source);
		
		// ??????bean??????
		billCommonVo.setBillDetailBeans(billDetailBeanList);
		billCommonVo.setBillInfoBean(billInfoBean);
		
		return billCommonVo;
	}

	private void initBillInfoBeanByDetailList(BillCreateVo billCreateVo, BillInfoBean billInfoBean,
			List<BillDetailBean> billDetailBeanList) {
		// ????????????
		BigDecimal planReppayAmt = BigDecimal.ZERO;
		// ????????????
		BigDecimal interestAmt = BigDecimal.ZERO;
		// ???????????????
		BigDecimal serviceFee = BigDecimal.ZERO;
		// ??????????????????
		BigDecimal overservice = BigDecimal.ZERO;
		// ????????????
		BigDecimal planReppayAmtR = BigDecimal.ZERO;
		// ????????????
		BigDecimal interestAmtR = BigDecimal.ZERO;
		// ???????????????
		BigDecimal serviceFeeR = BigDecimal.ZERO;
		// ??????????????????
		BigDecimal overserviceR = BigDecimal.ZERO;

		/** ???????????? */
		int overduedays = 0;
		String feeType;//????????????
		String content;//?????????
		
		// ????????????
		for (BillDetailBean bean : billDetailBeanList) {
			// ??????????????????????????????
			if (!StringUtils.isEmpty(bean.getOverdueDays())){
				overduedays = Integer.parseInt(bean.getOverdueDays()) > overduedays ? Integer.parseInt(bean.getOverdueDays()) : overduedays;
			}
			// ?????????
			for (BillItemBean detailBillItemBean : bean.getBillItemBeans()) {
				feeType = detailBillItemBean.getFeetype().toString();
				content = detailBillItemBean.getContent().toString();
				// ??????
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode().equals(content)) {
					planReppayAmt = planReppayAmt.add(detailBillItemBean.getDueamount());
					continue;
				}
				// ??????
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_INT.getCode().equals(content)) {
					interestAmt = interestAmt.add(detailBillItemBean.getDueamount());
					continue;
				}
				// ?????????
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode().equals(content)) {
					serviceFee = serviceFee.add(detailBillItemBean.getDueamount());
					continue;
				}
				// ????????????
				if (SHOULD_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode().equals(content)) {
					overservice = overservice.add(detailBillItemBean.getDueamount());
					continue;
				}
				// ????????????
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode().equals(content)) {
					planReppayAmtR = planReppayAmtR.add(detailBillItemBean.getDueamount());
					continue;
				}
				// ????????????
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_INT.getCode().equals(content)) {
					interestAmtR = interestAmtR.add(detailBillItemBean.getDueamount());
					continue;
				}
				// ???????????????
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode().equals(content)) {
					serviceFeeR = serviceFeeR.add(detailBillItemBean.getDueamount());
					continue;
				}
				// ??????????????????
				if (REAL_PAY_TYPE.equals(feeType)
						&& CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode()
								.equals(detailBillItemBean.getContent().toString())) {
					overserviceR = overserviceR.add(detailBillItemBean.getDueamount());
					continue;
				}
			}
		}
		//????????????
		billInfoBean.setLoanamount(planReppayAmt);
		//????????????
		billInfoBean.setArrivalamount(billInfoBean.getLoanamount());
		//????????????
		BigDecimal dueamount = planReppayAmt.add(interestAmt).add(serviceFee).add(overservice);
		billInfoBean.setDueamount(dueamount);
		// ????????????
		BigDecimal realamount = planReppayAmtR.add(interestAmtR).add(serviceFeeR).add(overserviceR);
		billInfoBean.setRealamount(realamount);
		//????????????
		billInfoBean.setRealcaptal(planReppayAmtR);
		// ????????????
		billInfoBean.setOverduedays(overduedays);

		// ?????????
		List<BillItemBean> billItemBeans = new ArrayList<BillItemBean>();
		// ??????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), planReppayAmt.toString(), 0));
		// ??????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), interestAmt.toString(), 0));
		// ?????????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode(), serviceFee.toString(), 0));
		// ????????????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), SHOULD_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode(), overservice.toString(), 0));
		// ??????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), planReppayAmtR.toString(), 0));
		// ??????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), interestAmtR.toString(), 0));
		// ?????????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_FEESERVICE.getCode(), serviceFeeR.toString(), 0));
		// ??????????????????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLMAIN.getCode(),
						billInfoBean.getId(), REAL_PAY_TYPE,
						CommonEnum.BILL_ITEM_CONTENT_OVERSERVICE.getCode(), overserviceR.toString(), 0));
		// ???????????????
		billInfoBean.setBillItemBeans(billItemBeans);
		// ???????????????
		commonServiceHelper.findBillInfoStatus(billDetailBeanList, billInfoBean);

	}

	private BillDetailBean initBillDetailBean(BillCreateVo billCreateVo, ${className}RepayPlan repayPlan) {
		BillDetailBean bean = new BillDetailBean();
		/** ??????ID */
		final String detailId = HNUtil.getId();
		bean.setId(detailId);
		/** ??????ID????????????t_user_account??????id?????? */
		bean.setUserid(billCreateVo.getUserid());
		/** ??????ID????????????t_product_info??????id?????? */
		bean.setProductid(billCreateVo.getProductid());
		/** ?????????????????????t_app_applyloan_record??????id?????? */
		bean.setOrderid(billCreateVo.getOrderid());
		/** ?????? */
		int period = repayPlan.getPeriod();
		bean.setPeriod(period);
		/** ????????? */
		Date paydateDate = DateUtils.string2Date(repayPlan.getPlanRepayDate(), DateUtils.DATE_FORMAT_12);
		bean.setPaydate(paydateDate);
		/** ???????????? */
		BigDecimal preAmount= UnitConversionUtil.fenToYuan(repayPlan.getPlanRepayAmount());
		bean.setAmount(preAmount);
		/** ????????????=???????????? */
		bean.setDueamount(bean.getAmount());

		/** ????????????=??????0 ????????????bill_item??????*/
		BigDecimal preRealamount = BigDecimal.ZERO;
		bean.setRealamount(preRealamount);

		/** ????????????:-1??????????????????t_terminal_info????????? */
		bean.setTerminalid(billCreateVo.getTerminalid());
		// ??????????????????
		if(repayPlan.getIsRepaid() == Y_NUM) {
			Date realRepayDate = new Date(repayPlan.getRepayTime()*1000);
			bean.setRealrepaydate(realRepayDate);
			/** ???????????? */
			bean.setRealamount(UnitConversionUtil.fenToYuan(repayPlan.getRepayAmount()));
		}

		/** ?????????1????????????2???????????????3????????????4?????????????????? */
		int status = switchStatus(repayPlan);
		bean.setStatus(status);
		
		/** ???????????? */
		bean.setCreatetime(new Date());
		/** ???????????? */
		bean.setUpdatetime(bean.getCreatetime());
		/** ?????????????????????ID:??????ID */
		bean.setFinanceplanid("");
		/** ???????????? */
		if(status == BILL_STATUS_OVER) {
			String overdueDays = getOverdueDays(repayPlan.getPlanRepayDate());
			bean.setOverdueDays(overdueDays);
		}
		// ???????????????
		List<BillItemBean> billItemBeans = new ArrayList<BillItemBean>();
		String capital = UnitConversionUtil.fenToYuan(repayPlan.getPlanRepayPrincipal()).toString();
		String interest = UnitConversionUtil.fenToYuan(repayPlan.getPlanRepayFee()).toString();
		
		//????????????
		// ??????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(),
						detailId, SHOULD_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), capital, period));
		// ??????
		billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(),
				detailId, SHOULD_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), interest, period));
		
		//?????????
		if(repayPlan.getIsRepaid() == Y_NUM) {
			String repayCapital = UnitConversionUtil.fenToYuan(repayPlan.getRepayPrincipal()).toString();
			String repayInterest = UnitConversionUtil.fenToYuan(repayPlan.getRepayFee()).toString();
			// ????????????
			billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(), detailId, 
					REAL_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_PRIN.getCode(), repayCapital, period));
			// ????????????
			billItemBeans.add(commonServiceHelper.initBillItemBean(billCreateVo, CommonEnum.BILL_ITEM_BILLTYPE_BILLSUB.getCode(), detailId, 
					REAL_PAY_TYPE,CommonEnum.BILL_ITEM_CONTENT_INT.getCode(), repayInterest, period));
		}
		
		bean.setBillItemBeans(billItemBeans);
		return bean;
	}

	
	private int switchStatus(${className}RepayPlan repayPlan) {
		if(N_NUM == repayPlan.getIsRepaid()) { //?????????
			if(Y_NUM == repayPlan.getIsOverdue()) {//?????????
				return BILL_STATUS_OVER;
			}
			return BILL_STATUS_UNPAY;
		}else if(Y_NUM == repayPlan.getIsRepaid()) {//?????????
			if(Y_NUM == repayPlan.getIsOverdue()) {//???????????????
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
		// ???????????????????????? ????????????????????????
		BillCreateVo billCreateVo = commonServiceHelper.initBillCreateVo(withdrawApplyBean);
		String billOperatetype = CommonEnum.BILL_OPERATETYPE_SYN_BILL.getCode();
		Integer source = Integer.valueOf(CommonEnum.BILL_SOURCE_MASTER.getCode());
		logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "?????????????????????????????????????????????");
		BillCommonVo mainBillCommonVo = getInitHttpCommonBill(billCreateVo, repayPlanList, billOperatetype, source);
		BillInfoBean tempBillInfoBean = mainBillCommonVo.getBillInfoBean();
		// ???????????????????????????
		BillCommonVo oldBillCommonVo = billVoService.selectBillCommonVo(orderid, tempBillInfoBean.getSource().toString(), terminalid);
		if (oldBillCommonVo != null) {
			logger.error("???????????????????????????????????? | orderId={}", orderid);
			return null;
		}
		logger.info("?????????????????? | orderId={}", orderid);
		billVoService.insertBillCommonVo(mainBillCommonVo);
		logger.info("?????????????????? | orderId={}", orderid);
		// ????????????
		loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.WITHDRAWSUCCESS, withdrawApplyBean.getUserid(),
				withdrawApplyBean.getProductid(), mainBillCommonVo.getBillInfoBean().getId(), null,
				withdrawApplyBean.getOrderid(), null, 1, null, 1, null, withdrawApplyBean.getTerminalid());
		logger.info("????????????????????????????????????????????????| orderId={}", orderid);
		String billId = mainBillCommonVo.getBillInfoBean().getId();
		return billId;
	}
	
}
