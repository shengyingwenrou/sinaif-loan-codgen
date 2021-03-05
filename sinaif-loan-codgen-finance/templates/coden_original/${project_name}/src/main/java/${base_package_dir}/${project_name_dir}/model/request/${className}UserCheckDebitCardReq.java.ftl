
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}UserCheckDebitCardReq extends ${className}BaseReq implements Serializable {


    private static final long serialVersionUID = 1996707009605915530L;

    @Override
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_USER_CHECKDEBITCARD;
    }

    /** 流程ID NOT_NULL **/
    @NotNull
    private String flowId;

    /** 银行卡号 NOT_NULL **/
    @NotNull
    private String cardNo;

    /** 银行代码 NOT_NULL **/
    @NotNull
    private String bankCode;

    /** 银行预留手机号 NOT_NULL **/
    @NotNull
    private String cardMobile;

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
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

    public String getCardMobile() {
        return cardMobile;
    }

    public void setCardMobile(String cardMobile) {
        this.cardMobile = cardMobile;
    }
}