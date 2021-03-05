<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />

/** 还款计划 **/
public class ${className}RepayPlan implements Serializable {

    private static final long serialVersionUID = 6869193902331279974L;
    /** 期数(第几期)**/
    private int period;
    /** 计划还款日期(格式:yyyyMMdd)**/
    private String planRepayDate;
    /**本期需要还款总额(单位为分。planRepayPrincipal + planRepayFee)**/
    private long planRepayAmount;
    /** 本期需要还本金金额(单位为分)**/
    private long planRepayPrincipal;
    /** 本期需要还息费(单位为分)**/
    private long planRepayFee;
    /** 是否已还(1是 0否)**/
    private int isRepaid;
    /** 是否逾期(1是 0否)**/
    private int isOverdue;
    /** 是否还款处理中(1是 0否)**/
    private int isRepaying;
    /** 实际还款时间(unix时间戳)**/
    private int repayTime;
    /** 实际还款金额(单位为分，还款后返回)**/
    private long repayAmount;
    /** 实际还款本金(单位为分，还款后返回)**/
    private long repayPrincipal;
    /** 实际还款息费(单位为分，还款后返回)**/
    private long repayFee;

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public String getPlanRepayDate() {
        return planRepayDate;
    }

    public void setPlanRepayDate(String planRepayDate) {
        this.planRepayDate = planRepayDate;
    }

    public long getPlanRepayAmount() {
        return planRepayAmount;
    }

    public void setPlanRepayAmount(long planRepayAmount) {
        this.planRepayAmount = planRepayAmount;
    }

    public long getPlanRepayPrincipal() {
        return planRepayPrincipal;
    }

    public void setPlanRepayPrincipal(long planRepayPrincipal) {
        this.planRepayPrincipal = planRepayPrincipal;
    }

    public long getPlanRepayFee() {
        return planRepayFee;
    }

    public void setPlanRepayFee(long planRepayFee) {
        this.planRepayFee = planRepayFee;
    }

    public int getIsRepaid() {
        return isRepaid;
    }

    public void setIsRepaid(int isRepaid) {
        this.isRepaid = isRepaid;
    }

    public int getIsOverdue() {
        return isOverdue;
    }

    public void setIsOverdue(int isOverdue) {
        this.isOverdue = isOverdue;
    }

    public int getIsRepaying() {
        return isRepaying;
    }

    public void setIsRepaying(int isRepaying) {
        this.isRepaying = isRepaying;
    }

    public int getRepayTime() {
        return repayTime;
    }

    public void setRepayTime(int repayTime) {
        this.repayTime = repayTime;
    }

    public long getRepayAmount() {
        return repayAmount;
    }

    public void setRepayAmount(long repayAmount) {
        this.repayAmount = repayAmount;
    }

    public long getRepayPrincipal() {
        return repayPrincipal;
    }

    public void setRepayPrincipal(long repayPrincipal) {
        this.repayPrincipal = repayPrincipal;
    }

    public long getRepayFee() {
        return repayFee;
    }

    public void setRepayFee(long repayFee) {
        this.repayFee = repayFee;
    }

}
