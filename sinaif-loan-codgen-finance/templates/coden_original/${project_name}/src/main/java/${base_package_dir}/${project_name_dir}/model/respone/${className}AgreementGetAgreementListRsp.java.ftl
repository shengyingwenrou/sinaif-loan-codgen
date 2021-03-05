
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone;
import com.alibaba.fastjson.JSONArray;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}Agreement;
import java.io.Serializable;
import java.util.List;
<#include "/java_imports.include" />

public class ${className}AgreementGetAgreementListRsp extends ${className}BaseRsp implements Serializable {

    private static final long serialVersionUID = -2920234353166109739L;

    /** 是否显示勾选框  NOT_NULL 1:是 0:否 参见状态枚举${className}CommonStatusEnum**/
    private int isShowSelect;
    /** 是否默认勾选 1:是 0:否 参见状态枚举${className}CommonStatusEnum **/
    private int isDefaultSelect;
    /** 合同枚举 **/
    private JSONArray agreementList;

    public int getIsShowSelect() {
        return isShowSelect;
    }

    public void setIsShowSelect(int isShowSelect) {
        this.isShowSelect = isShowSelect;
    }

    public int getIsDefaultSelect() {
        return isDefaultSelect;
    }

    public void setIsDefaultSelect(int isDefaultSelect) {
        this.isDefaultSelect = isDefaultSelect;
    }

    public JSONArray getAgreementList() {
        return agreementList;
    }

    public void setAgreementList(JSONArray agreementList) {
        this.agreementList = agreementList;
    }

    public List<${className}Agreement> getAgreements() {
        JSONArray jsonArray = this.getAgreementList();
        if (null != jsonArray && jsonArray.size() > 0) {
            List<${className}Agreement> agreements = JSONArray.parseArray(jsonArray.toJSONString(), ${className}Agreement.class);
            return agreements;
        }
        return null;
    }
}

