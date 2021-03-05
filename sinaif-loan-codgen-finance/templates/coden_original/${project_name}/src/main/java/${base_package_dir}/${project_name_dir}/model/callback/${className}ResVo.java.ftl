
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.callback;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CodeStatusEnum;
import java.io.Serializable;
<#include "/java_imports.include" />

public class ${className}ResVo<T> implements Serializable{

	private static final long serialVersionUID = 2783708428392022533L;
	

	private int errCode;
	private String errStr;
	private T data;
	
	public ${className}ResVo(${className}CodeStatusEnum status) {
		this.errCode = status.getCode();
		this.errStr = status.getDesc();
	}
	
	public ${className}ResVo(int errCode,String errStr) {
		this.errCode = errCode;
		this.errStr = errStr;
	}
	
	public int getErrCode() {
		return errCode;
	}
	public void setErrCode(int errCode) {
		this.errCode = errCode;
	}
	public String getErrStr() {
		return errStr;
	}
	public void setErrStr(String errStr) {
		this.errStr = errStr;
	}
	public T getData() {
		return data;
	}
	public void setData(T data) {
		this.data = data;
	}

}
