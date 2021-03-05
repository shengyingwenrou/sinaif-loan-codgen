
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;


import com.google.common.base.Charsets;
import com.google.common.base.Strings;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;


<#include "/java_imports.include" />
public class AesUtil {

    /**
     * 生成128位随机密钥
     */
    public static byte[] randomKey() {
        return randomKey(128);
    }

    /**
     * 生成随机密钥
     * @param keySize 密钥位数
     */
    private static byte[] randomKey(int keySize) {
        if (keySize != 128) {
            throw new RuntimeException("AES密钥长度不合法. keySize:" + keySize);
        }
        KeyGenerator kg = null;
        try {
            kg = KeyGenerator.getInstance("AES");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        kg.init(keySize, new SecureRandom());
        byte[] key = kg.generateKey().getEncoded();
        return key;
    }

    /**
     * 加密数据
     * @param data 待加密数据
     * @param key 密钥
     */
    public static byte[] encrypt(byte[] data, byte[] key) throws Exception {
        if (key.length != 16) {
            throw new RuntimeException("AES加密失败, 密钥不是128位");
        }
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);
        return cipher.doFinal(data);
    }

    /**
     * 解密数据
     * @param value 待解密数据
     * @param key 密钥
     */
    public static byte[] decrypt(byte[] value, byte[] key) throws Exception {
        if (key.length != 16) {
            throw new RuntimeException("AES解密失败, 密钥不是128位");
        }
        Cipher cipher = Cipher.getInstance("AES");
        SecretKey keySpec = new SecretKeySpec(key, "AES");
        cipher.init(Cipher.DECRYPT_MODE, keySpec);
        return cipher.doFinal(value);
    }


    /**
     * 默认的AES加密字符串方法，可以内部使用
     * 对明文的UTF-8编码字节进行加密，然后使用Base64转码
     * 密钥使用UTF-8编码
     * @param data 明文
     * @param key 加密密钥
     */
    public static String encrypt(String data, String key) throws Exception {
        if (Strings.isNullOrEmpty(data) || Strings.isNullOrEmpty(key)) {
            throw new RuntimeException("AES加密失败, 参数有误. data: " + data + ", key: " + key);
        }
        byte[] keyBytes = key.getBytes(Charsets.UTF_8);
        byte[] dataBytes = data.getBytes(Charsets.UTF_8);
        byte[] encryptBytes = encrypt(dataBytes, keyBytes);
        return Base64Util.encode(encryptBytes);
    }

    /**
     * 默认的AES解密字符串方法，可以内部使用
     * 对密文使用Base64转码后，再进行解密，然后再转为UTF-8编码
     * 密钥使用UTF-8编码
     * @param ciphertext 密文
     * @param key 加密密钥
     */
    public static String decrypt(String ciphertext, String key) throws Exception {
        if (Strings.isNullOrEmpty(ciphertext) || Strings.isNullOrEmpty(key)) {
            throw new RuntimeException("AES解密失败, 参数有误. ciphertext: " + ciphertext + ", key: " + key);
        }
        byte[] keyBytes = key.getBytes(Charsets.UTF_8);
        byte[] dataBytes = Base64Util.decode(ciphertext);
        byte[] keyBytesDecrypt = decrypt(dataBytes, keyBytes);
        return new String(keyBytesDecrypt, Charsets.UTF_8);
    }

    public static void main(String[] args) throws Exception {
        System.out.println(AesUtil.encrypt("都送给了返回观看链接", "1234567890asdfgh"));
        System.out.println(AesUtil.decrypt("KvjpPd24UwoGoq6zTzIsURkv+wvkJ9R77eFFtYqKv5M=", "1234567890asdfgh"));
    }
}
