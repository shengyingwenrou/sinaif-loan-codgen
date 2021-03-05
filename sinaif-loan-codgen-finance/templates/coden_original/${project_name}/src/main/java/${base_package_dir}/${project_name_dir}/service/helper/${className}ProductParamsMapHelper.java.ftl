<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.helper;

import com.sinaif.king.enums.common.FinanceCommonParamEnum;

import java.util.Map;

<#include "/java_imports.include" />
public class ${className}ProductParamsMapHelper {



	public static String getServerUrl(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.PCODE_SERVERURL.getCode());
	}


	public static String getMd5Key(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.PCODE_MD5KEY.getCode());
	}

	public static String getClientPublicKey(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.PCODE_CLIENT_PUBLIC_KEY.getCode());
	}
	
	public static String getPublicKey(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.PCODE_PUBLIC_KEY.getCode());
	}
	
	public static String getPrivateKey(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.PCODE_PRIVATE_KEY.getCode());
	}

	
	public static String getLoanIntention(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.${classNameUpper}_LOAN_INTENTION.getCode());
	}

	public static String getFaceSource(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.${classNameUpper}_FACE_SOURCE.getCode());
	}
	
	public static String getClientProductId(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.${classNameUpper}_CLIENT_PRODUCT_ID.getCode());
	}

	public static String getPartenerFlag(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.${classNameUpper}_PARTENER_FLAG.getCode());
	}
	
	public static String getCreditWaitday(Map<String, String> productParamsMap) {
		return productParamsMap.get(FinanceCommonParamEnum.PCODE_CREDITWAITDAY.getCode());
	}




}
