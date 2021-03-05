
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone;
import com.alibaba.fastjson.JSONArray;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}BankCard;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;
import java.io.Serializable;
import java.util.List;
<#include "/java_imports.include" />

public class ${className}ApplyQuery2Rsp extends ${className}BaseRsp implements Serializable {

    private static final long serialVersionUID = 8424297655723857011L;

    /** 申请流程标识 NOT_NULL **/
    private String flowId;
    /** 贷款产品ID NOT_NULL **/
    private String productId;
    /** 还款方式 NOT_NULL 具体参见${className}RepayTypeEnum枚举 **/
    private int repayType;
    /** 申请状态 NOT_NULL 具体参见${className}ApplyStatusEnum枚举 **/
    private int applyStatus;
    /** 申请时间(unix时间戳) NOT_NULL **/
    private int applyTime;
    /** 申请借款金额(单位为分) NOT_NULL **/
    private long applyAmount;
    /** 申请借款期数 NOT_NULL **/
    private int applyPeriods;
    /** 审批时间(unix时间戳，审批通过后返回)  **/
    private int approveTime;
    /** 审批借款金额(单位为分，审批通过后返回)  **/
    private long approveAmount;
    /** 审批借款期数(审批通过后返回) **/
    private int approvePeriods;
    /** 预计保费(单位为分，要款时需要展示保费，审批通过时返回) **/
    private long planInsuranceAmount;
    /** 预计每月还款金额(单位为分，要款时可以展示，审批通过时返回；等额本息产品返回)**/
    private long planRepayAmountInMonth;
    /** 要款过期时间(unix时间戳，审批通过时（applyStatus=104）返回，需要在要款过期时间内操作要款) **/
    private int  loanExpireTime;
    /** 审批拒绝原因(审批拒绝时返回(applyStatus=103))**/
    private String rejectReason;
    /** 退回补件原因(退回补件时返回(applyStatus=107）)**/
    private String supplementReason;
    /** 补件照片列表(["idFrontImage", "idBackImage", "idHandImage"]如果处于补件状态，会返回需要补件的照片列列表)**/
    private String[] supplementList;
    /** 补件失效时间(unix时间戳，退回补件时返回，需要⽤用户在该时间之前进行补件操作，否则该笔借款自动取消)**/
    private int supplementExpireTime;
    /** 借款时间(unix时间戳，起息时间，放款成功后返回)**/
    private int loanTime;
    /** 借款金额(单位为分，要款后返回)**/
    private long loanAmount;
    /** 借款期限(要款后返回)**/
    private int loanPeriods;
    /** 收款银行卡信息(审批通过后返回，要款时展示收款银⾏行行卡:需要在参数additionInfoList中包含"receiveBankCard")**/
    private ${className}BankCard receiveBankCard;
    /** 还款银行卡信息(借款成功后返回；需要在参数additionInfoList中包含"repayBankCard")**/
    private ${className}BankCard repayBankCard;

    /** 借款期限(借款成功后返回:需要在参数additionInfoList中包含"repayPlanList")**/
    private JSONArray repayPlanList;

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getRepayType() {
        return repayType;
    }

    public void setRepayType(int repayType) {
        this.repayType = repayType;
    }

    public int getApplyStatus() {
        return applyStatus;
    }

    public void setApplyStatus(int applyStatus) {
        this.applyStatus = applyStatus;
    }

    public int getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(int applyTime) {
        this.applyTime = applyTime;
    }

    public long getApplyAmount() {
        return applyAmount;
    }

    public void setApplyAmount(long applyAmount) {
        this.applyAmount = applyAmount;
    }

    public int getApplyPeriods() {
        return applyPeriods;
    }

    public void setApplyPeriods(int applyPeriods) {
        this.applyPeriods = applyPeriods;
    }

    public int getApproveTime() {
        return approveTime;
    }

    public void setApproveTime(int approveTime) {
        this.approveTime = approveTime;
    }

    public long getApproveAmount() {
        return approveAmount;
    }

    public void setApproveAmount(long approveAmount) {
        this.approveAmount = approveAmount;
    }

    public int getApprovePeriods() {
        return approvePeriods;
    }

    public void setApprovePeriods(int approvePeriods) {
        this.approvePeriods = approvePeriods;
    }

    public long getPlanInsuranceAmount() {
        return planInsuranceAmount;
    }

    public void setPlanInsuranceAmount(long planInsuranceAmount) {
        this.planInsuranceAmount = planInsuranceAmount;
    }

    public long getPlanRepayAmountInMonth() {
        return planRepayAmountInMonth;
    }

    public void setPlanRepayAmountInMonth(long planRepayAmountInMonth) {
        this.planRepayAmountInMonth = planRepayAmountInMonth;
    }

    public int getLoanExpireTime() {
        return loanExpireTime;
    }

    public void setLoanExpireTime(int loanExpireTime) {
        this.loanExpireTime = loanExpireTime;
    }

    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }

    public String getSupplementReason() {
        return supplementReason;
    }

    public void setSupplementReason(String supplementReason) {
        this.supplementReason = supplementReason;
    }

    public String[] getSupplementList() {
        return supplementList;
    }

    public void setSupplementList(String[] supplementList) {
        this.supplementList = supplementList;
    }

    public int getSupplementExpireTime() {
        return supplementExpireTime;
    }

    public void setSupplementExpireTime(int supplementExpireTime) {
        this.supplementExpireTime = supplementExpireTime;
    }

    public int getLoanTime() {
        return loanTime;
    }

    public void setLoanTime(int loanTime) {
        this.loanTime = loanTime;
    }

    public long getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(long loanAmount) {
        this.loanAmount = loanAmount;
    }

    public int getLoanPeriods() {
        return loanPeriods;
    }

    public void setLoanPeriods(int loanPeriods) {
        this.loanPeriods = loanPeriods;
    }

    public ${className}BankCard getReceiveBankCard() {
        return receiveBankCard;
    }

    public void setReceiveBankCard(${className}BankCard receiveBankCard) {
        this.receiveBankCard = receiveBankCard;
    }

    public ${className}BankCard getRepayBankCard() {
        return repayBankCard;
    }

    public void setRepayBankCard(${className}BankCard repayBankCard) {
        this.repayBankCard = repayBankCard;
    }

    public JSONArray getRepayPlanList() {
        return repayPlanList;
    }

    public void setRepayPlanList(JSONArray repayPlanList) {
        this.repayPlanList = repayPlanList;
    }

    public List<${className}RepayPlan> getRepayPlans() {
        JSONArray jsonArray = this.getRepayPlanList();
        if (null != jsonArray && jsonArray.size() > 0) {
            List<${className}RepayPlan> repayPlans = JSONArray.parseArray(jsonArray.toJSONString(), ${className}RepayPlan.class);
            return repayPlans;
        }
        return null;
    }
}
