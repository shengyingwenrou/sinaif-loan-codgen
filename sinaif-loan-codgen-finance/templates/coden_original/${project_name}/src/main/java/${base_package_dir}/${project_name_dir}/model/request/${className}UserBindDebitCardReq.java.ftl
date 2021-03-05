<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}UserBindDebitCardReq extends ${className}BaseReq implements Serializable {


    private static final long serialVersionUID = 4874800600699552300L;

    @Override
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_USER_BINDDEBITCARD;
    }

    /** 流程ID NOT_NULL **/
    private String flowId;

    /** 验证数据 NOT_NULL **/
    private String verifiedData;

    /** 短信验证码 NOT_NULL **/
    private String smsCode;

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    public String getVerifiedData() {
        return verifiedData;
    }

    public void setVerifiedData(String verifiedData) {
        this.verifiedData = verifiedData;
    }

    public String getSmsCode() {
        return smsCode;
    }

    public void setSmsCode(String smsCode) {
        this.smsCode = smsCode;
    }
}
