<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;

import com.google.common.base.Charsets;
import com.google.common.hash.Hashing;

import java.nio.charset.Charset;

<#include "/java_imports.include" />
public class Md5Util {

    /**
     * 对字符串做md5
     * 结果为小写字母
     */
    public static String md5(String content, String charsetName) {
        Charset charset = Charset.forName(charsetName);
        return md5(content, charset);
    }

    /**
     * 对字符串做md5
     * 使用UTF-8编码读取字符串
     * 结果为小写字母
     */
    public static String md5(String content) {
        return md5(content, Charsets.UTF_8);
    }


    /**
     * 对字符串做md5
     * 结果为小写字母
     */
    public static String md5(String content, Charset charset) {
        return md5(content.getBytes(charset));
    }

    /**
     * 对字节数组做md5
     * 结果为小写字母
     */
    public static String md5(byte[] bytes) {
        return Hashing.md5().newHasher().putBytes(bytes).hash().toString();
    }
}
