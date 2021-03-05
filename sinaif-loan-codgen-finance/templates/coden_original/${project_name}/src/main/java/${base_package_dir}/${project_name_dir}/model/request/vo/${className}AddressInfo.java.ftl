<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request.vo;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;

<#include "/java_imports.include" />

public class ${className}AddressInfo implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 城市编码 国标码 6位数字
	 */
	@NotBlank(message="城市编码不能为空")
	String cityCode;
	
	/**
	 * 详细地址
	 */
	@NotBlank(message="详细地址不能为空")
	String address;
	
	public ${className}AddressInfo() {}
	
	public ${className}AddressInfo(String cityCode, String address) {
		this.cityCode = cityCode;
		this.address = address;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
