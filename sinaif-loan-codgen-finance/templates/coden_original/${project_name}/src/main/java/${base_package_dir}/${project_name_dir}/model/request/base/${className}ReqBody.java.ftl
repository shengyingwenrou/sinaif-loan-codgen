
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request.base;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.io.Serializable;

<#include "/java_imports.include" />
public class ${className}ReqBody implements Serializable {

    private static final long serialVersionUID = 1187405332053604057L;

    /** 合作⽅方id **/
    private String partner;
    /** 随机密钥 **/
    private String key;
    /** 加密后的数据内容 **/
    private String content;
    /** 请求时间戳（秒） **/
    private int timestamp;
    /** 数据签名 **/
    private String sign;

    @JsonIgnore
    private ${className}BaseReq ${classNameLower}BaseReq;

    public String getPartner() {
        return partner;
    }

    public void setPartner(String partner) {
        this.partner = partner;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(int timestamp) {
        this.timestamp = timestamp;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public ${className}BaseReq get${className}BaseReq() {
        return ${classNameLower}BaseReq;
    }

    public void set${className}BaseReq(${className}BaseReq ${classNameLower}BaseReq) {
        this.${classNameLower}BaseReq = ${classNameLower}BaseReq;
    }
}
