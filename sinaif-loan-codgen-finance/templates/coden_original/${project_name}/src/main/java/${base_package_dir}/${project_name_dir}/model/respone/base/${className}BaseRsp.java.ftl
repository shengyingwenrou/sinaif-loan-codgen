<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.base;
import java.io.Serializable;
<#include "/java_imports.include" />

public class ${className}BaseRsp implements Serializable {

    private static final long serialVersionUID = 3827635717613042521L;

    private ${className}RspHeader header;

    public ${className}RspHeader getHeader() {
        return header;
    }

    public void setHeader(${className}RspHeader header) {
        this.header = header;
    }

}
