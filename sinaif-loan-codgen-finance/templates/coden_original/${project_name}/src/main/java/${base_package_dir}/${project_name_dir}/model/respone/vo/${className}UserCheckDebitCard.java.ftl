<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />

public class ${className}UserCheckDebitCard implements Serializable {

    private static final long serialVersionUID = -1364281455928154500L;
    private String bankCode;
    private String ticket;
    private int quickPay;
    private String phone;
    private String cardNo;

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public int getQuickPay() {
        return quickPay;
    }

    public void setQuickPay(int quickPay) {
        this.quickPay = quickPay;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

}
