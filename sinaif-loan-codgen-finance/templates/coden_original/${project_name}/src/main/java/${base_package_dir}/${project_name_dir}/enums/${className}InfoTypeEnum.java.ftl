<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}InfoTypeEnum {

    ACCESS_CITY(1, "准入城市列列表"),
    HOT_CITY(2, "热门城市列列表"),
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

    ${className}InfoTypeEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}InfoTypeEnum getByCode(int code) {
        for (${className}InfoTypeEnum el : ${className}InfoTypeEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }

}
