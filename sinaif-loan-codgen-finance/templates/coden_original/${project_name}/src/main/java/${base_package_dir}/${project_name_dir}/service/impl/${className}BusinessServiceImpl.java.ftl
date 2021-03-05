<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import com.sinaif.king.common.ErrorCode;
import com.sinaif.king.common.utils.DateUtils;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.common.CommonEnum;
import com.sinaif.king.enums.common.FinanceBusinessRouterEnum;
import com.sinaif.king.enums.common.LoanProgressTypeEnum;
import com.sinaif.king.enums.finance.ApplyStatusEnum;
import com.sinaif.king.enums.finance.flow.FlowEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.service.IFinanceBusinessService;
import com.sinaif.king.finance.service.base.FinanceBusinessService;
import com.sinaif.king.finance.service.item.helper.CreditFinaServItemHelper;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import com.sinaif.king.finance.${classNameLower}.enums.${className}ApplyStatusEnum;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyQuery2Rsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}SupplementInfo;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BillServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BizFinanceRefServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}CreditApplyFailHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}CreditApplyProcessHelper;
import com.sinaif.king.finance.${classNameLower}.utils.UnitConversionUtil;
import com.sinaif.king.model.finance.bill.BillInfoBean;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.credit.CreditInfoBean;
import com.sinaif.king.model.finance.data.vo.BasicInfoVO;
import com.sinaif.king.model.finance.data.vo.IDCardVO;
import com.sinaif.king.model.finance.data.vo.UserBankCardVO;
import com.sinaif.king.model.finance.data.vo.UserInfoVo;
import com.sinaif.king.model.finance.repay.RepayApplyBean;
import com.sinaif.king.model.finance.withdraw.WithdrawApplyBean;
import com.sinaif.king.model.finance.withdraw.apply.WithdrawApplyVO;
import com.sinaif.king.service.data.PhoneOperatorService;
import com.sinaif.king.service.data.UserResouceService;
import com.sinaif.king.service.flow.item.FlowService;
import com.sinaif.king.service.loan.LoanProgressBeanService;

<#include "/java_imports.include" />
@Service
public class ${className}BusinessServiceImpl extends FinanceBusinessService implements IFinanceBusinessService {

    @Autowired
    private UserResouceService userResouceService;
    @Autowired
    private LoanProgressBeanService loanProgressBeanService;
    @Autowired
    private FlowService<Void, Void, Void> flowService;
    @Autowired
    private ${className}BusinessServiceHelper ${className}BusinessServiceHelper;
	@Autowired
	protected PhoneOperatorService phoneOperatorService;
    @Autowired
    private ${className}BizFinanceRefServiceHelper ${className}BizFinanceRefServiceHelper;
    @Autowired
    private ${className}CreditApplyProcessHelper ${className}CreditApplyProcessHelper;
    @Autowired
    private ${className}BillServiceHelper ${className}BillServiceHelper;
    @Autowired
    private ${className}CreditApplyFailHelper ${className}CreditApplyFailHelper;
    @Autowired
    protected CreditFinaServItemHelper creditHelper;

    @Override
    public void loanApply(CreditApplyBean creditApplyBean) throws FinanceException {

        if (null == creditApplyBean) {
            logger.error("【${log_finance_name}】进件订单信息为空");
            return;
        }

        String orderid = creditApplyBean.getId();
        String userid = creditApplyBean.getUserid();
        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, userid, orderid,"开始");

        logger.info(msgInfo);

        // 送件前订单状态判断判断
        if (!FlowEnum.FIXED_CREDIT_SEND.getId().equals(creditApplyBean.getStagecode()) &&
                !FlowEnum.COMM_CREDIT_SUBMIT.getId().equals(creditApplyBean.getStagecode())) {
            logger.info(msgInfo + "送件前订单状态判断不在进件范围内");
           return;
        }

        try {
            UserInfoVo userInfoVo = userResouceService.queryUserInfoVo(creditApplyBean.getUserid());
            if (null == userInfoVo) {
                logger.error(msgInfo + "用户信息不存在");
                ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,"联系人信息不存在");
                return;
            }

            String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(creditApplyBean.getUserid(), creditApplyBean.getProductid(),
                    creditApplyBean.getId(), creditApplyBean.getTerminalid());

            // 进件前-用户申请资格检查
            boolean userCheckLoanResult;
            if (StringUtils.isBlank(flowId)) {
                userCheckLoanResult = ${className}CreditApplyProcessHelper.userCheckLoan(creditApplyBean, userInfoVo);
            } else {
                userCheckLoanResult = true;
            }

            // 进件前-用户身份证信息检查 [无:返件身份证]
            IDCardVO cardBean  = userResouceService
                    .queryIDCardVO(creditApplyBean.getUserid(), creditApplyBean.getTerminalid(), creditApplyBean.getId());
            if (null == cardBean) {
                logger.error(msgInfo + "【${log_finance_name}】用户身份证记录不存在返件");
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户身份证记录不存在返件");
                return ;
            }

            String livingBestPhotoUrl = cardBean.getImageurl();
            if (StringUtils.isEmpty(livingBestPhotoUrl)) {
                ${className}CreditApplyFailHelper.returnIdcardVivo(creditApplyBean, "【${log_finance_name}】进件前活体图片为空返件");
                return;
            }

            if (!userCheckLoanResult) {
                return;
            } else {
                if (StringUtils.isBlank(flowId)) {
                    // 进件前-用户流程注册
                    flowId = ${className}CreditApplyProcessHelper.accessRegisterFlow(userInfoVo, creditApplyBean, cardBean);
                    if (StringUtils.isBlank(flowId)) {
                        return;
                    }else{
                        // 注册必走一次返件信用卡
                        List<String> itemnoList = Lists.newArrayList();
                        itemnoList.add(CommonEnum.${classNameUpper}_CREDITBANK_STEP_${classNameUpper}.getCode());
                        ${className}CreditApplyFailHelper.returnProcess(creditApplyBean, FlowEnum.FIXED_CREDIT_SEND, itemnoList, true, "【${log_finance_name}】信用卡返件，返件");
                        return;
                    }
                }else{
                    // 进件前-判断是否为资方补件场景[是的话直接走补件]
                    ${className}SupplementInfo supplementInfoOld = ${className}BizFinanceRefServiceHelper.getSupplementInfo(creditApplyBean);
                    logger.info("【${log_finance_name}】进件走资方补件开始 " + msgInfo);
                    if (null != supplementInfoOld) {
                        logger.info("【${log_finance_name}】进件走资方补件开始信息: " + JSON.toJSONString(supplementInfoOld));
                        Date lastSupplementTime = DateUtils.string2Date(supplementInfoOld.getSupplementExpireTime());
                        if (lastSupplementTime.before(new Date())) {
                            // 有效期过期,准入失效，终结状态扭转到额度失效
                            ${className}CreditApplyFailHelper.rejectToCreditInfoExpire(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"资方补件流程时补件有效时间过期，处理为额度失效");
                            logger.info("【${log_finance_name}】进件走资方补件流程是有效时间过期，处理为额度失效, " + msgInfo);
                            return;
                        } else {
                            // 有效期内走补件
                            ${className}CreditApplyProcessHelper.userSupplement(creditApplyBean, flowId, cardBean);
                            return;
                        }
                    }
                }
            }

            UserBankCardVO userCreditBankCardVO = ${className}BizFinanceRefServiceHelper.getCreditCard(creditApplyBean.getUserid(),
                    creditApplyBean.getProductid(),creditApplyBean.getTerminalid());

            if (null == userCreditBankCardVO) {
                // 进件前-判断是否绑定信用卡
                List<String> itemnoList = Lists.newArrayList();
                itemnoList.add(CommonEnum.${classNameUpper}_CREDITBANK_STEP_${classNameUpper}.getCode());
                ${className}CreditApplyFailHelper.returnProcess(creditApplyBean, FlowEnum.FIXED_CREDIT_SEND, itemnoList, true, "【${log_finance_name}】信用卡返件，返件");
                return ;
            }


            // 进件前-信息采集
            BasicInfoVO basicInfo = userResouceService
                    .queryBasicInfoVo(creditApplyBean.getUserid(), creditApplyBean.getTerminalid(), creditApplyBean.getId());
            if (null == basicInfo) {
                ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,"进件前-信息采集前,用户基本信息不存在");
                logger.error(msgInfo+ "用户基本信息不存在 " );
                return;
            }
            boolean uploadUserInfoCollectResult=${className}CreditApplyProcessHelper.uploadUserInfoCollect(creditApplyBean, flowId, basicInfo);

            if (!uploadUserInfoCollectResult) {
                return;
            }

            // 进件前-上传人脸识别检测
            boolean faceDetectImageResult = ${className}CreditApplyProcessHelper.faceDetectImage(creditApplyBean, flowId, cardBean);
            if (!faceDetectImageResult) {
                return;
            }

            boolean isPushCallSucess;

            // 进件前-查询是否有有效的通话详单
            boolean queryCallResult = ${className}CreditApplyProcessHelper.queryCall(creditApplyBean, flowId);

            if (!queryCallResult) {
                //进件前- 通话详单上传
                isPushCallSucess = ${className}CreditApplyProcessHelper.pushCall(creditApplyBean, flowId, cardBean.getCardno(), userInfoVo);
            }else{
                isPushCallSucess=true;
            }

            if (!isPushCallSucess) {
                return;
            }
            // 正式进件
            boolean userApply = ${className}CreditApplyProcessHelper.userApply(creditApplyBean, flowId, userCreditBankCardVO);
            if(userApply){
                ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,"正式进件成功");
                logger.info(LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),"进件成功");
            }

        }catch (ApiException e){
            logger.error(e.getMessage());
            //throw e;
        }catch (Exception e){
            logger.error(LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),e.getMessage());
            throw e;
        }
    }

    @Override
    public void loanApplyAgain(CreditApplyBean creditApplyBean) throws FinanceException {
        String orderid = creditApplyBean.getId();
        String message = "【${log_finance_name}】等待期到状态扭转";
        String msgInfo=String.format(LogTemplate.STR_FORMAT_LOG_PROCESS,creditApplyBean.getUserid(),creditApplyBean.getId(),message);
        logger.info(msgInfo);
        // 1、判断阶段是结果阶段、状态是等待期
        if (!FlowEnum.FIXED_CREDIT_RESULT.getId().equals(creditApplyBean.getStagecode())) {
            logger.info("阶段不正确，必须为【" + FlowEnum.FIXED_CREDIT_RESULT.getId() + "】，当前为【" + creditApplyBean.getStagecode()
                    + "】，订单ID【" + orderid + "】");
            return;
        }
        if (ApplyStatusEnum.WAITINGPERIOD.getCode() != creditApplyBean.getApplystatus().intValue()) {
            logger.info("状态不不正确，必须为【" + ApplyStatusEnum.WAITINGPERIOD.getCode() + "】，当前为【"
                    + creditApplyBean.getStagecode() + "】，订单ID【" + orderid + "】");
            return;
        }
        //保存进度
        loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.REAPPLYWAITED,creditApplyBean.getUserid(), creditApplyBean.getProductid(),null, null, orderid ,null,0, null,1,null, creditApplyBean.getTerminalid());
        flowService.returnFlow(orderid, null, FlowEnum.FIXED_CREDIT_RESULT.getId(), null, null, "过了等待期，状态扭转待补件");
        logger.info(message + " end, " + msgInfo);
    }

    @Override
    public void loanApplyProgress(CreditApplyBean creditApplyBean) throws FinanceException {
        if (creditApplyBean == null){
            logger.info("【${log_finance_name}】开户订单信息为空");
            return ;
        }
        String terminalid = creditApplyBean.getTerminalid();
        String productid = creditApplyBean.getProductid();
        String userid = creditApplyBean.getUserid();
        String orderid = creditApplyBean.getId();
        String msgInfo = String.format("【${log_finance_name}】用户id【%s】,订单号【%s】", userid, orderid);
        // 判断阶段步骤
        if (!FlowEnum.FIXED_CREDIT_SEND_RESULT.getId().equals(creditApplyBean.getStagecode())) {
            logger.info("【${log_finance_name}】进件结果查询阶段步骤【"+creditApplyBean.getStagecode()+"】不正确与【"+FlowEnum.FIXED_CREDIT_SEND_RESULT.getId()+ "】不匹配, " + msgInfo);
            throw new ApiException(ApiErrorEnum.COMMON_DATA_ERROR.getCode(),"【${log_finance_name}】进件结果查询阶段步骤 不是{100000010005}");
        }
        try {
            //进度查询
            logger.info("【${log_finance_name}】进件结果查询开始，" + msgInfo);
            WithdrawApplyVO vo=new WithdrawApplyVO();
            vo.setTerminalid(terminalid);
            vo.setUserid(userid);
            vo.setOrderid(orderid);
            vo.setProductid(productid);
            ${className}ApplyQuery2Rsp ${className}ApplyQuery2Rsp = ${className}CreditApplyProcessHelper.creditApplyQuery(orderid);
            if (null != ${className}ApplyQuery2Rsp) {
                if (${className}ApplyQuery2Rsp.getApplyStatus() == ${className}ApplyStatusEnum.CHECK_SUCESS.getCode()) {
                    long approveAmount = ${className}ApplyQuery2Rsp.getApproveAmount();
                    BigDecimal totalAmt = UnitConversionUtil.fenToYuan(approveAmount);
                    // 更新保存授信信息
                    logger.info(msgInfo + "执行登记借款人信息");
                    // 写入授信表信息t_credit_info
                    CreditInfoBean overWriteBean = new CreditInfoBean();
                    /**审批可用额度*/
                    overWriteBean.setTotallimit(totalAmt);
                    /**可用额度*/
                    overWriteBean.setAvailablelimit(totalAmt);
                    overWriteBean.setPeriodarea(String.valueOf(${className}ApplyQuery2Rsp.getApplyPeriods()));

                    int loanExpireTime = ${className}ApplyQuery2Rsp.getLoanExpireTime();

                    Long loanExpireTimeLong = loanExpireTime * 1000L;
                    Date loanExpireDate = new Date(loanExpireTimeLong);
                    overWriteBean.setEnddate(loanExpireDate);

                    //保存审批待用数据
                    ${className}BizFinanceRefServiceHelper.saveApproveInfo(${className}ApplyQuery2Rsp, creditApplyBean);
                    creditHelper.successCreditApplyResult(creditApplyBean, totalAmt, overWriteBean);

                    logger.info("【${log_finance_name}】送件结果查询结束, " + msgInfo);

                } else if (${className}ApplyQuery2Rsp.getApplyStatus() == ${className}ApplyStatusEnum.CHECK_FAIL.getCode()
                        || ${className}ApplyQuery2Rsp.getApplyStatus() == ${className}ApplyStatusEnum.CANCLE.getCode()) {

                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean, Constants.${classNameUpper}_SHOW_TIP_MSG, "【${log_finance_name}】送件结果查询审批被拒");

                } else if (${className}ApplyQuery2Rsp.getApplyStatus() == ${className}ApplyStatusEnum.CREDITBACK.getCode()) {

                    // 返件原因处理
                    if (null == ${className}ApplyQuery2Rsp.getSupplementList()) {
                        logger.info(msgInfo + "【${log_finance_name}】用户进件审批结果107时,资方需要的补件项为空");
                    }

                    // 默认返件身份证
                    logger.info(msgInfo + "【${log_finance_name}】用户进件审批结果107返件身份证");
                    ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户进件审批结果107返件身份证");

                    //查询是否历史返件过,更新相关信息
                    boolean isUpdate = false;
                    ${className}SupplementInfo supplementInfoOld = ${className}BizFinanceRefServiceHelper.getSupplementInfo(creditApplyBean);
                    if (null != supplementInfoOld) {
                        isUpdate = true;
                    }
                    if (!isUpdate) {
                        supplementInfoOld = new ${className}SupplementInfo();
                    }

                    int supplementExpireTime = ${className}ApplyQuery2Rsp.getSupplementExpireTime();
                    Long loanSupplementExpireTime = supplementExpireTime * 1000L;
                    Date expireTimeDate = new Date(loanSupplementExpireTime);
                    String strSupplementTime =DateUtils.dateToString(expireTimeDate,DateUtils.DEFAULT_FORMAT);
                    supplementInfoOld.setSupplementExpireTime(strSupplementTime);
                    ${className}BizFinanceRefServiceHelper.saveSupplementInfo(creditApplyBean, supplementInfoOld);
                    logger.info(msgInfo + "【${log_finance_name}】用户进件审批结果107返件身份证,更新补件SupplementInfo完毕");

                } else if (${className}ApplyQuery2Rsp.getApplyStatus() == ${className}ApplyStatusEnum.CREDIT_LIMTI_EXPIRE.getCode()) {
                    ${className}CreditApplyFailHelper.rejectToCreditInfoExpire(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"进件结果查询资方返回额度过期，处理为额度失效");
                    logger.info("【${log_finance_name}】进件结果查询资方返回额度过期，处理为额度失效" + msgInfo);
                } else {
                    logger.error("【${log_finance_name}】发送提现状态资方还在审批中applyStatus{}:", ${className}ApplyQuery2Rsp.getApplyStatus());
                }
            }
        } catch (Exception e) {
            logger.error("送件结果查询程序异常"+ msgInfo, e);
            throw new FinanceException(ErrorCode.SYSTEM_ERROR + "", e.getMessage());
        }
    }


    @Override
    public void sendWithdrawApply(WithdrawApplyBean withdrawApplyBean) throws FinanceException {

    }

    @Override
    public void loanMidRisk(CreditApplyBean creditApplyBean) throws FinanceException {

    }

    /* (non-Javadoc)
     * @see com.sinaif.king.finance.service.IFinanceBusinessService#withdrawApplyResultQuery(com.sinaif.king.model.finance.withdraw.WithdrawApplyBean)
     */
    @Override
    public void withdrawApplyResultQuery(WithdrawApplyBean withdrawApplyBean) throws FinanceException {
        String terminalid = withdrawApplyBean.getTerminalid();
        String userid = withdrawApplyBean.getUserid();
        String orderid = withdrawApplyBean.getOrderid();
        try {
        	
            //进度查询
            ${className}ApplyQuery2Rsp result = ${className}CreditApplyProcessHelper.query${className}WithdrawStatus(userid, orderid, terminalid);
            if(result == null) {
            	return;
            }
            int status = result.getApplyStatus();
            ${className}ApplyStatusEnum applyStatusEnum = ${className}ApplyStatusEnum.getByCode(status);
            if(applyStatusEnum == null) {
            	logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"未找到对应的状态码：" + status);
            	return;
            }
            switch(applyStatusEnum) {
			case CHECKING:
			case CHECK_FAIL:
			case CHECK_SUCESS:
			case CLEAR:
			case CREDITBACK:
				logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"此阶段状态码异常：" + status);
				break;
			case CREDIT_LIMTI_EXPIRE:
			case CANCLE://放款取消==提现失败
				${className}BusinessServiceHelper.failWithdraw(withdrawApplyBean);
				break;
			case LOAN_SUCESS://提现成功
				List<${className}RepayPlan> repayPlanList = ${className}CreditApplyProcessHelper.query${className}RepayPlanList(userid, orderid, terminalid);
				if(CollectionUtils.isEmpty(repayPlanList)) {
					logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"提现成功，但未获取到还款计划" + status);
				}
				${className}BusinessServiceHelper.successWithdraw(withdrawApplyBean,repayPlanList);
				break;
			case WITHDRAWAUDIT://放款中 不处理
				break;
			default:
				break;
            }
           
        } catch (Exception e) {
            logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"【${log_finance_name}】提现结果查询程序异常", e);
            throw new FinanceException(ErrorCode.SYSTEM_ERROR + "", e.getMessage());
        }
    }

    @Override
    public void repaymentApplyResultQuery(RepayApplyBean repayApplyBean) throws FinanceException {

    }


    
    
    @Override
    public void billSync(BillInfoBean billInfoBean) throws FinanceException {
        String msgInfo = String.format("用户id【%s】,订单号【%s】,主账单编号【%s】", billInfoBean.getUserid(),
                billInfoBean.getOrderid(), billInfoBean.getId());
        logger.info("【${log_finance_name}】账单同步开始, " + msgInfo);
        try {
        	${className}BillServiceHelper.syncBillInfo(billInfoBean);
            logger.info("【${log_finance_name}】账单同步结束, " + msgInfo);
        } catch (Exception e) {
            logger.error("【${log_finance_name}】账单同步异常"+ msgInfo, e);
            throw new ApiException(ApiErrorEnum.COMMON_SERVICE_ERROR,e);
        }
    }

    @Override
    public void idCardValidate(CreditApplyBean creditApplyBean) {

    }

    @Override
    public <R, T> R taskRouter(T obj, FinanceBusinessRouterEnum financeBusinessRouterEnum, Class<R> r) {
        return null;
    }



}
