
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
public class ${className}BaseBankListRsp extends ${className}BaseRsp implements Serializable {

    private static final long serialVersionUID = -5020294154860677608L;

    /** 资方支持范围内的银行信息列表 **/
    private String bankInfoArray;

    private List<${className}BankInfo> bankList;


    public List<${className}BankInfo> getBankList() {
        return bankList;
    }

    public void setBankList(List<${className}BankInfo> bankList) {
        this.bankList = this.getBankInfoList();
    }

    public String getBankInfoArray() {
        return bankInfoArray;
    }

    public void setBankInfoArray(String bankInfoArray) {
        this.bankInfoArray = bankInfoArray;
    }

    public List<${className}BankInfo> getBankInfoList() {
        List<${className}BankInfo> bankList = null;
        ${className}BankInfo bankInfo = null;
        JSONArray jsonArray = JSONArray.parseArray(this.bankInfoArray);
        if (null != jsonArray && jsonArray.size() > 0) {
            bankList = Lists.newArrayList();
            bankInfo = new ${className}BankInfo();
            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject bank = jsonArray.getJSONObject(i);
                String bankName = (String) bank.get("bankName");
                String bankCode = (String) bank.get("bankCode");
                bankInfo.setBankName(bankName);
                bankInfo.setBankCode(bankCode);
                bankList.add(bankInfo);
            }
        }
        return bankList;
    }
}


