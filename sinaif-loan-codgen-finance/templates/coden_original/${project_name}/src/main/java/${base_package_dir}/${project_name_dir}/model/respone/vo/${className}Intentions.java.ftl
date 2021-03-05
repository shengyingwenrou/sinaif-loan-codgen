<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />

public class ${className}Intentions implements Serializable {

    private static final long serialVersionUID = -7644336012734717812L;
    /** 借款描述 **/
    private String desc;
    /** 借款用途标识 **/
    private int value;

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

}
