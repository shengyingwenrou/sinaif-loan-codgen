
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
public class ${className}BaseComputeRsp extends ${className}BaseRsp implements Serializable {


    private static final long serialVersionUID = 1789795346641954635L;

    /** 还款方式 NOT_NULL  具体参见${className}RepayTypeEnum枚举 **/
    private String repayType;

    /** 预计每月的还款金额 NOT_NULL **/
    private long repayAmountInMonth;

    public String getRepayType() {
        return repayType;
    }

    public void setRepayType(String repayType) {
        this.repayType = repayType;
    }

    public long getRepayAmountInMonth() {
        return repayAmountInMonth;
    }

    public void setRepayAmountInMonth(long repayAmountInMonth) {
        this.repayAmountInMonth = repayAmountInMonth;
    }
}

