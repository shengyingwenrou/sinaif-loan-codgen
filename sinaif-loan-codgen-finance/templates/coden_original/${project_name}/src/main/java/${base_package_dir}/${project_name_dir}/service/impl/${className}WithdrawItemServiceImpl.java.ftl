<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.sinaif.king.common.TwoKeyValues;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.finance.api.FinanceProcessorFactory;
import com.sinaif.king.finance.service.item.helper.CommonFinaServItemHelper;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyComputeRepayPlanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}LoanGetLoanUrlReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyComputeRepayPlanRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}LoanGetLoanUrlRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}ApproveInfo;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BizFinanceRefServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.finance.${classNameLower}.utils.UnitConversionUtil;
import com.sinaif.king.gateway.withdraw.item.WithdrawItemService;
import com.sinaif.king.gateway.withdraw.item.impl.AbstractWithdrawItemService;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.product.ProductFeeResult;
import com.sinaif.king.model.finance.request.FinanceApiRequest;
import com.sinaif.king.model.finance.withdraw.WithdrawApplyPreResultBean;
import com.sinaif.king.model.finance.withdraw.apply.ReplaymentPlanTrialReqVO;
import com.sinaif.king.model.finance.withdraw.apply.ReplaymentPlanTrialResultVO;
import com.sinaif.king.model.finance.withdraw.apply.WithdrawApplyInitBean;
import com.sinaif.king.model.finance.withdraw.apply.WithdrawApplyVO;
import com.sinaif.king.model.finance.withdraw.apply.WithdrawVO;
import com.sinaif.resources.client.utils.DateUtils;


<#include "/java_imports.include" />
@Service
public class ${className}WithdrawItemServiceImpl extends AbstractWithdrawItemService implements WithdrawItemService {
	private final static Logger logger = LoggerFactory.getLogger(${className}WithdrawItemServiceImpl.class);

	@Autowired
	protected FinanceProcessorFactory factory;
	@Autowired
	protected ${className}BusinessServiceHelper ${className}BusinessServiceHelper;
    @Autowired
    private FinanceProcessorFactory financeProcessorFactory;
    @Autowired
    private ${className}BizFinanceRefServiceHelper ${className}BizFinanceRefServiceHelper;

	@Autowired
	private CommonFinaServItemHelper commonHelper;

    @Override
    public ProductEnum getServiceName() {
        return ProductEnum.${classNameUpper};
    }

    @Override
	public WithdrawApplyPreResultBean withdrawApplyPre(WithdrawApplyVO vo) {
    	WithdrawApplyPreResultBean preResultBean = new WithdrawApplyPreResultBean();
		String userid = vo.getUserid();
		String productid = vo.getProductid();
		String orderid = vo.getOrderid();
		String terminalid = vo.getTerminalid();
		String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(userid, productid, orderid, terminalid);
		${className}LoanGetLoanUrlReq req = new ${className}LoanGetLoanUrlReq();
        req.setHeader(${className}BusinessServiceHelper.buildReqHeader(vo.getTerminalid(), vo.getUserid()));
        req.setFlowId(flowId);
        String redirectUrl = ${className}BusinessServiceHelper.getWithdrawOrRepayReturnUrl(terminalid);
        req.setRedirectUrl(redirectUrl);

        FinanceApiRequest<${className}LoanGetLoanUrlReq> apiRequest = new FinanceApiRequest<>(vo.getProductid(), req);
        ${className}LoanGetLoanUrlRsp result = financeProcessorFactory.getProcesser(ProductEnum.getById(vo.getProductid()))
                                                              .getCommonApiService()
                                                              .commonRequest(apiRequest, ${className}LoanGetLoanUrlRsp.class, ${className}TransCode.TRANSCODE_LOAN_GETLOANURL);
        if (Constants.SUCCESS.equals(result.getHeader().getCode())) {

			String loanUrl = result.getLoanUrl();
			final String encodeLoanUrl = commonHelper.updateUrl4ThirdUrl(loanUrl);

			preResultBean.setPageForward(encodeLoanUrl);
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "${log_finance_name}要款地址:" + result.getLoanUrl());
		} else {
            logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"${log_finance_name}要款地址异常：" + result.getHeader().getMsg());
            throw new ApiException(Integer.valueOf(result.getHeader().getCode()), result.getHeader().getMsg());
        }
		return preResultBean;
	}

    @Override
    public void saveWithdrawApply(WithdrawApplyVO vo) {
    	
    }


    @Override
    public List<ReplaymentPlanTrialResultVO> repaymentPlanTrial(ReplaymentPlanTrialReqVO vo) {
    	String userid = vo.getUserid();
		String orderid = vo.getOrderid();
		String productid = vo.getProductid();
		String terminalid = vo.getTerminalid();
		
		${className}ApplyComputeRepayPlanReq req = new ${className}ApplyComputeRepayPlanReq();
		String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(userid, productid, orderid, terminalid);
		if (StringUtils.isBlank(flowId)) {
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid,"此用户未注册");
			return null;
		}
		${className}ReqHeader ${className}ReqHeader = ${className}BizFinanceRefServiceHelper.buildReqHeader(terminalid, userid);
		req.setHeader(${className}ReqHeader);
		req.setFlowId(flowId);
		
		FinanceApiRequest<${className}ApplyComputeRepayPlanReq> apiReq = new FinanceApiRequest<>(productid, req);
		${className}ApplyComputeRepayPlanRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
				.commonRequest(apiReq, ${className}ApplyComputeRepayPlanRsp.class, ${className}TransCode.TRANSCODE_APPLY_COMPUTEREPAYPLAN);
		if (result == null || CollectionUtils.isEmpty(result.getRepayPlans())) { //未收到三方接口具体返回信息
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid,"试算接口返回值为空");
			return null;
		}
		List<${className}RepayPlan> repayPlan = result.getRepayPlans();
		List<ReplaymentPlanTrialResultVO> resultList = new ArrayList<>(repayPlan.size());
    	ReplaymentPlanTrialResultVO repayVo;
    	for(${className}RepayPlan simplePlan : repayPlan ) {
    		repayVo = new ReplaymentPlanTrialResultVO();
    		BigDecimal amount = UnitConversionUtil.fenToYuan(simplePlan.getPlanRepayAmount());
    		BigDecimal capital = UnitConversionUtil.fenToYuan(simplePlan.getPlanRepayPrincipal());
    		BigDecimal interest = UnitConversionUtil.fenToYuan(simplePlan.getPlanRepayFee());
    		repayVo.setAmount(amount);        //还款总金额
    		repayVo.setPrincipal(capital);    //本金
            repayVo.setInterest(interest);        //利息
            repayVo.setMonthRate(null);                //
            repayVo.setPayDate(DateUtils.string2Date(simplePlan.getPlanRepayDate(), DateUtils.DATE_FORMAT_12).getTime()+"");        //还款日
            repayVo.setTotalFee(BigDecimal.ZERO);        //服务费
            repayVo.setPeriod(simplePlan.getPeriod());
            resultList.add(repayVo);
    	}
        return resultList;
		
    }
    
  

    @Override
    public void withdrawApplyInit(WithdrawVO vo, WithdrawApplyInitBean withdrawApplyInitBean) {
    	String orderid = vo.getOrderid();
    	String userid = vo.getUserid();
    	String terminalid = vo.getTerminalid();
    	String productid = vo.getProductid();
    	${className}BusinessServiceHelper.syncDebitCard(orderid, userid, terminalid, productid);
    	CreditApplyBean creditApplyBean = new CreditApplyBean();
    	creditApplyBean.setUserid(userid);
    	creditApplyBean.setId(orderid);
    	creditApplyBean.setProductid(productid);
    	creditApplyBean.setTerminalid(terminalid);;
    	${className}ApproveInfo approveInfo = ${className}BizFinanceRefServiceHelper.getApproveInfo(creditApplyBean);
    	if(approveInfo != null) {
    		JSONObject json = withdrawApplyInitBean.getExtendInfo();
    		if(json == null) {
    			json = new JSONObject();
    		}
    		json.put("planInsuranceAmount", UnitConversionUtil.fenToYuan(approveInfo.getPlanInsuranceAmount()));
    		withdrawApplyInitBean.setExtendInfo(json);
    	}
    	try {
			List<ProductFeeResult> feeItems = withdrawApplyInitBean.getFeeItem();
			if(feeItems.size() == 1) {
				ProductFeeResult fee = feeItems.get(0);
				fee.getProductFeeList().get(0).setIsdefault(TwoKeyValues.YES_NUM);
			}
			
		} catch (Exception e) {
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"未配置费率信息");
		}
    	
    }

	@Override
	protected void withdrawApplyPreItem(WithdrawApplyVO vo, WithdrawApplyPreResultBean preResultBean) {
		// TODO Auto-generated method stub
		
	}
}
