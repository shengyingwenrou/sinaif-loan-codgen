<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />
public class ${className}ApproveInfo implements Serializable {

    private static final long serialVersionUID = -210974134372302183L;

    /** 审批借款期限 **/
    private int approvePeriods;
    /** 审批借款金额**/
    private long approveAmount;
    /** 申请借款金额**/
    private long applyAmount;
    /** 申请借款期数**/
    private int applyPeriods;
    /** 预计保费**/
    private long planInsuranceAmount;
    /** 要款过期时间**/
    private String loanExpireTime;

    public int getApprovePeriods() {
        return approvePeriods;
    }

    public void setApprovePeriods(int approvePeriods) {
        this.approvePeriods = approvePeriods;
    }

    public long getApproveAmount() {
        return approveAmount;
    }

    public void setApproveAmount(long approveAmount) {
        this.approveAmount = approveAmount;
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

    public long getPlanInsuranceAmount() {
        return planInsuranceAmount;
    }

    public void setPlanInsuranceAmount(long planInsuranceAmount) {
        this.planInsuranceAmount = planInsuranceAmount;
    }

    public String getLoanExpireTime() {
        return loanExpireTime;
    }

    public void setLoanExpireTime(String loanExpireTime) {
        this.loanExpireTime = loanExpireTime;
    }

    /**
     *
     */

}
