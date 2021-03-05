<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.base;
import java.io.Serializable;
<#include "/java_imports.include" />
public class ${className}CommonRsp implements Serializable {

    private static final long serialVersionUID = 7950061165704388656L;

    private Integer errCode;

    private String errStr;

    private String data;

    public Integer getErrCode() {
        return errCode;
    }

    public void setErrCode(Integer errCode) {
        this.errCode = errCode;
    }

    public String getErrStr() {
        return errStr;
    }

    public void setErrStr(String errStr) {
        this.errStr = errStr;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
