<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />

/** 银行信息对象 **/
public class ${className}BankInfo implements Serializable {

    private static final long serialVersionUID = 1869464469586357440L;
    /** 银行名称(ex:中国农业银) NOT_NULL **/
    private String bankName;
    /** 银行标号(ex:ABC) NOT_NULL **/
    private String bankCode;

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

}
