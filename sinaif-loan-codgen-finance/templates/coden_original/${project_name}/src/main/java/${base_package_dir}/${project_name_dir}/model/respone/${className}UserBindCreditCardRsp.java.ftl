
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone;
import com.google.common.collect.Lists;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}BankInfo;

import java.io.Serializable;
import java.util.List;
<#include "/java_imports.include" />
public class ${className}UserBindCreditCardRsp extends ${className}BaseRsp implements Serializable{

	private static final long serialVersionUID = -766010329970539180L;
	
	String cardId;

	public String getCardId() {
		return cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}

}
