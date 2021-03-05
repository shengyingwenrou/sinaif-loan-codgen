<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}CommonStatusEnum {

    NO(0, "否"),
    YES(1, "是"),

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

    ${className}CommonStatusEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}CommonStatusEnum getByCode(int code) {
        for (${className}CommonStatusEnum el : ${className}CommonStatusEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }}
