<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}ApplyStatusEnum {

    CHECKING(102, "审核中"),
    CHECK_FAIL(103, "未通过"),
    CHECK_SUCESS(104, "审核通过"),
    LOAN_SUCESS(105, "借款成功"),
    CREDIT_LIMTI_EXPIRE(106, "额度过期"),
    CREDITBACK(107, "退回(补全资料)"),
    CLEAR(108, "已还清"),
    CANCLE(109, "取消"),
    WITHDRAWAUDIT(111, "放款中"),
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

    ${className}ApplyStatusEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}ApplyStatusEnum getByCode(int code) {
        for (${className}ApplyStatusEnum el : ${className}ApplyStatusEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }}
