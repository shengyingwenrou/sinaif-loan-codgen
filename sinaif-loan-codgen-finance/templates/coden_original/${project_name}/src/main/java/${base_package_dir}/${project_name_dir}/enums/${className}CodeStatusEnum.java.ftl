<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
<#include "/java_imports.include" />
public enum ${className}CodeStatusEnum {
	SUCCESS(0,"成功"),
	PARAM_EXCEPTION(-1,"输入参数异常"),
	SYS_EXCEPTION(-2,"系统异常"),
	FORBID_APPLY(1012,"不允许申请"),
	FLOW_EXCEPTION(1013,"异常的流程"),
	REPEAT_APPLY(1012,"重复申请"),;
	private int code;
	private String desc;
	
	${className}CodeStatusEnum(int code,String desc) {
		this.code = code;
		this.desc = desc;
	}
	
	public int getCode() {
		return code;
	}

	public String getDesc() {
		return desc;
	}
}
