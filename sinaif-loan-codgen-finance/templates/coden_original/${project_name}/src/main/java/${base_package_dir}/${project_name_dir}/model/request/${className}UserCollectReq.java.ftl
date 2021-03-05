
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;

import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}AddressInfo;
import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}Contact;

<#include "/java_imports.include" />

public class ${className}UserCollectReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = -6054472081276729806L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_COLLECT;
	}
	
	/**
	 * 流程id (小赢返回)
	 */
	@NotBlank(message="流程id不能为空")
	String flowId;
	
	/**
	 * 地址信息（居住地址）
	 */
	${className}AddressInfo addressInfo;
	
	/**
	 * 紧急联系⼈ (紧急联系⼈需要和常⽤联系⼈⼀起提交) 
	 */
	${className}Contact emergencyContact;
	
	/**
	 * 常⽤联系⼈
	 */
	${className}Contact frequentContact;

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}

	public ${className}AddressInfo getAddressInfo() {
		return addressInfo;
	}

	public void setAddressInfo(${className}AddressInfo addressInfo) {
		this.addressInfo = addressInfo;
	}

	public ${className}Contact getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(${className}Contact emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	public ${className}Contact getFrequentContact() {
		return frequentContact;
	}

	public void setFrequentContact(${className}Contact frequentContact) {
		this.frequentContact = frequentContact;
	}

}
