<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;

<#include "/java_imports.include" />

public class ${className}UserFaceDetectReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = -6054472081276729806L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_FACEDETECT;
	}
	

}
