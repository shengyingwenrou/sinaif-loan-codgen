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

public class ${className}UserFaceDetectImageReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = -6054472081276729806L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_FACEDETECTIMAGE;
	}
	
	String flowId;
	
	String imageUrl;
	
	/**
	 * 人脸识别方式 face++ ,faceplusplus,依图
	 */
	String source;
	
	String imageBase64;

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}


	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getImageBase64() {
		return imageBase64;
	}

	public void setImageBase64(String imageBase64) {
		this.imageBase64 = imageBase64;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	

}
