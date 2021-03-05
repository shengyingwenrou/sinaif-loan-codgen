<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.helper;

import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sinaif.king.common.utils.DateUtils;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.enums.common.CommonEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.${classNameLower}.enums.${className}FinanceParamEnum;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyQuery2Rsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}ApproveInfo;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}SupplementInfo;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.data.vo.UserBankCardVO;
import com.sinaif.king.model.finance.loan.LoanBizFinanceRefBean;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;

<#include "/java_imports.include" />
@Component
public class ${className}BizFinanceRefServiceHelper extends ${className}BaseHelper{

    private static Logger logger = LoggerFactory.getLogger(${className}BizFinanceRefServiceHelper.class);

    @Autowired
    protected LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;

    /**
     * 保存绑定储蓄卡时资方返回的verifiedData(Json结构)
     * @param userId 用户ID
     * @param productId 产品ID
     * @param orderId  订单ID
     * @param terminalId 终端ID
     * @param verifiedData 绑定储蓄卡时资方返回的verifiedData
     */
    public void saveOrUpdateVerifiedData(String userId, String productId,String orderId, String terminalId,String verifiedData) {
        this.saveOrUpdateByCondition(terminalId,productId,userId,
                ${className}FinanceParamEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_VERIFIEDDATA.getCode(),verifiedData,
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_BANKINFO.getCode()),orderId,
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
    }
    /**
     * 获取绑定储蓄卡时资方返回的verifiedData(Json结构)
     * @param userId 用户ID
     * @param productId 产品ID
     * @param orderId  订单ID
     * @param terminalId 终端ID
     */
    public String getVerifiedData(String userId, String productId,String orderId, String terminalId) {
        return getLoanBizFinanceRefFinanceValue(terminalId,productId,userId,
                ${className}FinanceParamEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_VERIFIEDDATA.getCode(),
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_BANKINFO.getCode()),orderId,
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
    }

    /**
     * 保存用户流程注册成功的FlowId
     * @param userId 用户ID
     * @param productId 产品ID
     * @param orderId  订单ID
     * @param terminalId 终端ID
     * @param flowId 用户流程注册成功的FlowId
     */
    public void saveOrUpdateFlowId(String userId, String productId,String orderId, String terminalId,String flowId) {
        this.saveOrUpdateByCondition(terminalId,productId,userId,
                ${className}FinanceParamEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_FLOW_ID.getCode(),flowId,
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_CREDIT.getCode()),orderId,
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
    }

    /**
     * 获取资方注册生成的流程FlowId(重要信息)
     * @param userId 用户ID
     * @param productId 产品ID
     * @param orderId  订单ID
     * @param terminalId 终端ID
     * @return String FlowId
     */
    public String getFlowId(String userId, String productId,String orderId, String terminalId) {
        return this.getLoanBizFinanceRefFinanceValue(terminalId,productId,userId,
                ${className}FinanceParamEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_FLOW_ID.getCode(),
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_CREDIT.getCode()),orderId,
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
    }

   


    /**
     * 检索无结果集保存 有结果集更新
     * @param terminalId
     * @param productId
     * @param userId
     * @param financeValue
     */
    public void saveOrUpdateByCondition(String terminalId, String productId, String userId, String financekey,String financeValue,
            int serviceType,String serviceId,int datafrom) {
        LoanBizFinanceRefBean refBean = new LoanBizFinanceRefBean();
        // 更新检索条件
        refBean.setTerminalid(terminalId);
        refBean.setUserid(userId);
        refBean.setProductid(productId);
        refBean.setServicetype(serviceType);
        refBean.setServiceid(serviceId);
        refBean.setDatafrom(datafrom);
        refBean.setFinancekey(financekey);
        // 更新字段+默认的更新时间
        refBean.setFinancevalue(financeValue);
        loanBizFinanceRefBeanService.saveOrUpdateByCondition(refBean);
    }

    /**
     * 获取业务value值
     * @param terminalId 终端ID
     * @param productId 产品ID
     * @param userId  用户ID
     * @param financekey 业务key
     * @param serviceType 业务类型
     * @param serviceId 业务ID
     * @param datafrom 数据来源
     * @return 业务value值
     */
    public String getLoanBizFinanceRefFinanceValue(String terminalId, String productId, String userId, String financekey,
            int serviceType,String serviceId,int datafrom) {
        LoanBizFinanceRefBean refBean = new LoanBizFinanceRefBean();
        // 更新检索条件
        refBean.setTerminalid(terminalId);
        refBean.setUserid(userId);
        refBean.setProductid(productId);
        refBean.setServicetype(serviceType);
        refBean.setServiceid(serviceId);
        refBean.setDatafrom(datafrom);
        refBean.setFinancekey(financekey);
        List<LoanBizFinanceRefBean> list = loanBizFinanceRefBeanService.selectList(refBean);
        if(CollectionUtils.isNotEmpty(list)){
            String financeValue=list.get(0).getFinancevalue();
            logger.info("【${log_finance_name}】获取资方key:{} value:{} 获取成功",financekey,financeValue);
            return financeValue;
        }
        return null;
    }


    /**
     * 获取进件审批后可用审批数据
     * @param creditApplyBean 订单信息
     * @return ApproveInfo 审批可用数据对象
     */
    public ${className}ApproveInfo getApproveInfo( CreditApplyBean creditApplyBean) {
        if (null == creditApplyBean) {
            return null;
        }
        String strInfo = this
                .getLoanBizFinanceRefFinanceValue(creditApplyBean.getTerminalid(), creditApplyBean.getProductid(), creditApplyBean
                        .getUserid(), CommonEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_APPROVE_INFO.getCode(), Integer
                        .parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_ACCESS.getCode()), creditApplyBean.getId(), Integer
                        .parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
        if (StringUtils.isNotBlank(strInfo)) {
            ${className}ApproveInfo approveInfo = JSONObject.parseObject(strInfo, ${className}ApproveInfo.class);
            return approveInfo;
        }
        return null;
    }

    /**
     * 获取订单审批数据
     * @param ${className}ApplyQuery2Rsp  审批数据
     * @param creditApplyBean 订单信息
     */
    public void saveApproveInfo(${className}ApplyQuery2Rsp ${className}ApplyQuery2Rsp, CreditApplyBean creditApplyBean){
        if (null == ${className}ApplyQuery2Rsp) {
            return;
        }
        int periods = ${className}ApplyQuery2Rsp.getApprovePeriods();
        long approveAmount = ${className}ApplyQuery2Rsp.getApproveAmount();
        long loanExpireTime = ${className}ApplyQuery2Rsp.getLoanExpireTime();
        Date expireDate = new Date(Long.valueOf(loanExpireTime)*1000);
        String expireDateStr = DateUtils.dateToString(expireDate);

        ${className}ApproveInfo  approveInfo =new ${className}ApproveInfo();
        approveInfo.setApprovePeriods(periods);
        approveInfo.setApproveAmount(approveAmount);
        approveInfo.setLoanExpireTime(expireDateStr);
        approveInfo.setApplyAmount(${className}ApplyQuery2Rsp.getApplyAmount());
        approveInfo.setPlanInsuranceAmount(${className}ApplyQuery2Rsp.getPlanInsuranceAmount());
        approveInfo.setApplyPeriods(${className}ApplyQuery2Rsp.getApplyPeriods());

        this.saveOrUpdateByCondition(creditApplyBean.getTerminalid(),creditApplyBean.getProductid(),creditApplyBean.getUserid(),
                CommonEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_APPROVE_INFO.getCode(),JSON.toJSONString(approveInfo),
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_ACCESS.getCode()),creditApplyBean.getId(),
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
    }

    /**
     * 获取进件审批结果107补件数据存储
     * @param creditApplyBean 订单信息
     * @return ApproveInfo 审批可用数据对象
     */
    public ${className}SupplementInfo getSupplementInfo(CreditApplyBean creditApplyBean) {
        if (null == creditApplyBean) {
            return null;
        }
        String strInfo = this
                .getLoanBizFinanceRefFinanceValue(creditApplyBean.getTerminalid(), creditApplyBean.getProductid(), creditApplyBean
                        .getUserid(), CommonEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_SUPPLEMENTINFO.getCode(), Integer
                        .parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_CREDIT.getCode()), creditApplyBean.getId(), Integer
                        .parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
        if (StringUtils.isNotBlank(strInfo)) {
            ${className}SupplementInfo supplementInfo = JSONObject.parseObject(strInfo, ${className}SupplementInfo.class);
            return supplementInfo;
        }
        return null;
    }


    /**
     * 保存进件审批结果107补件数据存储
     * @param supplementInfo 审批结果107补件数据对象
     * @return ApproveInfo 审批可用数据对象
     */
    public void saveSupplementInfo(CreditApplyBean creditApplyBean,${className}SupplementInfo supplementInfo) {
        if (null == supplementInfo) {
            return;
        }
        this.saveOrUpdateByCondition(creditApplyBean.getTerminalid(),creditApplyBean.getProductid(),creditApplyBean.getUserid(),
                CommonEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_SUPPLEMENTINFO.getCode(),JSON.toJSONString(supplementInfo),
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_CREDIT.getCode()),creditApplyBean.getId(),
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
    }



    /**
     * 获取通过我方绑定的信用卡
     * @param userId 用户ID
     * @param productId 产品ID
     * @param terminalId 终端ID
     */
    public UserBankCardVO getCreditCard(String userId, String productId, String terminalId) {
        String cardInfo= getLoanBizFinanceRefFinanceValue(terminalId,productId,userId,
                CommonEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_CREDITBANKINFO.getCode(),
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_SERVICETYPE_CREDITBANKINFO.getCode()),userId,
                Integer.parseInt(CommonEnum.LOAN_BIZ_FINANCE_REF_DATAFROM_FINANCE.getCode()));
        UserBankCardVO userBankCardVO =null;
        if(StringUtils.isNotBlank(cardInfo)){
            userBankCardVO= JSONObject.parseObject(cardInfo, UserBankCardVO.class);
        }
        return userBankCardVO;
    }


    public String getOrderIdByFlowId(String flowId) {
    	LoanBizFinanceRefBean searchBean = new LoanBizFinanceRefBean();
    	searchBean.setFinancekey(${className}FinanceParamEnum.LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_FLOW_ID.getCode());
    	searchBean.setProductid(ProductEnum.${classNameUpper}.id);
    	searchBean.setFinancevalue(flowId);
    	List<LoanBizFinanceRefBean> list = loanBizFinanceRefBeanService.selectList(searchBean);
    	if(CollectionUtils.isEmpty(list)) {
    		return null;
    	}
    	if(list.size()>1) {
    		throw new FinanceException("","系统异常，发现订单重复");
    	}
    	return list.get(0).getServiceid();
    }
}
