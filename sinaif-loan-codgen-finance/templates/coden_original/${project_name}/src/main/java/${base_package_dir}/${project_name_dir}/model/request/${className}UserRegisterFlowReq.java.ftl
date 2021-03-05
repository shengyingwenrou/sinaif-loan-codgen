<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import org.hibernate.validator.constraints.NotBlank;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;

<#include "/java_imports.include" />
public class ${className}UserRegisterFlowReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = 1969877088404557464L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_REGISTERFLOW;
	}
	
	/**
	 * 手机号
	 */
	@NotBlank(message="手机号不能为空")
	String mobile;
	/**
	 * 小赢产品id
	 */
	@NotBlank(message="小赢产品id不能为空")
	String productId;
	
	/**
	 * 姓名
	 */
	@NotBlank(message="姓名不能为空")
	String name;
	
	/**
	 * 身份证
	 */
	@NotBlank(message="身份证号不能为空")
	String identity;
	
	/**
	 * 身份证正面url
	 */
	
	String idFrontUrl;
	
	/**
	 * 身份证反面
	 */
	String idBackUrl;
	
	/**
	 * 手持照片
	 */
	String idHandUrl;
	
	/**
	 * 身份证正面
	 */
	@NotBlank(message="身份证正面照片不能为空")
	String idFrontBase64;
	
	/**
	 * 身份证反面
	 */
	@NotBlank(message="身份证反面照片不能为空")
	String idBackBase64;
	
	/**
	 * 手持照片
	 */
	String idHandBase64;

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdentity() {
		return identity;
	}

	public void setIdentity(String identity) {
		this.identity = identity;
	}

	public String getIdFrontUrl() {
		return idFrontUrl;
	}

	public void setIdFrontUrl(String idFrontUrl) {
		this.idFrontUrl = idFrontUrl;
	}

	public String getIdBackUrl() {
		return idBackUrl;
	}

	public void setIdBackUrl(String idBackUrl) {
		this.idBackUrl = idBackUrl;
	}

	public String getIdHandUrl() {
		return idHandUrl;
	}

	public void setIdHandUrl(String idHandUrl) {
		this.idHandUrl = idHandUrl;
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
