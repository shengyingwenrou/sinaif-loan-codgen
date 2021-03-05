
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}UserApplyStatusEnum {

    ACCESS_LIMIT(1012, "不不允许申请"),
    PROCESS_EX(1013, "异常的流程(资方表明是参数错误可以重复进件)"),
    REPEAT_APPLY(1014, "重复申请")
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

    ${className}UserApplyStatusEnum(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }

    public static ${className}UserApplyStatusEnum getByCode(int code) {
        for (${className}UserApplyStatusEnum el : ${className}UserApplyStatusEnum.values()) {
            if (el.getCode() == code) {
                return el;
            }
        }
        return null;
    }
}


