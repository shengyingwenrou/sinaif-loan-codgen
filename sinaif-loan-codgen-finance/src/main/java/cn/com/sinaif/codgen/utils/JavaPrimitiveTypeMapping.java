/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.utils;

import com.google.common.collect.Maps;

import org.apache.commons.lang3.StringUtils;

import java.util.Map;

/**
 * java原生类型映射. User: skysong(841676215@qq.com) Date: 13-11-18 Time: 上午10:36
 */
public final class JavaPrimitiveTypeMapping {

	static Map<String, String> wrapper2primitive = Maps.newHashMap();
	static Map<String, String> primitive2wrapper = Maps.newHashMap();
	static Map<String, String> wrapper2Mybatis = Maps.newHashMap();
	static Map<String, String> wrapper2JFinal = Maps.newHashMap();

	static {
		wrapper2primitive.put("Byte", "byte");
		wrapper2primitive.put("Short", "short");
		wrapper2primitive.put("Integer", "int");
		wrapper2primitive.put("Long", "long");
		wrapper2primitive.put("Float", "float");
		wrapper2primitive.put("Double", "double");
		wrapper2primitive.put("Boolean", "boolean");
		wrapper2primitive.put("Character", "char");

		wrapper2Mybatis.put("String", "VARCHAR");
		wrapper2Mybatis.put("BigDecimal", "NUMERIC");
		wrapper2Mybatis.put("Boolean", "BIT");
		wrapper2Mybatis.put("Byte", "TINYINT");
		wrapper2Mybatis.put("Short", "SMALLINT");
		wrapper2Mybatis.put("Integer", "INTEGER");
		wrapper2Mybatis.put("Long", "BIGINT");
		wrapper2Mybatis.put("Float", "FLOAT");
		wrapper2Mybatis.put("Double", "DOUBLE");
		wrapper2Mybatis.put("Date", "TIMESTAMP");
		wrapper2Mybatis.put("Timestamp", "TIMESTAMP");
		wrapper2Mybatis.put("Character", "CHAR");

		wrapper2JFinal.put("Byte", "Byte");
		wrapper2JFinal.put("Short", "Short");
		wrapper2JFinal.put("Integer", "Int");
		wrapper2JFinal.put("Long", "Long");
		wrapper2JFinal.put("Float", "Float");
		wrapper2JFinal.put("Double", "Double");
		wrapper2JFinal.put("Boolean", "Boolean");
		wrapper2JFinal.put("Character", "Char");
		wrapper2JFinal.put("String", "Str");
		wrapper2JFinal.put("Date", "Date");
		wrapper2JFinal.put("BigDecimal", "BigDecimal");

		for (String key : wrapper2primitive.keySet()) {
			primitive2wrapper.put(wrapper2primitive.get(key), key);
		}
	}

	public static String getPrimitiveTypeOrNull(String clazz) {
		String className = CodgenUtil.getJavaClassSimpleName(clazz);
		return wrapper2primitive.get(className);
	}

	public static String getPrimitiveType(String clazz) {
		String className = CodgenUtil.getJavaClassSimpleName(clazz);
		String result = wrapper2primitive.get(className);
		return result == null ? clazz : result;
	}

	public static String getMybatisType(String clazz) {
		String className = CodgenUtil.getJavaClassSimpleName(clazz);
		String result = wrapper2Mybatis.get(className);
		return result == null ? clazz : result;
	}

	public static String getJFinalType(String clazz) {
		String className = CodgenUtil.getJavaClassSimpleName(clazz);
		String result = wrapper2JFinal.get(className);
		return result == null ? clazz : result;
	}

	public static String getWrapperTypeOrNull(String clazz) {
		return primitive2wrapper.get(clazz);
	}

	public static String getWrapperType(String clazz) {
		String result = primitive2wrapper.get(clazz);
		return result == null ? clazz : result;
	}

	public static String getDefaultValue(String type) {
		if (StringUtils.isBlank(type)) {
			return "null";
		} else if (type.endsWith("Money")) {
			// special case
			return "0";
		} else if (type.lastIndexOf(".") > 0) {
			return "null";
		} else if (Character.isUpperCase(type.charAt(0))) {
			return "null";
		} else if ("boolean".equals(type)) {
			return "false";
		} else if (getWrapperTypeOrNull(type) != null) {
			return "0";
		} else {
			return "null";
		}
	}

	private JavaPrimitiveTypeMapping() {
	}
}
