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
			logger.error(LogTemplate.LOG_TEMPLATE, flowId, "未找到对应的状态码：" + orderStatus);
			throw new FinanceException("","未找到对应的状态码：" + orderStatus);
		}
		String orderid = ${classNameLower}BizFinanceRefServiceHelper.getOrderIdByFlowId(flowId);
		if (orderid == null) {
			logger.error(LogTemplate.LOG_TEMPLATE, flowId, "未找到对应的订单号");
			throw new FinanceException("","未找到对应的订单号:"+flowId);
		}
		CreditApplyBean creditApplyBean = creditApplyService.getbyId(orderid);
		if (creditApplyBean == null) {
			logger.error(LogTemplate.LOG_TEMPLATE, flowId, "未找到对应的订单信息");
			throw new FinanceException("","未找到对应的订单信息");
		}
		String userid = creditApplyBean.getUserid();
		
		switch (applyStatusEnum) {
		case CHECKING:
		case CHECK_FAIL:
		case CHECK_SUCESS:
		case CREDITBACK:
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"接收到审批阶段的回调，不处理，有定时任务处理");
			return;
		case CLEAR://结清
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"接收到还清的回调，不处理，有定时任务处理-账单同步");
			return;
		case CREDIT_LIMTI_EXPIRE:
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"接收到额度失效的回调，不处理，系统会自动处理");
			return;
		case LOAN_SUCESS:// 提现成功
			logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"接收到提现成功的回调，不处理，系统会自动处理");
			return;
		default:
			break;
		}
		${className}ApproveInfo approveInfo = ${classNameLower}BizFinanceRefServiceHelper.getApproveInfo(creditApplyBean);
		CreditInfoBean creditInfoBean = creditInfoService.getbyOrderid(orderid, creditApplyBean.getTerminalid());
		if (creditInfoBean == null) {
			logger.error("获取授信信息为空，可能授信记录已过期！| orderId={}", orderid);
			CreditInfoBean creditInfoParams = new CreditInfoBean();
			creditInfoParams.setOrderid(orderid);
			List<CreditInfoBean> creditInfoBeanList = creditInfoService.selectByBean(creditInfoParams);
			if (!CollectionUtils.isEmpty(creditInfoBeanList)) {
				creditInfoBean = creditInfoBeanList.get(0);
			}
		}
		WithdrawApplyBean withdrawApplyBean = withdrawApplyService.getbyOrderid(orderid);
		if(applyStatusEnum == ${className}ApplyStatusEnum.WITHDRAWAUDIT) {//提现中
			if(withdrawApplyBean == null) {
				${classNameLower}BusinessServiceHelper.successWithdrawApply(creditApplyBean, creditInfoBean, approveInfo);
			}
			return;
		}
		if(applyStatusEnum == ${className}ApplyStatusEnum.CANCLE) {//取消
			if(withdrawApplyBean == null) {
				${classNameLower}BusinessServiceHelper.failWithdrawApply(creditApplyBean, creditInfoBean, approveInfo);
			}else {
				${classNameLower}BusinessServiceHelper.failWithdraw(withdrawApplyBean);
			}
			return;
		}
	}
}
