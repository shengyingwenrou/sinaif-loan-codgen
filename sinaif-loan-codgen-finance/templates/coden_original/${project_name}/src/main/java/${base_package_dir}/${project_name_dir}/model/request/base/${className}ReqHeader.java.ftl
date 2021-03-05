<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request.base;
import java.io.Serializable;
<#include "/java_imports.include" />

public class ${className}ReqHeader implements Serializable {

    private static final long serialVersionUID = 7580269391825284267L;

    private String terminalid;

    private String productid;

    private String userid;


    public String getTerminalid() {
        return terminalid;
    }

    public void setTerminalid(String terminalid) {
        this.terminalid = terminalid;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }
}
