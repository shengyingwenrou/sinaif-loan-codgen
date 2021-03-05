<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;

import com.google.common.base.Charsets;

import javax.crypto.Cipher;
import java.io.ByteArrayOutputStream;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

<#include "/java_imports.include" />
public class RsaUtil {
    /**
     * RSA最大加密明文大小
     * 1024位的证书，加密时最大支持117个字节，解密时为128
     * 2048位的证书，加密时最大支持245个字节，解密时为256
     */
    private static final int MAX_ENCRYPT_BLOCK = 117;

    /**
     * RSA最大解密密文大小
     * 1024位的证书，加密时最大支持117个字节，解密时为128
     * 2048位的证书，加密时最大支持245个字节，解密时为256
     */
    private static final int MAX_DECRYPT_BLOCK = 128;

    /**
     * 获取公钥
     */
    private static PublicKey getPublicKey(String key) throws Exception {
        byte[] keyBytes = Base64Util.decode(key);

        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PublicKey publicKey = keyFactory.generatePublic(keySpec);
        return publicKey;
    }

    /**
     * 获取私钥
     */
    public static PrivateKey getPrivateKey(String key) throws Exception {
        byte[] keyBytes = Base64Util.decode(key);

        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
        return privateKey;
    }

    /**
     * RSA的签名算法
     */
    public static enum SignatureAlgorithm {
        MD5withRSA("MD5withRSA"),
        SHA1withRSA("SHA1withRSA"),
        ;

        private String name;

        public String getName() {
            return name;
        }

        SignatureAlgorithm(String name) {
            this.name = name;
        }
    }

    /**
     * 使用私钥签名
     * @param data 明文数据
     * @param privateKey 私钥
     * @param signatureAlgorithm 签名算法
     */
    private static String signByPrivate(byte[] data, String privateKey, SignatureAlgorithm signatureAlgorithm) throws Exception {
        PrivateKey key = getPrivateKey(privateKey);
        return signByPrivate(data, key, signatureAlgorithm);
    }

    private static String signByPrivate(byte[] data, PrivateKey privateKey, SignatureAlgorithm signatureAlgorithm) throws Exception {
        // 用私钥对信息生成数字签名
        Signature signature = Signature.getInstance(signatureAlgorithm.getName());
        signature.initSign(privateKey);
        signature.update(data);
        byte[] sign = signature.sign();
        return Base64Util.encode(sign);
    }

    /**
     * 使用公钥验证签名
     * @param data 密文数据
     * @param publicKey 公钥
     * @param signatureAlgorithm 签名算法
     * @param sign 待验证签名字符串
     */
    private static boolean verifyByPublicKey(byte[] data, String publicKey, SignatureAlgorithm signatureAlgorithm, String sign) throws Exception {
        PublicKey key = getPublicKey(publicKey);
        return verifyByPublicKey(data, key, signatureAlgorithm, sign);
    }

    private static boolean verifyByPublicKey(byte[] data, PublicKey publicKey, SignatureAlgorithm signatureAlgorithm, String sign) throws Exception {
        Signature signature = Signature.getInstance(signatureAlgorithm.getName());
        signature.initVerify(publicKey);
        signature.update(data);

        // 验证签名是否正常
        byte[] decode = Base64Util.decode(sign);
        return signature.verify(decode);
    }

    /**
     * 使用私钥加密数据
     * @param data 明文数据
     * @param privateKey 私钥
     */
    public static byte[] encryptByPrivateKey(byte[] data, String privateKey) throws Exception {
        // 获取私钥对象
        PrivateKey key = getPrivateKey(privateKey);

        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, key);

        int inputLen = data.length;
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int offSet = 0;
        byte[] cache;
        int i = 0;
        // 对数据分段加密
        while (inputLen - offSet > 0) {
            if (inputLen - offSet > MAX_ENCRYPT_BLOCK) {
                cache = cipher.doFinal(data, offSet, MAX_ENCRYPT_BLOCK);
            } else {
                cache = cipher.doFinal(data, offSet, inputLen - offSet);
            }
            out.write(cache, 0, cache.length);
            i++;
            offSet = i * MAX_ENCRYPT_BLOCK;
        }
        byte[] encryptedData = out.toByteArray();
        out.close();
        return encryptedData;
    }

    /**
     * 使用公钥加密数据
     * @param data 明文数据
     * @param publicKey 公钥
     */
    public static byte[] encryptByPublicKey(byte[] data, String publicKey) throws Exception {
        // 获取公钥对象
        PublicKey key = getPublicKey(publicKey);

        // 对数据加密
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, key);

        int inputLen = data.length;
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int offSet = 0;
        byte[] cache;
        int i = 0;
        // 对数据分段加密
        while (inputLen - offSet > 0) {
            if (inputLen - offSet > MAX_ENCRYPT_BLOCK) {
                cache = cipher.doFinal(data, offSet, MAX_ENCRYPT_BLOCK);
            } else {
                cache = cipher.doFinal(data, offSet, inputLen - offSet);
            }
            out.write(cache, 0, cache.length);
            i++;
            offSet = i * MAX_ENCRYPT_BLOCK;
        }
        byte[] encryptedData = out.toByteArray();
        out.close();
        return encryptedData;
    }

    /**
     * 使用私钥解密数据
     * @param encryptedData 密文数据
     * @param privateKey 私钥
     */
    public static byte[] decryptByPrivateKey(byte[] encryptedData, String privateKey) throws Exception {
        // 获取私钥对象
        PrivateKey key = getPrivateKey(privateKey);

        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, key);

        int inputLen = encryptedData.length;
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int offSet = 0;
        byte[] cache;
        int i = 0;
        // 对数据分段解密
        while (inputLen - offSet > 0) {
            if (inputLen - offSet > MAX_DECRYPT_BLOCK) {
                cache = cipher.doFinal(encryptedData, offSet, MAX_DECRYPT_BLOCK);
            } else {
                cache = cipher.doFinal(encryptedData, offSet, inputLen - offSet);
            }
            out.write(cache, 0, cache.length);
            i++;
            offSet = i * MAX_DECRYPT_BLOCK;
        }
        byte[] decryptedData = out.toByteArray();
        out.close();
        return decryptedData;
    }

    /**
     * 使用公钥解密
     * @param encryptedData 密文数据
     * @param publicKey 公钥
     */
    public static byte[] decryptByPublicKey(byte[] encryptedData, String publicKey) throws Exception {
        // 获取公钥对象
        PublicKey key = getPublicKey(publicKey);

        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, key);

        int inputLen = encryptedData.length;
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int offSet = 0;
        byte[] cache;
        int i = 0;
        // 对数据分段解密
        while (inputLen - offSet > 0) {
            if (inputLen - offSet > MAX_DECRYPT_BLOCK) {
                cache = cipher.doFinal(encryptedData, offSet, MAX_DECRYPT_BLOCK);
            } else {
                cache = cipher.doFinal(encryptedData, offSet, inputLen - offSet);
            }
            out.write(cache, 0, cache.length);
            i++;
            offSet = i * MAX_DECRYPT_BLOCK;
        }
        byte[] decryptedData = out.toByteArray();
        out.close();
        return decryptedData;
    }

    /**
     * 生成密钥对
     * @param keysize 密钥长度：1024、2048
     */
    private static void generateKeyPair(Integer keysize) throws Exception {
        // 生成RSA Key
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(keysize);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();
        PublicKey publicKey = keyPair.getPublic();
        PrivateKey privateKey = keyPair.getPrivate();

        System.out.println("公钥: " + Base64Util.encode(publicKey.getEncoded()));
        System.out.println("私钥: " + Base64Util.encode(privateKey.getEncoded()));
    }

    public static void main(String[] args) throws Exception {
        // 生成密钥对
//        RsaUtil.generateKeyPair(1024);
        String publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAtIXU1PVIOfueoZq189CBDvaX" +
                "MwgLu+5+T0j7t98Lrb8XQjrZV0c1Hueb48Q9/VF8ui1Ki/MrT9TxrbX+J509+zWC" +
                "kAuJFuzAntknasOgQirbVxrSs72oX1gIyshwcwBxgV8tWpqXPK3Jb/6CFS5Gc9Nh" +
                "Nzm0xFZ/JRukefwL1QIDAQAB";
        String privateKey = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMC0hdTU9Ug5+56h" +
                "mrXz0IEO9pczCAu77n5PSPu33wutvxdCOtlXRzUe55vjxD39UXy6LUqL8ytP1PGt" +
                "tf4nnT37NYKQC4kW7MCe2Sdqw6BCKttXGtKzvahfWAjKyHBzAHGBXy1ampc8rclv" +
                "/oIVLkZz02E3ObTEVn8lG6R5/AvVAgMBAAECgYBAjDdH0w1V5BYkTH1F9SUiFaED" +
                "hFRtmcWJCYWoyy4q+0fGwqhzpIh1gqSR0vkoynFBFhuVnMsW9uadDVKojxxb0Sfz" +
                "BjRUqnNTtC2oeKp6ehOnnt1brOuSo5eRRYfM1O4f3rUtVo2dCH+KomiIlWPdr+b4" +
                "5Cp0i92OR0JYgSzwAQJBAPKw00W7HE0ixwDcN1hGuI8KXJc/fXTMD7ILxxEBtTxR" +
                "wlCXB2R0st+MhaMMuEm9IQjD3exHnMVht5dtvJDkKgUCQQDLRfEtfmK6BbR94P0P" +
                "SBBSrqf0yjsA6WRBVJi1wIvbr4+xp+odw4SSiMkAl7lmKmSgvm5D0PdE5wpLzmAI" +
                "YHORAkB8clwEF8yNaVXuhP4EUE93WfLcw/vLFpC91fhAKkYLJkmkFa3+vzCyHVax" +
                "o2Ykuczkt7tm29nyBQelqOnWyokZAkEAhHDRrt6F3MYSz2FkACzn1bdOX0PUJcfr" +
                "NlW0GdeWSFCewxWwiCv3mLHepLA2b8Z3QfRRS4Y/VXljT/jqwQp2wQJAT6FeKdAK" +
                "NE10olke/CqH7YMyqEf4eDHCxaVcHzvlS9TRlLSeqx7mX37QEFeSGragMsCTd3H6" +
                "8xlppfH/kVokIg==";

        String s = "只是测试一下";
        byte[] bytes = RsaUtil.encryptByPublicKey(s.getBytes(Charsets.UTF_8), publicKey);
        System.out.println(Base64Util.encode(bytes));
        bytes = RsaUtil.encryptByPrivateKey(s.getBytes(Charsets.UTF_8), privateKey);
        System.out.println(Base64Util.encode(bytes));

    }

}
