<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}BillStatusEnum {

    SETTLED("settled", "已结清"),
    OVERDUE("overdue", "逾期"),
    OPEN("open", "进行中"),
    REPAYFAIL("repayFaile","还款失败"),

    ;
    // 编码
    private String code;
    // 描述
    private String desc;

    public String getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }

    ${className}BillStatusEnum(String code, String desc){
        this.code = code;
        this.desc = desc;
    }

    public static ${className}BillStatusEnum getByCode(String code) {
        for(${className}BillStatusEnum el : ${className}BillStatusEnum.values()) {
            if(el.getCode().equals(code)) {
                return el;
            }
        }
        return null;
    }

}
