<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}BaseCityInfoReq extends ${className}BaseReq implements Serializable {


    private static final long serialVersionUID = 4986365795391035421L;

    @Override
    @JSONField(serialize = false)
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_BASE_CITYINFO;
    }

    /** 贷款产品ID(10001: 小赢卡贷; 10002: 小赢卡贷)  NOT_NULL**/
    private String productId;

    /** 获取的信息类别  具体参见 ${className}InfoTypeEnum 枚举 1: 准入城市列表; 2: 热门城市列表 **/
    private int infoType;


    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getInfoType() {
        return infoType;
    }

    public void setInfoType(int infoType) {
        this.infoType = infoType;
    }
}
