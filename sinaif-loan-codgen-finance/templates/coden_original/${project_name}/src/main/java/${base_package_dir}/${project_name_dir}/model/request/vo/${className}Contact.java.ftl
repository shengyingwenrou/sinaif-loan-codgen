<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request.vo;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;

<#include "/java_imports.include" />
public class ${className}Contact implements Serializable {

	private static final long serialVersionUID = 6150205804968049940L;

	/**
	 * 联系⼈类 Emergency[1: ⽗⺟; 2: 配偶; 3: ⼦⼥]
	 * Frequent[4: 朋友; 5: 同事; 6: 亲属]
	 */
	int contactType;
	/**
	 * 姓名
	 */
	@NotBlank(message="联系人姓名不能为空")
	String name;
	/**
	 * 
	 */
	@NotBlank(message="联系人手机号不能为空")
	String mobile;
	
	public ${className}Contact() {}
	
	public ${className}Contact(int contactType, String name, String mobile) {
		this.contactType = contactType;
		this.name = name;
		this.mobile = mobile;
	}
	
	public int getContactType() {
		return contactType;
	}
	public void setContactType(int contactType) {
		this.contactType = contactType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
}
