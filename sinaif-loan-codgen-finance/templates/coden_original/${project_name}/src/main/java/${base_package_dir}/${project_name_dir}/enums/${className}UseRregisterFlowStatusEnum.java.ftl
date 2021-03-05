/**
 * 用户流程注册接口返回结果状态码
 */
 <#include "/java_global_assign.include" />
 package com.sinaif.king.finance.${classNameLower}.enums;
 <#include "/java_imports.include" />

public enum ${className}UseRregisterFlowStatusEnum {

    RREGISTER_LIMIT(1001, "已注册，但输入的⼿手机号或者证件号和系统中的不一致"),
    IDCARD_LIMIT(1002, "身份证号已和其他手机号关联"),
    AUTH_FAIL(1003, "实名认证失败，请校验姓名和身份证号信息"),
    FAIL(1004, "注册失败")
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

    ${className}UseRregisterFlowStatusEnum(int code, String remark) {

        this.code = code;
        this.remark = remark;
    }

    public static ${className}UseRregisterFlowStatusEnum getByCode(int code) {
        for (${className}UseRregisterFlowStatusEnum el : ${className}UseRregisterFlowStatusEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }
}


