<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
import java.math.BigDecimal;
<#include "/java_imports.include" />

public class ${className}AmountRange implements Serializable {


    private static final long serialVersionUID = 372666781809656915L;
    /** 贷款金额范围最小值**/
    private BigDecimal min;
    /** 贷款金额范围最大值**/
    private BigDecimal max;

    public BigDecimal getMin() {
        return min;
    }

    public void setMin(BigDecimal min) {
        this.min = min;
    }

    public BigDecimal getMax() {
        return max;
    }

    public void setMax(BigDecimal max) {
        this.max = max;
    }

}
