<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}QueryCallDetailEnum {

    NO(0, "不存在有效的通话详单"),
    YES(1, "存在有效的通话详单"),
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

    ${className}QueryCallDetailEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}QueryCallDetailEnum getByCode(int code) {
        for (${className}QueryCallDetailEnum el : ${className}QueryCallDetailEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }}
