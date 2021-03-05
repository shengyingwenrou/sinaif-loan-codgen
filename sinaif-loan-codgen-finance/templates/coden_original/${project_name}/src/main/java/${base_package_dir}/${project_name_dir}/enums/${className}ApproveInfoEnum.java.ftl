
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}ApproveInfoEnum {


    APPROVE_PERIODS("approvePeriods", "审批借款期限"),
    APPROVE_AMOUNT("approveAmount", "审批借款金额"),
    APPLY_AMOUNT("applyAmount", "申请借款金额"),
    APPLY_PERIODS("applyPeriods","申请借款期数"),
    PLAN_INSURANCE_AMOUNT("planInsuranceAmount","预计保费"),
    LOAN_EXPIRE_TIME("loanExpireTime","要款过期时间"),

    ;
    // 编码
    private String code;
    // 描述
    private String desc;

    public String getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }

    ${className}ApproveInfoEnum(String code, String desc){
        this.code = code;
        this.desc = desc;
    }

    public static ${className}ApproveInfoEnum getByCode(String code) {
        for(${className}ApproveInfoEnum el : ${className}ApproveInfoEnum.values()) {
            if(el.getCode().equals(code)) {
                return el;
            }
        }
        return null;
    }

}
