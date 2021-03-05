
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.data;
<#include "/java_imports.include" />

public class EncryptData {
    /**
     * 对称加密的随机密钥的加密后结果
     */
    private String key;
    /**
     * 对称加密后的消息数据
     */
    private String content;
    /**
     * 当前时间戳
     */
    private Integer timestamp;
    /**
     * 签名字符串
     */
    private String sign;

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

    public Integer getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Integer timestamp) {
        this.timestamp = timestamp;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

}
