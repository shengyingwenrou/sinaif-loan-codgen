<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}UserInfoCollectStatusEnum {

    ADRESS_LOST(1005, "该次采集成功，还缺少地址信息"),
    IDCARD_LOST(1006, "该次采集成功，还缺少身份照信息"),
    EMERGENCY_CONTACT_LOST(1007, "该次采集成功，还缺少紧急联系人信息"),
    FREQUENT_CONTACT_LOST(1008, "该次采集成功，还缺少常用联系人信息")
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

    ${className}UserInfoCollectStatusEnum(int code, String remark) {

        this.code = code;
        this.remark = remark;
    }

    public static ${className}UserInfoCollectStatusEnum getByCode(int code) {
        for (${className}UserInfoCollectStatusEnum el : ${className}UserInfoCollectStatusEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }
}


