<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />

/** 银行卡信息 **/
public class ${className}BankCard implements Serializable {

    private static final long serialVersionUID = -6250978885551337315L;
    /** 卡ID NOT_NULL **/
    private String cardId;
    /** 卡类型 NOT_NULL **/
    private int cardType;
    /** 银行卡号(有掩码) NOT_NULL **/
    private String cardNo;
    /** 银行编号 NOT_NULL **/
    private String bankCode;
    /** 银行名称 **/
    private String bankName;

    public String getCardId() {
        return cardId;
    }

    public void setCardId(String cardId) {
        this.cardId = cardId;
    }

    public int getCardType() {
        return cardType;
    }

    public void setCardType(int cardType) {
        this.cardType = cardType;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

}
