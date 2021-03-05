
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request;
import org.hibernate.validator.constraints.NotBlank;

import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import com.alibaba.fastjson.annotation.JSONField;

import com.sinaif.king.finance.${classNameLower}.constant.Constants;
<#include "/java_imports.include" />
public class ${className}ApplyApplyReq extends ${className}BaseReq {


	private static final long serialVersionUID = 20712722304303525L;

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_APPLY_APPLY;
	}
	
	/**
	 * 流程id (小赢返回)
	 */
	@NotBlank(message="流程id不能为空")
	String flowId;
	
	/**
	 *申请到账金额；（打到用户银行卡金额） 
	 *单位为分
	 */
	long amount;
	
	/**
	 * 借款期限
	 */
	int periods;
	
	/**
	 * 借款用途
	 */
	int intention;
	
	/**
	 * 信用卡id
	 */
	@NotBlank(message="信用卡id不能为空")
	String creditCardId;
	
	/**
	 * 储蓄卡id
	 */
	@NotBlank(message="储蓄卡id不能为空")
	String debitCardId;

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}

	public long getAmount() {
		return amount;
	}

	public void setAmount(long amount) {
		this.amount = amount;
	}

	public int getPeriods() {
		return periods;
	}

	public void setPeriods(int periods) {
		this.periods = periods;
	}

	public int getIntention() {
		return intention;
	}

	public void setIntention(int intention) {
		this.intention = intention;
	}

	public String getCreditCardId() {
		return creditCardId;
	}

	public void setCreditCardId(String creditCardId) {
		this.creditCardId = creditCardId;
	}

	public String getDebitCardId() {
		return debitCardId;
	}

	public void setDebitCardId(String debitCardId) {
		this.debitCardId = debitCardId;
	}

}
