<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.base;
import java.io.Serializable;
<#include "/java_imports.include" />
public class ${className}RspHeader implements Serializable {

    private static final long serialVersionUID = 6452472808690322843L;


    private Integer code;

    private String msg;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Override
    public String toString() {
        return "SwinRspHeader{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                '}';
    }
}
