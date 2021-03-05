
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

public class ${className}UserCheckLoanReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = -6868550536238393494L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_CHECKLOAN;
	}
	
	/**
	 * 手机号
	 */
	String mobile;
	/**
	 * 小赢产品id
	 */
	String productId;

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

}
