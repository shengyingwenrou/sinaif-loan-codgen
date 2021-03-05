
<#include "/java_global_assign.include" />

package com.sinaif.king.finance.${classNameLower}.model.request;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import org.hibernate.validator.constraints.NotBlank;
import java.io.Serializable;

<#include "/java_imports.include" />
public class ${className}AgreementGetAgreementListReq extends ${className}BaseReq implements Serializable{

	private static final long serialVersionUID = 6045745930247535159L;

	/**
	 * 合同场景  注:具体使用中可以按照实际需要配置
	 * register：注册
	 * bindCreditCard：绑定信用卡
	 * bindDebitCard：绑定储蓄卡
	 * apply：申请
	 * loan：要款
	 */
	public static final String register="register";
	public static final String bindCreditCard="bindCreditCard";
	public static final String bindDebitCard="bindDebitCard";
	public static final String apply="apply";
	public static final String loan="loan"; //跳转到小赢⻚面要款的合作⽅不需要查询要款的合同

	@Override
	public ${className}TransCode getTransCode() {
		return ${className}TransCode.TRANSCODE_AGREEMENT_GETAGREEMENTLIST;
	}

	/** 流程ID NOT_NULL **/
	private String flowId;
	/** 合同场景数组 必须传入一个场景 **/
	private String[] sceneList;

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}

	public String[] getSceneList() {
		return sceneList;
	}

	public void setSceneList(String[] sceneList) {
		this.sceneList = sceneList;
	}
}
