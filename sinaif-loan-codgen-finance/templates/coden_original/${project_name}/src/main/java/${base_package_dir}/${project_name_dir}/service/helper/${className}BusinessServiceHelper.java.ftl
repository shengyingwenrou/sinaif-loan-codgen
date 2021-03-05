<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.helper;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.gexin.fastjson.JSON;
import com.sinaif.king.common.TwoKeyValues;
import com.sinaif.king.common.utils.DateUtils;
import com.sinaif.king.common.utils.HNUtil;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.app.SystemParamTypeEnum;
import com.sinaif.king.enums.app.UserBankTypeEnum;
import com.sinaif.king.enums.common.CommonEnum;
import com.sinaif.king.enums.common.CommonEnumConstant;
import com.sinaif.king.enums.common.FinanceCommonParamEnum;
import com.sinaif.king.enums.common.LoanProgressTypeEnum;
import com.sinaif.king.enums.data.BankTypeEnum;
import com.sinaif.king.enums.finance.ApplyStatusEnum;
import com.sinaif.king.enums.finance.FinanceParamConfEnum;
import com.sinaif.king.enums.finance.flow.FlowEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.api.FinanceProcessorFactory;
import com.sinaif.king.finance.api.ProductParamsMap;
import com.sinaif.king.finance.service.helper.CommonServiceHelper;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CheckLoanEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CodeStatusEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindCreditCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCardListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckLoanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserBindCreditCardRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCardListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCheckLoanRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}ApproveInfo;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;
import com.sinaif.king.finance.${classNameLower}.utils.UnitConversionUtil;
import com.sinaif.king.model.finance.access.AccessVO;
import com.sinaif.king.model.finance.access.ProductUserAccessBean;
import com.sinaif.king.model.finance.base.BaseParamBean;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.credit.CreditInfoBean;
import com.sinaif.king.model.finance.data.vo.IDCardVO;
import com.sinaif.king.model.finance.data.vo.UserAccountVO;
import com.sinaif.king.model.finance.data.vo.UserBankCardVO;
import com.sinaif.king.model.finance.data.vo.UserInfoVo;
import com.sinaif.king.model.finance.product.FinanceParamConfBean;
import com.sinaif.king.model.finance.product.finance.FinanceInfoBean;
import com.sinaif.king.model.finance.request.FinanceApiRequest;
import com.sinaif.king.model.finance.system.SystemParamConfBean;
import com.sinaif.king.model.finance.withdraw.WithdrawApplyBean;
import com.sinaif.king.service.access.ProductUserAccessService;
import com.sinaif.king.service.credit.CreditApplyService;
import com.sinaif.king.service.credit.CreditInfoService;
import com.sinaif.king.service.data.DepositBankService;
import com.sinaif.king.service.data.UserResouceService;
import com.sinaif.king.service.flow.item.FlowService;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;
import com.sinaif.king.service.loan.LoanProgressBeanService;
import com.sinaif.king.service.product.ProductCreditConfService;
import com.sinaif.king.service.product.ProductParamRelService;
import com.sinaif.king.service.product.finance.FinanceInfoService;
import com.sinaif.king.service.product.finance.FinanceParamConfService;
import com.sinaif.king.service.risk.UploadDeviceResultService;
import com.sinaif.king.service.system.ISystemParamConfService;
import com.sinaif.king.service.withdraw.WithdrawApplyService;

<#include "/java_imports.include" />
@Component
public class ${className}BusinessServiceHelper extends ${className}BaseHelper{

    private static Logger logger = LoggerFactory.getLogger(${className}BusinessServiceHelper.class);

    @Autowired
    protected LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;
    @Autowired
    private UserResouceService userResouceService;
    @Autowired
    private FinanceProcessorFactory financeProcessorFactory;
    @Autowired
    private ProductUserAccessService productUserAccessService;
    @Autowired
    private FinanceParamConfService financeParamConfService;
    @Autowired
    private CommonServiceHelper commonServiceHelper;
    @Autowired
    private UploadDeviceResultService uploadDeviceResultService;
    @Autowired
    private CreditApplyService creditApplyService;

    @Autowired
    private FinanceInfoService financeInfoService;

    @Autowired
    private ${className}BusinessServiceHelper ${className}BusinessServiceHelper;

    @Autowired
    private LoanProgressBeanService loanProgressBeanService;
    @Autowired
    ${className}BizFinanceRefServiceHelper ${className}BizFinanceRefServiceHelper;
    @Autowired
	private ProductParamRelService productParamRelService;
    @Autowired
	private DepositBankService depositBankService;
    
    @Autowired
    private ISystemParamConfService systemParamConfService;
    @Autowired
	private WithdrawApplyService withdrawApplyService;
    @Autowired
	private FlowService<Void, Void, Void> flowService;
    @Autowired
	private CreditInfoService creditInfoService;
    @Autowired
	private ProductCreditConfService productCreditConfService;
    @Autowired
    private ${className}BillServiceHelper ${className}BillServiceHelper;

    public ProductUserAccessBean buildProductUserAccessBean(AccessVO vo,ProductEnum productEnum) {

        String msgInfo = String.format("【${log_finance_name}】产品准入，用户id【%s】,产品编号【%s】", vo.getUserid(), productEnum.id);
        // 获取资方产品ID
        FinanceInfoBean financeInfoBean = financeInfoService.getFinanceInfoByCode(productEnum.name(), vo.getTerminalid());
        if (financeInfoBean == null) {
            throw new FinanceException("", "未配置资方信息【" + productEnum.name() + "】");
        }
        String userid = vo.getUserid();
        String productid = vo.getProductid();
        String terminalid = vo.getTerminalid();
        CreditApplyBean creditApplyBean = new CreditApplyBean();
        creditApplyBean.setTerminalid(terminalid);
        creditApplyBean.setProductid(productid);
        creditApplyBean.setUserid(userid);
        creditApplyBean.setFinanceid(financeInfoBean.getId());

        logger.info(msgInfo + "构建准入开始，");
        // 查找用户是否有历史准入信息，更新为禁用状态
        ProductUserAccessBean accessBean = productUserAccessService.getLastByUseridAndProductId(userid, productid, terminalid);
        if (accessBean != null) {
            productUserAccessService.updateAccessDisable(accessBean.getId());
        }
        UserAccountVO userInfo = userResouceService.queryUserAccountVO(userid);
        if (userInfo == null) {
            throw new FinanceException("", "用户信息不存在");
        }
        IDCardVO iDCardVO = userResouceService.queryIDCardWithoutImage(userid, terminalid, creditApplyBean.getId());
        if (iDCardVO == null) {
            throw new FinanceException("", "身份证信息不存在");
        }
        // 做准入逻辑
        UserInfoVo userInfoVo = userResouceService.queryUserInfoVo(creditApplyBean.getId());
        if (null == userInfoVo) {
            logger.error("用户信息不存在, " + msgInfo);
            commonServiceHelper.updateCreditApplyBeanRemark(creditApplyBean.getId(), "联系人信息不存在");
            loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.CREDITBACK, creditApplyBean.getUserid(), creditApplyBean
                    .getProductid(), null, null, creditApplyBean.getId(), null, 0, null, 1, null, creditApplyBean.getTerminalid());
            throw new ApiException(ApiErrorEnum.COMMON_DATA_ERROR.getCode(), "用户信息UserInfo不存在" + msgInfo);
        }
        ${className}UserCheckLoanReq req = new ${className}UserCheckLoanReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
		Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
		String clientProductId = ${className}ProductParamsMapHelper.getClientProductId(productParamsMap);
		if (StringUtils.isBlank(clientProductId)) {
			clientProductId = Constants.${classNameUpper}_PRODUCT_ID;
		}
        req.setProductId(clientProductId);
        req.setMobile(userInfoVo.getMobile());
        ${className}UserCheckLoanRsp result;
        FinanceApiRequest<${className}UserCheckLoanReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                        .commonRequest(apiReq, ${className}UserCheckLoanRsp.class, ${className}TransCode.TRANSCODE_USER_CHECKLOAN);
        ProductUserAccessBean productUserAccessBean = commonServiceHelper.initProductUserAccessBean(creditApplyBean);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            if (${className}CheckLoanEnum.CHECK_LOAN_YES.getCode() != result.getCheckLoan()) {
                /** 准入状态：1通过，2不通过，3拒绝 */
                productUserAccessBean.setAccessstatus(Integer.parseInt(CommonEnum.PRODUCT_USER_ACCESS_ACCESSSTATUS_RETURN.getCode()));
                /** 准入有效期: */
                productUserAccessBean.setValidtime(null);
                /** 是否有效：1有效，0无效 */
                productUserAccessBean.setEnabled(Integer.parseInt(CommonEnum.NO.getCode()));
                productUserAccessBean.setRemark("准入失败");
            }
        }
        // 查询产品关联的资方API请求公共参数
        List<FinanceParamConfBean> financeParamConfBeanList = financeParamConfService
                .selectByBean(FinanceParamConfEnum.ACCESS.getCode(), productEnum.id, terminalid);
        if (financeParamConfBeanList != null && financeParamConfBeanList.size() > 0) {
            FinanceParamConfBean financeParamConfBean = financeParamConfService
                    .findBeanByCode(FinanceCommonParamEnum.PCODE_VALIDATION.getCode(), financeParamConfBeanList);
            if (financeParamConfBean != null) {
                int num = 3; // 期限，默认3月
                try {
                    num = Integer.parseInt(financeParamConfBean.getPvallue());
                } catch (Exception e) {
                }
                int numUnit = Integer.parseInt(CommonEnum.CREDIT_INFO_PERIODUNIT_DAY.getCode());// 期限单位;
                try {
                    numUnit = Integer.parseInt(financeParamConfBean.getPlanid());
                } catch (Exception e) {
                }
                /** 准入有效期:计算 */
                productUserAccessBean.setValidtime(DateUtils.addDate(new Date(), num, numUnit));
            }
        }
        return productUserAccessBean;
    }
    
    public void bindCreditCard(String params, String userid, String terminalid,String productid) {
    	UserBankCardVO bankCard = JSON.parseObject(params, UserBankCardVO.class);
    	bankCard.setBanktype(UserBankTypeEnum.CREDIT.val);
    	String orderid = JSON.parseObject(params).getString("orderid");
    	String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(userid, productid, orderid, terminalid);
    	String errMsg;
    	if(StringUtils.isEmpty(flowId)) {
    		errMsg = "用户未注册，不能绑卡";
    		logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,errMsg);
    		throw new FinanceException("",errMsg);
    	}
    	UserInfoVo userInfoVo = userResouceService.queryUserInfoVo(userid);
    	if(userInfoVo == null) {
    		errMsg = "用户不存在";
    		logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,errMsg);
    		throw new FinanceException("",errMsg);
    	}
    	String bankCode = productParamRelService.selectCodeByProductidAndSysCode(productid, SystemParamTypeEnum.OPENBANK.val,
				bankCard.getBankcode(), terminalid);
    	
    	${className}UserBindCreditCardReq req = new ${className}UserBindCreditCardReq();
		req.setFlowId(flowId);
		req.setBankCode(bankCode);
		req.setCardMobile(userInfoVo.getUsername());
		req.setCardNo(bankCard.getBanknumber());
    	${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper.buildReqHeader(terminalid, userid);
        req.setHeader(${className}ReqHeader);
        
    	FinanceApiRequest<${className}UserBindCreditCardReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
    	${className}UserBindCreditCardRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                        .commonRequest(apiReq, ${className}UserBindCreditCardRsp.class, ${className}TransCode.TRANSCODE_USER_BINDCREDITCARD);
    	int resCode = result.getHeader().getCode();
		if (${className}CodeStatusEnum.SUCCESS.getCode() == resCode && StringUtils.isNotEmpty(result.getCardId())) {
			bankCard.setBankid(result.getCardId());
			bankCard.setPhone(req.getCardMobile());
			String thirdBankCode = bankCode;
			SystemParamConfBean systemParamConfBean = systemParamConfService.queryByServiceTypeAndCode(SystemParamTypeEnum.OPENBANK.val, 
					productid,BankTypeEnum.DEBIT_CARD.getCode().toString(), thirdBankCode, terminalid);
			String iconUrl = systemParamConfBean.getIconurl();
			bankCard.setBanklogo(iconUrl);
			bankCard.setBankicon(iconUrl);
			BaseParamBean baseParamBean = new BaseParamBean(userid, orderid, productid, terminalid);
			depositBankService.saveDepositBankInfo(bankCard, baseParamBean);
		} else {
			logger.error(LogTemplate.LOG_TEMPLATE, userid, "信用卡绑定出现异常：" + result.getHeader().getMsg());
			throw new FinanceException("","绑卡异常");
		} 
    }
    
    public UserBankCardVO getCreditCard(String orderid, String userid, String terminalid,String productid) {
    	BaseParamBean baseParamBean = new BaseParamBean(userid, orderid, productid, terminalid);
    	return depositBankService.getDepositBankInfo(baseParamBean, BankTypeEnum.CREDIT_CARD.getCode());
    }

	public void syncDebitCard(String orderid, String userid, String terminalid, String productid) {
		String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(userid, productid, orderid, terminalid);
		String errMsg;
		if(StringUtils.isEmpty(flowId)) {
    		errMsg = "用户未注册，不能同步绑卡";
    		logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,errMsg);
    		throw new FinanceException("",errMsg);
    	}
		${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper.buildReqHeader(terminalid, userid);
		${className}UserCardListReq req = new ${className}UserCardListReq();
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);
		req.setCardType(${className}CardTypeEnum.DEBIT_CARD.getCardType());
        
    	FinanceApiRequest<${className}UserCardListReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
    	${className}UserCardListRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                        .commonRequest(apiReq, ${className}UserCardListRsp.class, ${className}TransCode.TRANSCODE_USER_CARDLIST);
    	int resCode = result.getHeader().getCode();
		if (${className}CodeStatusEnum.SUCCESS.getCode() == resCode) {
			if(StringUtils.isNotBlank(result.getCardId())) {
				UserBankCardVO bankCard = new UserBankCardVO();
				bankCard.setBanktype(UserBankTypeEnum.CARD.val);
				bankCard.setBanknumber(result.getCardNo());
				bankCard.setBankname(result.getBankName());
				bankCard.setBankid(result.getCardId());
				bankCard.setId(result.getCardId());
				String thirdBankCode = result.getBankCode();
				SystemParamConfBean systemParamConfBean = systemParamConfService
						.queryByServiceTypeAndCode(SystemParamTypeEnum.OPENBANK.val, productid, BankTypeEnum.DEBIT_CARD.getCode().toString(), thirdBankCode, terminalid);
				String iconUrl = systemParamConfBean.getIconurl();
				bankCard.setBanklogo(iconUrl);
				bankCard.setBankicon(iconUrl);
				BaseParamBean baseParamBean = new BaseParamBean(userid, orderid, productid, terminalid);
				depositBankService.saveDepositBankInfo(bankCard, baseParamBean);
			}else{
				errMsg = "用户未注册，未同步到银行卡信息";
				logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,errMsg);
			}
		}
		// 资方接口错误打印日志信息
		logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,resCode+":"+ result.getHeader().getMsg());
	}

	public String getWithdrawOrRepayReturnUrl(String terminalId) {
		String redirecturl = null;
		SystemParamConfBean config = systemParamConfService.queryByServiceTypeAndCode(SystemParamTypeEnum.PAGELIST.val,
				CommonEnumConstant.URL_${classNameUpper}_WITHDRAW_REDIRECT, terminalId);
		if(config != null && StringUtils.isNotBlank(config.getPvalue())) {
			redirecturl = config.getPvalue();
		}
		return redirecturl;
	}
	
	public void successWithdrawApply(CreditApplyBean bean,CreditInfoBean creditInfoBean,${className}ApproveInfo approveInfo) {
		String orderid = bean.getId();
		Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
		String loanPurpose = ${className}ProductParamsMapHelper.getLoanIntention(productParamsMap);
		
		//增加提现申请信息
		int status = Integer.parseInt(CommonEnum.WITHDRAW_APPLY_STATUS_APPLYING.getCode());
		String remark = "${log_finance_name}提现申请中";
		this.saveWithdrawInfo(bean, creditInfoBean, approveInfo, status, loanPurpose, remark);
		// 更新授信申请表状态及流程
		flowService.successFlow(orderid, null, FlowEnum.FIXED_WITHDRAW_APPLY.getId(), null, null);
		logger.info("保存申请订单结束 | orderId={}",orderid);
	}
	
	public void failWithdrawApply(CreditApplyBean bean,CreditInfoBean creditInfoBean,${className}ApproveInfo approveInfo) {
		String orderid = bean.getId();
		String userid = bean.getUserid();
		String productid = bean.getProductid();
		String terminalid = bean.getTerminalid();
		Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
		String loanPurpose = ${className}ProductParamsMapHelper.getLoanIntention(productParamsMap);
		//增加提现申请信息
		int status = Integer.parseInt(CommonEnum.WITHDRAW_APPLY_STATUS_FAIL.getCode());
		String remark = "${log_finance_name}提现申请失败";
		this.saveWithdrawInfo(bean, creditInfoBean, approveInfo, status, loanPurpose, remark);
		logger.info("保存提现申请失败订单结束 | orderId={}",orderid);
		// 更新授信申请表状态及流程
		loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.WITHDREWFAIL,userid, productid,null, null, orderid ,null,1, null,1,null, terminalid);
		flowService.rejectFlow(orderid, null, FlowEnum.COMM_LENDED.getId(),ApplyStatusEnum.WITHDRAWFAIL.getCode(), null, null);

	}
	
	public void successWithdraw(WithdrawApplyBean withdrawApplyBean,List<${className}RepayPlan> repayPlanList) {
		String orderid = withdrawApplyBean.getOrderid();
		String terminalid = withdrawApplyBean.getTerminalid();
		String productid = withdrawApplyBean.getProductid();
		String userid = withdrawApplyBean.getUserid();
		// 更新提现申请记录 -- 提现成功
		withdrawApplyBean.setStagecode(FlowEnum.BASE_REPAY.getId());
		withdrawApplyBean.setStatus(Integer.parseInt(CommonEnum.WITHDRAW_APPLY_STATUS_SUCCESS.getCode()));
		withdrawApplyBean.setLendtime(new Date());
		withdrawApplyBean.setIscomplete(TwoKeyValues.Y_NUM);
		withdrawApplyService.updateByPrimaryKeySelective(withdrawApplyBean);
		String billId = ${className}BillServiceHelper.saveInitBillInfo(withdrawApplyBean, repayPlanList);
		// 更新授信申请表状态及流程
		flowService.successFlow(orderid, billId, FlowEnum.COMMON_WITHDRAW_CHECK.getId(), ApplyStatusEnum.WITHDRAWSUCCESS.getCode(), null);
		logger.info("放款成功，订单业务正常流转| orderId={}", orderid);
	}
	
	public void failWithdraw(WithdrawApplyBean withdrawApplyBean) {
		String orderid = withdrawApplyBean.getOrderid();
		String terminalid = withdrawApplyBean.getTerminalid();
		String productid = withdrawApplyBean.getProductid();
		String userid = withdrawApplyBean.getUserid();
		// 更新提现申请记录 -- 提现失败
		withdrawApplyBean.setStagecode(FlowEnum.COMM_LENDED.getId());
		withdrawApplyBean.setStatus(Integer.parseInt(CommonEnum.WITHDRAW_APPLY_STATUS_FAIL.getCode()));
		withdrawApplyBean.setLendtime(new Date());
		withdrawApplyBean.setIscomplete(TwoKeyValues.Y_NUM);
		withdrawApplyService.updateByPrimaryKeySelective(withdrawApplyBean);
		// 更新授信申请表状态及流程
		loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.WITHDREWFAIL,userid, productid,null, null, orderid ,null,1, null,1,null, terminalid);
		flowService.rejectFlow(orderid, null, FlowEnum.COMM_LENDED.getId(),ApplyStatusEnum.WITHDRAWFAIL.getCode(), null, null);
	
	}
	
	
	
	private void saveWithdrawInfo(CreditApplyBean bean,CreditInfoBean creditInfoBean,${className}ApproveInfo approveInfo,int status,String loanPurpose,String remark) {
		String orderid = bean.getId();
		String terminalid = bean.getTerminalid();
		String productid = bean.getProductid();
		String userid = bean.getUserid();
		String creditid = creditInfoBean.getId();
		BigDecimal creditamount = creditInfoBean.getTotallimit();
		String periodunit = CommonEnum.CREDIT_INFO_PERIODUNIT_MONTH.getCode();
		BigDecimal applyAmount = UnitConversionUtil.fenToYuan(approveInfo.getApplyAmount());
		// 查询提现配置
		int period = approveInfo.getApprovePeriods();
		// 增加提现申请信息
		WithdrawApplyBean withdrawApplyBean = new WithdrawApplyBean();
		withdrawApplyBean.setId(HNUtil.getId());
		withdrawApplyBean.setTerminalid(terminalid);
		withdrawApplyBean.setUserid(userid);
		withdrawApplyBean.setProductid(productid);
		withdrawApplyBean.setOrderid(orderid);
		withdrawApplyBean.setCreditid(creditid);
		withdrawApplyBean.setCreditamount(creditamount);
		withdrawApplyBean.setApplyamount(applyAmount);
		withdrawApplyBean.setPeriod(period);
		withdrawApplyBean.setPeriodunit(periodunit);
		withdrawApplyBean.setIscomplete(TwoKeyValues.N_NUM);
		withdrawApplyBean.setIssync(TwoKeyValues.N_NUM);
		withdrawApplyBean.setStatus(status);
		withdrawApplyBean.setStagecode(FlowEnum.FIXED_WITHDRAW_APPLY.getId());
		withdrawApplyBean.setApplytime(new Date());
		withdrawApplyBean.setRemark(remark);
		withdrawApplyBean.setPurposecode(loanPurpose);// 用途
		// 保存提现申请记录
		withdrawApplyService.save(withdrawApplyBean, null, withdrawApplyBean.getApplytime());
	}
    
}
