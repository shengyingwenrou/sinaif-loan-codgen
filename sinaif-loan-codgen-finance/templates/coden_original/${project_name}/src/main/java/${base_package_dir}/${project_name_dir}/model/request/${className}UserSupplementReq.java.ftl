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
<#include "/java_imports.include" />

public class ${className}UserSupplementReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = -6054472081276729806L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_SUPPLEMENT;
	}
	
	String flowId;
	
	/**
	 * 身份证正面
	 */
	String idFrontBase64;
	
	/**
	 * 身份证反面
	 */
	String idBackBase64;
	
	/**
	 * 手持照片
	 */
	String idHandBase64;

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}

	public String getIdFrontBase64() {
		return idFrontBase64;
	}

	public void setIdFrontBase64(String idFrontBase64) {
		this.idFrontBase64 = idFrontBase64;
	}

	public String getIdBackBase64() {
		return idBackBase64;
	}

	public void setIdBackBase64(String idBackBase64) {
		this.idBackBase64 = idBackBase64;
	}

	public String getIdHandBase64() {
		return idHandBase64;
	}

	public void setIdHandBase64(String idHandBase64) {
		this.idHandBase64 = idHandBase64;
	}

}
