<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;

<#include "/java_imports.include" />
public class UnitConversionUtil {
	
	public static BigDecimal fenToYuan(long amount) {
		BigDecimal numerator = new BigDecimal(amount);
		BigDecimal denominator = new BigDecimal(100);
		return numerator.divide(denominator, 2, RoundingMode.DOWN);
	}
	
	public static long yuanToFen(double amount) {
		return yuanToFen(String.valueOf(amount));
	}
	
	public static long yuanToFen(String amount) {
		return new BigDecimal(amount).multiply(new BigDecimal(100)).longValue();
	}
	
}
