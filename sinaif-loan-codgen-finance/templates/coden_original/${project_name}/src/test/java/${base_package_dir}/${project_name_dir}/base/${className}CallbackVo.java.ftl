<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.base;

<#include "/java_imports.include" />

public class ${className}CallbackVo {

    String flowId;
    int applyStatus;

    public ${className}CallbackVo(String flowId,int applyStatus){
        this.flowId = flowId;
        this.applyStatus = applyStatus;
    }

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    public int getApplyStatus() {
        return applyStatus;
    }

    public void setApplyStatus(int applyStatus) {
        this.applyStatus = applyStatus;
    }
}
