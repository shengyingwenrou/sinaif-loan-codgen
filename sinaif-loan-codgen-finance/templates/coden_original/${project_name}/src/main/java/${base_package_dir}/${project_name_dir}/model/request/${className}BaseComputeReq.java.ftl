<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
@Deprecated
public class ${className}BaseComputeReq extends ${className}BaseReq implements Serializable {


    private static final long serialVersionUID = -586716804664181288L;

    @Override
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_BASE_COMPUTE;
    }

    /** 申请金额(单位为分) NOT_NULL **/
    private long amount;

    /** 借款期限 NOT_NULL **/
    private int periods;

    /** 申请的产品ID(10001:小赢卡贷; 10002:小赢卡贷) NOT_NULL **/
    private String productId;

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public int getPeriods() {
        return periods;
    }

    public void setPeriods(int periods) {
        this.periods = periods;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }
}