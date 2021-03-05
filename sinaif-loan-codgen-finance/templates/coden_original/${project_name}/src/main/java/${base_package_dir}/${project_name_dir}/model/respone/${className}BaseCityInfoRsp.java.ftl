
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
public class ${className}BaseCityInfoRsp extends ${className}BaseRsp implements Serializable {


    private static final long serialVersionUID = 3451854654610415005L;


    private String cityInfoArray;

    public String getCityInfoArray() {
        return cityInfoArray;
    }

    public void setCityInfoArray(String cityInfoArray) {
        this.cityInfoArray = cityInfoArray;
    }
}

