<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import java.io.Serializable;
import org.hibernate.validator.constraints.NotBlank;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}UserBindCreditCardReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = -8938538169037931042L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_USER_BINDCREDITCARD;
	}
	/**
	 * 流程id (小赢返回)
	 */
	@NotBlank(message="流程id不能为空")
	String flowId;
	
	/**
	 * 卡号
	 */
	@NotBlank(message="银行卡号不能为空")
	String cardNo;
	/**
	 * 银行代码
	 */
	@NotBlank(message="银行代码不能为空")
	String bankCode;
	/**
	 * 银行预留手机号 如果不传，默认读取flowId注册手机号
	 */
	String cardMobile;

	public String getFlowId() {
		return flowId;
	}
	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	public String getCardMobile() {
		return cardMobile;
	}
	public void setCardMobile(String cardMobile) {
		this.cardMobile = cardMobile;
	}
}
