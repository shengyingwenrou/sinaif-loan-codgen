<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;


import com.google.common.base.Charsets;

import com.sinaif.king.finance.${classNameLower}.model.data.EncryptData;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;

<#include "/java_imports.include" />
public class DataUtils {

    private  static Logger logger = LoggerFactory.getLogger(DataUtils.class);

    /**
     * 加密数据
     * @param partner 合作方标识
     * @param publicKey 资方公钥
     * @param md5Key md5Key
     * @param content  加密字符串
     * @return EncryptData 加密数据
     */
    public static EncryptData encrypt(String partner, String publicKey, String md5Key, String content) {

        try {
            // 生成aes的随机密钥
            byte[] aesKey = AesUtil.randomKey();

            // 使用aes加密返回内容
            byte[] contentBytes = content.getBytes(Charsets.UTF_8);
            byte[] encryptedContentBytes = AesUtil.encrypt(contentBytes, aesKey);
            String encryptedContent = Base64Util.encode(encryptedContentBytes);

            // 使用rsa加密随机密钥
            byte[] keyBytes = RsaUtil.encryptByPublicKey(aesKey, publicKey);
            String key = Base64Util.encode(keyBytes);

            // 使用md5生成数据签名
            Long timestamp = (new Date()).getTime() / 1000;
            String signContent = partner + encryptedContent + key + timestamp + md5Key;
            String sign = Md5Util.md5(signContent, Charsets.UTF_8);

            EncryptData encryptData = new EncryptData();
            // 对称加密的随机密钥的加密后结果
            encryptData.setKey(key);
            // 对称加密后的消息数据
            encryptData.setContent(encryptedContent);
            // 当前时间戳
            encryptData.setTimestamp(timestamp.intValue());
            // 签名字符串
            encryptData.setSign(sign);
            return encryptData;

        } catch (Exception e) {
            logger.error("DataUtils Exception message:{}",e.getMessage());
            throw new RuntimeException("加密失败");
        }
    }


    /**
     * 解密数据
     * @param partner 合作方标识
     * @param privateKey 私钥
     * @param md5Key md5Key
     * @param encryptData  机密后数据格式
     * @return String 响应数据字符串
     */
    public static String decrypt(String partner, String privateKey, String md5Key, EncryptData encryptData) {
        String content = encryptData.getContent();
        String key = encryptData.getKey();
        Integer timestamp = encryptData.getTimestamp();
        String sign = encryptData.getSign();

        // 校验签名
        String signContent = partner + content + key + timestamp + md5Key;
        if (!sign.equalsIgnoreCase(Md5Util.md5(signContent, Charsets.UTF_8))) {
        	throw new RuntimeException("签名验证失败");
        }
        try {
            // 使用rsa解密 对称加密的密钥
            byte[] keyBytes = Base64Util.decode(key);
            byte[] aesKey = RsaUtil.decryptByPrivateKey(keyBytes, privateKey);

            // 使用aes解密 消息内容
            byte[] contentBytes = Base64Util.decode(content);
            byte[] decryptedContent = AesUtil.decrypt(contentBytes, aesKey);

            return new String(decryptedContent, Charsets.UTF_8);
        } catch (Exception e) {
            logger.error("DataUtils Exception message:{}",e.getMessage());
            throw new RuntimeException("解密失败");
        }
    }

}
