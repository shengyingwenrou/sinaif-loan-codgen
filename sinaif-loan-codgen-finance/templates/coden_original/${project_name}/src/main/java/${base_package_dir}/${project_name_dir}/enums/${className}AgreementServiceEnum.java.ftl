
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}AgreementServiceEnum {

    OPEN_ACCOUNT(1, "开户"),
    WITHDRAW(2, "提现"),
    REPAY(3, "贷后"),
    BIND_CARD(5,"绑卡"),
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

    ${className}AgreementServiceEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}AgreementServiceEnum getByCode(int code) {
        for (${className}AgreementServiceEnum el : ${className}AgreementServiceEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }}
