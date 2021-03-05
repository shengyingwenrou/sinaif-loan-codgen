/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.utils;

import com.google.common.collect.Maps;

import java.sql.Types;
import java.util.Map;

/**
 * 数据库数据类型处理工具类.
 * User: skysong(841676215@qq.com)
 * Date: 13-11-18
 * Time: 下午2:41
 */
public final class DBDataTypeUtil {
    private static final Map<Integer, String> PREFERRED_JAVATYPE_FOR_SQLTYPE = Maps.newHashMap();

    /**
     * @param sqlType       数据库中的类型
     * @param size          大小
     * @param decimalDigits 精度
     * @return 获取相应的java类型
     */
    public static String getPreferredJavaType(int sqlType, int size, int decimalDigits) {
        if ((sqlType == Types.DECIMAL || sqlType == Types.NUMERIC) && decimalDigits == 0) {
            if (size == 1) {
                return "java.lang.Boolean";
            } else if (size < 3) {
                return "java.lang.Byte";
            } else if (size < 5) {
                return "java.lang.Short";
            } else if (size < 10) {
                return "java.lang.Integer";
            } else if (size < 19) {
                return "java.lang.Long";
            } else {
                return "java.math.BigDecimal";
            }
        }
        String result = PREFERRED_JAVATYPE_FOR_SQLTYPE.get(sqlType);
        if (null == result) {
            result = "java.lang.Object";
        }
        return result;
    }

    public static boolean isString(String javaType) {
        return javaType.endsWith("String");
    }

    public static boolean isDate(String javaType) {
        return javaType.endsWith("Date") || javaType.endsWith("Timestamp") || javaType.endsWith("Time");
    }

    public static boolean isFloatNumber(String javaType) {
        String type = javaType.toLowerCase();
        return type.endsWith("float") || type.endsWith("double") || type.endsWith("bigdecimal") ||
                type.endsWith("biginteger");
    }

    public static boolean isIntegerNumber(String javaType) {
        String type = javaType.toLowerCase();
        return type.endsWith("long") || type.endsWith("int") || type.endsWith("short") ||
                type.endsWith("byte");
    }

    static {
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.TINYINT, "java.lang.Byte");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.SMALLINT, "java.lang.Short");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.INTEGER, "java.lang.Integer");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.BIGINT, "java.lang.Long");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.REAL, "java.lang.Float");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.FLOAT, "java.lang.Double");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.DOUBLE, "java.lang.Double");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.DECIMAL, "java.math.BigDecimal");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.NUMERIC, "java.math.BigDecimal");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.BIT, "java.lang.Boolean");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.BOOLEAN, "java.lang.Boolean");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.CHAR, "java.lang.String");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.VARCHAR, "java.lang.String");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.LONGVARCHAR, "java.lang.String");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.BINARY, "byte[]");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.VARBINARY, "byte[]");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.LONGVARBINARY, "byte[]");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.DATE, "java.sql.Date");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.TIME, "java.sql.Time");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.TIMESTAMP, "java.sql.Timestamp");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.CLOB, "java.sql.Clob");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.BLOB, "java.sql.Blob");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.ARRAY, "java.sql.Array");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.REF, "java.sql.Ref");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.STRUCT, "java.lang.Object");
        PREFERRED_JAVATYPE_FOR_SQLTYPE.put(Types.JAVA_OBJECT, "java.lang.Object");
    }

    private DBDataTypeUtil() {
    }
}
