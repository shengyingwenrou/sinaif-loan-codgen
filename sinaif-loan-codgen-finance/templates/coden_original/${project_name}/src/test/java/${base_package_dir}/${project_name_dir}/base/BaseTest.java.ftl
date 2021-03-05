<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.base;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.google.common.base.Charsets;
import com.sinaif.king.finance.${classNameLower}.model.request.base.XyfqBaseReq;
import com.sinaif.king.finance.${classNameLower}.utils.AesUtil;
import com.sinaif.king.finance.${classNameLower}.utils.Base64Util;
import com.sinaif.king.finance.${classNameLower}.utils.GsonUtil;
import com.sinaif.king.finance.${classNameLower}.utils.Md5Util;
import com.sinaif.king.finance.${classNameLower}.utils.OkHttpUtil;
import com.sinaif.king.finance.${classNameLower}.utils.RsaUtil;

<#include "/java_imports.include" />

public class BaseTest {

   public final static String FINANCE_PRODUCT_ID = "10001";

    /** ${log_finance_name}测试环境**/
    public final static String serverUrl_test = "http://bjtestldp.xiaoying.com";
    /** ${log_finance_name}生产环境**/
    public final static String serverUrl_prod = "https://ldp.xiaoying.com";
    public final static String MOCK_URL = "http://192.168.1.62:8000/non-standard/2005201";
    // 合作方自己的私钥 需我方提供

    public final static String partnerPrivateKey = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMHaKAxHKqBrf/0D1mQxEgzR9iTstqB7VIU7vi90GvI21bV35YLj0T18IoNmzHasf753Qbe1hShVPHmFDZUMZpyShExjryzi8xLsP9OfZuR32KhEgDlH1nVFyRBhubwTEAkDzJViEjn2uSFsiohvZBkHAwpPBFIvwT8p4/r5mX1bAgMBAAECgYEAivceAHc/+pI1xSZsGZUH0ILvhlbfMLpYw84pL5F3A64Fk7pooGU6iW4ku7gE2Qod5WdOiCirVVeNK7wTGYczQsiPyMOMhs+316V3ULJ2vyyYi7Bdav8JIVMhBKkvQcAl5Xlwv8TqEaky1Or72Uxq3oUdu/+GE9+P+rE0ihyUfnkCQQDvw9jyIa/1pd3+x0DtSBJrYtdWzPBnHmT08rxd1zfbJjvMCVGin2WqUqwU2qUrF1LCUq4qbejz9XdnRPWto05VAkEAzvpxaMXSx75SHyqK1CAQmfj6TEMLQgbZWaV6nALCNajJPPtP4RHgmdEtNwhL4uinmfK9Of8NPWjj6KjSXTns7wJBANqLwP8L19DojM6EHtlqPWfm43P6QBMucEWZ0DsVRpOaaR0VTXUXJ9s1mic0GSOLEeOQ67I/FvzwPRNDl1DbrzUCQA3WBhDH8KAzo8+7i05E2ndAgpLohG8kgBETE9AsCwmFP/aYoi1cgZQmvIwKPPBtNw7+gBHJb/wj7+BUsMNUpPcCQDRugqSzRKDQgfu0R6+MQBKzqmtSohF6oRHrKIreo9WWcJOGvMAYXK2HnvhxeG026+uBfgjRVyCOoRke8nM5VLQ=";
    // 合作方自己的公钥 需我方提供
    public final static String partnerPublicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDB2igMRyqga3/9A9ZkMRIM0fYk7Lage1SFO74vdBryNtW1d+WC49E9fCKDZsx2rH++d0G3tYUoVTx5hQ2VDGackoRMY68s4vMS7D/Tn2bkd9ioRIA5R9Z1RckQYbm8ExAJA8yVYhI59rkhbIqIb2QZBwMKTwRSL8E/KeP6+Zl9WwIDAQAB";


    // 小赢的公钥 需要小赢提供（上线）
    public final static String xyfqPublicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDC3TMrNpRMYx9JpID04eBf0vj8fHxeAex6ka4Pv3gyCGvRJ3N/SOmrE/gxrOxxjiaH897g/KrCSzhBvAyCcGuXHVkh+fzhbbevZn+/VudYZ8WniTDVLjmQsdeCQT7xYSE9I0vFnCOnZO8Z/fbumsluh5yeNq5DqSrL0NoEiJ6oSQIDAQAB";
    // 小赢的私钥
   // public final static String xiaoyingPrivateKey = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMLdMys2lExjH0mkgPTh4F/S+Px8fF4B7HqRrg+/eDIIa9Enc39I6asT+DGs7HGOJofz3uD8qsJLOEG8DIJwa5cdWSH5/OFtt69mf79W51hnxaeJMNUuOZCx14JBPvFhIT0jS8WcI6dk7xn99u6ayW6HnJ42rkOpKsvQ2gSInqhJAgMBAAECgYAv11Lqtxmtr2BNGkA23wXRQOC0THPUOLCwXvfXEfEWh47A6OioRWRpBhwXRhc+weGf2zXLEv1xejozmVGQ7LzdDLCxCDJHBs4mOq7nc/3J9YxJSRSrlf86ke/TAE90pPi4rEDluwwlTLKtxdzh9cr6lJw8oCL8Y7oIdbd9+XjkaQJBAPc8nntrdWqWwaITarccpHnj4spuu9S5tLiYHC4Eba87ODGZj7+vWycrP1epHQrH4Gmr4hnJYnCvDvJKnu7ysHMCQQDJxVw+ttsVBm/vC5ewSYKmJ0i/roS8IbEfvqr3J7mPoytF3pnX+DC8B/myxHM7+9JIugPMthgyLRLCHOjpBQFTAkEA6tsDtTvz8se4sqx9L+qed0c51ZBxDvdFrCCajEAarV202LEF81GxZjjX1/7GnsoV7GuhwVsjDuXMbe7ioRua7wJARliR1aeo8EajReNzylmGvGkb2wB8dJ8GgvvV3X+zGVoZHy4B0yNL0nKxYttNFc+xO/vmkTu3ad7/GEA+D+fX0wJBALV1Chq6WMBMJQVJaZtLze0Nb9Z/DHHyQyZR38wYh7mQvaiUJ9Ks1sRC1T3//7KcP2sJ65+YEeV3DHkk6Q7RO5I=";

    // md5签名的附加字符串 需要小赢提供（上线）
    public final static String md5Key = "5a72384d7b36484c32795c516368335d";
    
    //合作方标识 需要小赢提供（上线）
    public final static String PARTNER_FLAG = "XINLANGAPI";


    // 发送请求
    /**
     * Description: MD5验签
     * RSA 加解密 AES随机key
     * AES key加解密传输内容
     * @param url
     * @param content
     * @return
     * @throws IOException
     * @Date  2019年6月5日 上午10:27:56
     */
    public static String request(String url, String content) throws IOException {
        // 使用小赢的公钥加密请求
        EncryptData encryptData = encrypt(PARTNER_FLAG, xyfqPublicKey, md5Key, content);
        Map<String, String> params = new HashMap<>();
        params.put("key", encryptData.getKey());
        params.put("content", encryptData.getContent());
        params.put("timestamp", String.valueOf(encryptData.getTimestamp()));
        params.put("sign", encryptData.getSign());
        String responseBody = OkHttpUtil.post(url + "?partner=" + PARTNER_FLAG, params);
        // 使用自己的私钥解密返回
        String responseContent = decrypt(PARTNER_FLAG, partnerPrivateKey, md5Key, GsonUtil.defaultGson().fromJson(responseBody, EncryptData.class));
        return responseContent;
    }
    
    public static String request(String serviceUrl,XyfqBaseReq req) throws IOException {
    	String url = serviceUrl + req.getTransCode().getUri();
		String content = com.alibaba.fastjson.JSON.toJSONString(req);
		String userId = req.getHeader().getUserid();
		String codeTem = req.getTransCode().getCode();
		saveRequestToNativeFile(content,userId+"_"+codeTem+"_plain_req");//请求明文
        // 使用小赢的公钥加密请求
        EncryptData encryptData = encrypt(PARTNER_FLAG, xyfqPublicKey, md5Key, content);
        Map<String, String> params = new HashMap<>();
        params.put("key", encryptData.getKey());
        params.put("content", encryptData.getContent());
        params.put("timestamp", String.valueOf(encryptData.getTimestamp()));
        params.put("sign", encryptData.getSign());
        saveRequestToNativeFile(com.alibaba.fastjson.JSON.toJSONString(params),userId+"_"+codeTem+"_encry_req");//请求密文
        String responseBody = OkHttpUtil.post(url + "?partner=" + PARTNER_FLAG, params);
        saveRequestToNativeFile(responseBody,userId+"_"+codeTem+"_encry_res");//返回原始密文
        // 使用自己的私钥解密返回
        String responseContent = decrypt(PARTNER_FLAG, partnerPrivateKey, md5Key, GsonUtil.defaultGson().fromJson(responseBody, EncryptData.class));
        saveRequestToNativeFile(responseContent,userId+"_"+codeTem+"_plain_res");//返回明文
        return responseContent;
    }
    
    static void saveRequestToNativeFile(String content,String orderId) {
		String logDir = "C:/mine/test/logs/";
		String filename = orderId;
		File file = new File(logDir+filename+".txt");
		int fileNum = 1;
		while(file.exists()) {
			file = new File(logDir+filename+"_"+fileNum+".txt");
			fileNum++;
		}
		try {
			OutputStream os = new FileOutputStream(file);
			os.write(content.getBytes("utf-8"));
			os.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


    // 加密数据
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
            System.out.println("加密失败");
            e.printStackTrace();
        }
        return null;
    }

    // 解密数据
    public static String decrypt(String partner, String privateKey, String md5Key, EncryptData encryptData) {
        String content = encryptData.getContent();
        String key = encryptData.getKey();
        Integer timestamp = encryptData.getTimestamp();
        String sign = encryptData.getSign();

        // 校验签名
        String signContent = partner + content + key + timestamp + md5Key;
        if (!sign.equalsIgnoreCase(Md5Util.md5(signContent, Charsets.UTF_8))) {
            System.out.println("签名验证失败");
            return null;
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
            System.out.println("解密失败");
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 加密的数据
     */
    public static class EncryptData {
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

}
