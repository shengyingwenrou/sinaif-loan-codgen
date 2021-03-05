
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />

public class ${className}ApplyComputeRepayPlanReq extends ${className}BaseReq implements Serializable {


    private static final long serialVersionUID = 7213640353620590899L;

    @Override
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_APPLY_COMPUTEREPAYPLAN;
    }

    /** 流程ID  不能为空 **/
    private String flowId;

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }
}