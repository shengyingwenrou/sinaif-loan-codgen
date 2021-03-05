<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}CheckLoanEnum {

    CHECK_LOAN_NO(0, "不可以申请"),
    CHECK_LOAN_YES(1, "可以申请"),
    ;

    /** 编码code **/
    private int code;
    /** code描述 **/
    private String remark;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    ${className}CheckLoanEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}CheckLoanEnum getByCode(int code) {
        for (${className}CheckLoanEnum el : ${className}CheckLoanEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }}
