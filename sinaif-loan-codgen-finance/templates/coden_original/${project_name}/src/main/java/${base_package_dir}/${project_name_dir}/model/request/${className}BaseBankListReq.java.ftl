<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}BaseBankListReq extends ${className}BaseReq implements Serializable {


    private static final long serialVersionUID = 3718173223836941931L;

    @Override
    @JSONField(serialize = false)
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_BASE_BANKLIST;
    }


    /** 贷款产品ID(10001: 小赢卡贷; 10002: 小赢卡贷) NOT_NULL **/
    private String productId;

    /** 卡类型  具体参见 ${className}CardTypeEnum 枚举**/
    private String cardType;

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }
}
