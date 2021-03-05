<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;

import java.util.Base64;

<#include "/java_imports.include" />
public class Base64Util {

    /**
     * 将字节数组编码为字符串
     */
    public static String encode(byte[] data) {
        return Base64.getEncoder().encodeToString(data);
    }

    /**
     * 将字符串解码为字节数组
     */
    public static byte[] decode(String str) {
        // 处理换行符
        str = str.replace("\n", "");
        return Base64.getDecoder().decode(str);
    }
}
