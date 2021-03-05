<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}ApplyQuery2Req extends ${className}BaseReq implements Serializable {

    private static final long serialVersionUID = -8318730336073673892L;

    /**
     * 附加信息列表  注:具体使用中可以按照实际需要配置
     * receiveBankCard：收款银行行卡
     * repayBankCard：还款银行卡
     * repayPlanList：还款计划
     */
    private static final String[] additionInfoArr = {Constants.${classNameUpper}_ADDITION_INFO_RECEIVEBANKCARD, Constants.${classNameUpper}_ADDITION_INFO_REPAYBANKCARD, Constants.${classNameUpper}_ADDITION_INFO_REPAYPLANLIST};

    /** 流程ID  不能为空 **/
    private String flowId;


    /** 附加信息列表  可为空  不配置附加信息列表所有 **/
    private String[] additionInfoList;

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }


    public void setAdditionInfoList(String[] additionInfoList) {
        if ((null == additionInfoList) || (additionInfoList.length < 1)) {
            this.additionInfoList = additionInfoArr;
        } else {
            this.additionInfoList = additionInfoList;
        }
    }

    public static String[] getAdditionInfoArr() {
        return additionInfoArr;
    }

    public String[] getAdditionInfoList() {
        return additionInfoList;
    }

    @Override
    @JSONField(serialize = false)
    public ${className}TransCode getTransCode() {
        return ${className}TransCode.TRANSCODE_APPLY_QUERY2;
    }
}

