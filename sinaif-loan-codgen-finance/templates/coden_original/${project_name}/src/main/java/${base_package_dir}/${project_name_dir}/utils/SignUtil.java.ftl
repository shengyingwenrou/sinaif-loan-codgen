<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.Feature;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.enums.finance.product.NoSignFlag;
import com.sinaif.king.finance.util.Base64;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.*;

<#include "/java_imports.include" />
public class SignUtil {

    private static Logger logger = LoggerFactory.getLogger(SignUtil.class);

    private static final String RSA = "RSA";
    private static final String SIGN_ALGORITHMS = "SHA1WithRSA";
    //private static final String SIGN_ALGORITHMS2 = "SHA256WithRSA";
    private static final String PUBLIC_KEY ="publicKey";
    private static final String PRIVATE_KEY ="privateKey";


    public static String signRequest(${className}BaseReq req, String privateKeyStr) throws Exception {
        String content = JSON.toJSONString(req);
        Map params = JSONObject.parseObject(content, LinkedHashMap.class, Feature.OrderedField);
        boolean clzHasNoSign = req.getClass().isAnnotationPresent(NoSignFlag.class);
        Set<String> noSignFields = null;
        if (clzHasNoSign) {
            NoSignFlag noSignFlag = req.getClass().getAnnotation(NoSignFlag.class);
            String[] noSignFieldsArray = noSignFlag.fields();
            if (noSignFieldsArray.length > 0) {
                noSignFields = new HashSet<>(Arrays.asList(noSignFieldsArray));
            }
            content = sortParams(params, noSignFields);
        } else {
            content = sortParams(params);
        }
        logger.info("????????????{}", StringUtils.subStr4Log(content));
        String signature = rsaSign(content, privateKeyStr);
        logger.info("????????????{}", signature);
        return signature;
    }

    /**
     * ??????
     * @param content   ????????????
     * @param privateKeyStr ???????????????
     * @return signStr ?????????
     */
    private static String rsaSign(String content, String privateKeyStr) throws Exception {
        //??????????????????????????????
        PrivateKey privateKey = getPrivateKey(privateKeyStr);
        //??????
        Signature sign = Signature.getInstance(SIGN_ALGORITHMS);
        sign.initSign(privateKey);
        //???????????????????????????
        sign.update(content.getBytes());
        return Base64.encode(sign.sign());
    }

    /**
     * ????????????
     * @param privateKeyStr
     * @return
     * @throws Exception
     */
    private static RSAPrivateKey getPrivateKey(String privateKeyStr) throws Exception {
        byte[] buffer = Base64.decode(privateKeyStr);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(buffer);
        KeyFactory keyFactory = KeyFactory.getInstance(RSA);
        return (RSAPrivateKey) keyFactory.generatePrivate(keySpec);
    }

    /**
     * ????????????
     * @param publicKeyStr
     * @return
     * @throws Exception
     */
    private static RSAPublicKey getPublicKey(String publicKeyStr) throws Exception {
        byte[] buffer = Base64.decode(publicKeyStr);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(buffer);
        KeyFactory keyFactory = KeyFactory.getInstance(RSA);
        return (RSAPublicKey) keyFactory.generatePublic(keySpec);
    }


    /**
     * ????????????
     * @param content
     * @param sign
     * @param publicKeyStr
     * @return
     */
    public static boolean verifyRequest(String content, String sign, String publicKeyStr) {
        try {
            Map params = JSONObject.parseObject(content, LinkedHashMap.class, Feature.OrderedField);
            content = sortParams(params);
            return verify(content, sign, publicKeyStr);
        } catch (Exception e) {
            logger.error("???????????????", e);
        }
        return false;
    }

    /**
     * ??????
     * @param content
     * @param sign
     * @param publicKeyStr
     * @return
     */
    public static boolean verify(String content, String sign, String publicKeyStr) throws Exception {
        PublicKey publicKey = getPublicKey(publicKeyStr);
        Signature signature = Signature.getInstance(SIGN_ALGORITHMS);
        signature.initVerify(publicKey);
        signature.update(content.getBytes());
        boolean bverify = signature.verify(Base64.decode(sign));
        return bverify;
    }

    public static String sortParams(Map<String, Object> params) {
        String content;
        ArrayList<String> keys = new ArrayList<>(params.keySet());
        Collections.sort(keys);
        StringBuffer sb = new StringBuffer();
        keys.forEach(k-> {
            if (sb.length() > 0){
                sb.append("&");
            }
            if(params.get(k) != null) {
                sb.append(k).append("=").append(String.valueOf(params.get(k)));
            }
        });
        content = sb.toString();
        logger.info("???????????????{}", StringUtils.subStr4Log(content));
        return content;
    }

    public static String sortParams(Map<String, Object> params, Set<String> noSignFields) {
        String content;
        ArrayList<String> keys = new ArrayList<>(params.keySet());
        Collections.sort(keys);
        StringBuffer sb = new StringBuffer();
        keys.forEach(k-> {
            if (CollectionUtils.isEmpty(noSignFields) || !noSignFields.contains(k)) {
                if (sb.length() > 0){
                    sb.append("&");
                }
                if(params.get(k) != null) {
                    sb.append(k).append("=").append(String.valueOf(params.get(k)));
                }
            }
        });
        content = sb.toString();
        logger.info("???????????????{}", StringUtils.subStr4Log(content));
        return content;
    }

    public static Map<String,String> genKey() throws NoSuchAlgorithmException {
        Map<String,String> keyMap = new HashMap<String,String>();
        KeyPairGenerator keygen = KeyPairGenerator.getInstance(RSA);
        SecureRandom random = new SecureRandom();
        // random.setSeed(keyInfo.getBytes());
        // ???????????????512?????????????????????1024???,?????????2048???
        keygen.initialize(1024, random);
        // ???????????????
        KeyPair kp = keygen.generateKeyPair();
        RSAPrivateKey privateKey = (RSAPrivateKey)kp.getPrivate();
        String privateKeyString = Base64.encode(privateKey.getEncoded());
        RSAPublicKey publicKey = (RSAPublicKey)kp.getPublic();
        String publicKeyString = Base64.encode(publicKey.getEncoded());
        System.out.println(privateKeyString);
        System.out.println(publicKeyString);
        keyMap.put(PUBLIC_KEY, publicKeyString);
        keyMap.put(PRIVATE_KEY, privateKeyString);
        return keyMap;
    }

}
