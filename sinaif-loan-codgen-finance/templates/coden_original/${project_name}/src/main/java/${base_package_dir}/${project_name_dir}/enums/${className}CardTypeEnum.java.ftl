<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}CardTypeEnum {
	
	CREDIT_CARD(1,"信用卡"),
	DEBIT_CARD(2,"储蓄卡")
	;
	
	private int cardType;
	private String desc;
	
	${className}CardTypeEnum(int cardType,String desc) {
		this.cardType = cardType;
		this.desc = desc;
	}

	public int getCardType() {
		return cardType;
	}

	public String getDesc() {
		return desc;
	}


	public static ${className}CardTypeEnum getByCardType(int cardType) {
		for (${className}CardTypeEnum el : ${className}CardTypeEnum.values()) {
			if (el.getCardType() == cardType) {
				return el;
			}
		}
		return null;
	}

}
