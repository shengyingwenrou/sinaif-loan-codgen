<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}RepayTypeEnum {

    REPAY_WAY_1(1, "先息后本"),
    REPAY_WAY_2(2, "到期还本"),
    REPAY_WAY_3(3, "等额本息"),
    REPAY_WAY_4(4, "等额本金"),
    REPAY_WAY_5(5, "等本等息"),
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

    ${className}RepayTypeEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}RepayTypeEnum getByCode(int code) {
        for (${className}RepayTypeEnum el : ${className}RepayTypeEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }
}
