
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone;
import com.google.common.collect.Lists;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;


import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}AmountRange;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}BankInfo;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}Intentions;

import java.io.Serializable;
import java.util.List;
<#include "/java_imports.include" />
public class ${className}ProductInfoQueryRsp extends ${className}BaseRsp implements Serializable {


    private static final long serialVersionUID = -6628240507937747201L;

    private ${className}AmountRange loanAmountRange;

    private int[] loanPeriods;

    /** 借款用途 **/
    private List<${className}Intentions> loanIntentions;

    /** 还款方式 3:等额本息 **/
    private int repayType;


    public ${className}AmountRange getLoanAmountRange() {
        return loanAmountRange;
    }

    public void setLoanAmountRange(${className}AmountRange loanAmountRange) {
        this.loanAmountRange = loanAmountRange;
    }

    public int[] getLoanPeriods() {
        return loanPeriods;
    }

    public void setLoanPeriods(int[] loanPeriods) {
        this.loanPeriods = loanPeriods;
    }

    public List<${className}Intentions> getLoanIntentions() {
        return loanIntentions;
    }

    public void setLoanIntentions(List<${className}Intentions> loanIntentions) {
        this.loanIntentions = loanIntentions;
    }

    public int getRepayType() {
        return repayType;
    }

    public void setRepayType(int repayType) {
        this.repayType = repayType;
    }
}
