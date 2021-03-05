<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}BaseProductInfoReq extends ${className}BaseReq implements Serializable {

    private static final long serialVersionUID = -2505386162271318263L;
    private String productId;

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    @Override
    @JSONField(serialize = false)
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_BASE_PRODUCTINFO;
    }
}
