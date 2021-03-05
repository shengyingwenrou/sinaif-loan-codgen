
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />

public class ${className}UserCardListReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = -6054472081276729801L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_CARDLIST;
	}
	
	public ${className}UserCardListReq() {}
	
	public ${className}UserCardListReq(String flowId, ${className}CardTypeEnum cardTypeEnum) {
		this.flowId = flowId;
		this.cardType = cardTypeEnum.getCardType();
	}
	
	/**
	 * 流程id (小赢返回)
	 */
	@NotBlank(message="流程id不能为空")
	String flowId;

	/**
	 * 卡类型 1:信用卡 2:储蓄卡
	 */
	int cardType;

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}

	public int getCardType() {
		return cardType;
	}

	public void setCardType(int cardType) {
		this.cardType = cardType;
	}
}
