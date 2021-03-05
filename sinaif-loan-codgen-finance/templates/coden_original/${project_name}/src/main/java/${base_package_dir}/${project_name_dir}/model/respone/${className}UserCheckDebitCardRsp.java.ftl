
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone;
import com.google.common.collect.Lists;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}BankInfo;

import java.io.Serializable;
import java.util.List;
<#include "/java_imports.include" />
public class ${className}UserCheckDebitCardRsp extends ${className}BaseRsp implements Serializable {

    private static final long serialVersionUID = 130735028941472727L;
    /** 验证数据 NOT_NULL **/
    private String verifiedData;


    public String getVerifiedData() {
        return verifiedData;
    }

    public void setVerifiedData(String verifiedData) {
        this.verifiedData = verifiedData;
    }
}

