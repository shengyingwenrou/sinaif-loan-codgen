<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.callback;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.enums.${className}ApplyStatusEnum;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}ApproveInfo;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BizFinanceRefServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.credit.CreditInfoBean;
import com.sinaif.king.model.finance.withdraw.WithdrawApplyBean;
import com.sinaif.king.service.app.AppIncreaseTrustUserBeanService;
import com.sinaif.king.service.bill.BillInfoService;
import com.sinaif.king.service.credit.CreditApplyService;
import com.sinaif.king.service.credit.CreditInfoService;
import com.sinaif.king.service.data.UserResouceService;
import com.sinaif.king.service.flow.info.FlowProductStepService;
import com.sinaif.king.service.flow.info.FlowStepRecordService;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;
import com.sinaif.king.service.withdraw.WithdrawApplyService;

<#include "/java_imports.include" />
@Service
public class ${className}CallBackManager {

    private Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    protected AppIncreaseTrustUserBeanService appIncreaseTrustUserService;
    @Autowired
    private LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;
    @Autowired
    private BillInfoService billInfoService;
    @Autowired
    private ${className}BusinessServiceHelper ${classNameLower}BusinessServiceHelper;
    @Autowired
    private CreditInfoService creditInfoService;
    @Autowired
    private WithdrawApplyService withdrawApplyService;
    @Autowired
    private CreditApplyService creditApplyService;
    @Autowired
    private FlowProductStepService flowProductStepService;
    @Autowired
    private FlowStepRecordService flowStepRecordService;
    @Autowired
    private UserResouceService userResouceService;
    @Autowired
    private ${className}BizFinanceRefServiceHelper ${classNameLower}BizFinanceRefServiceHelper;

	public void dealCallback(String flowId, int orderStatus) {
		${className}ApplyStatusEnum applyStatusEnum = ${className}ApplyStatusEnum.getByCode(orderStatus);
		if (applyStatusEnum == null) {
			logger.error(LogTemplate.LOG_TEMPLATE, flowId, "??????????????????????????????" + orderStatus);
			throw new FinanceException("","??????????????????????????????" + orderStatus);
		}
		String orderid = ${classNameLower}BizFinanceRefServiceHelper.getOrderIdByFlowId(flowId);
		if (orderid == null) {
			logger.error(LogTemplate.LOG_TEMPLATE, flowId, "???????????????????????????");
			throw new FinanceException("","???????????????????????????:"+flowId);
		}
		CreditApplyBean creditApplyBean = creditApplyService.getbyId(orderid);
		if (creditApplyBean == null) {
			logger.error(LogTemplate.LOG_TEMPLATE, flowId, "??????????????????????????????");
			throw new FinanceException("","??????????????????????????????");
		}
		String userid = creditApplyBean.getUserid();
		
		switch (applyStatusEnum) {
		case CHECKING:
		case CHECK_FAIL:
		case CHECK_SUCESS:
		case CREDITBACK:
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"??????????????????????????????????????????????????????????????????");
			return;
		case CLEAR://??????
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"????????????????????????????????????????????????????????????-????????????");
			return;
		case CREDIT_LIMTI_EXPIRE:
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"??????????????????????????????????????????????????????????????????");
			return;
		case LOAN_SUCESS:// ????????????
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"??????????????????????????????????????????????????????????????????");
			return;
		default:
			break;
		}
		${className}ApproveInfo approveInfo = ${classNameLower}BizFinanceRefServiceHelper.getApproveInfo(creditApplyBean);
		CreditInfoBean creditInfoBean = creditInfoService.getbyOrderid(orderid, creditApplyBean.getTerminalid());
		if (creditInfoBean == null) {
			logger.error("?????????????????????????????????????????????????????????| orderId={}", orderid);
			CreditInfoBean creditInfoParams = new CreditInfoBean();
			creditInfoParams.setOrderid(orderid);
			List<CreditInfoBean> creditInfoBeanList = creditInfoService.selectByBean(creditInfoParams);
			if (!CollectionUtils.isEmpty(creditInfoBeanList)) {
				creditInfoBean = creditInfoBeanList.get(0);
			}
		}
		WithdrawApplyBean withdrawApplyBean = withdrawApplyService.getbyOrderid(orderid);
		if(applyStatusEnum == ${className}ApplyStatusEnum.WITHDRAWAUDIT) {//?????????
			if(withdrawApplyBean == null) {
				${classNameLower}BusinessServiceHelper.successWithdrawApply(creditApplyBean, creditInfoBean, approveInfo);
			}
			return;
		}
		if(applyStatusEnum == ${className}ApplyStatusEnum.CANCLE) {//??????
			if(withdrawApplyBean == null) {
				${classNameLower}BusinessServiceHelper.failWithdrawApply(creditApplyBean, creditInfoBean, approveInfo);
			}else {
				${classNameLower}BusinessServiceHelper.failWithdraw(withdrawApplyBean);
			}
			return;
		}
	}
}
