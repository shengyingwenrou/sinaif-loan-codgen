
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
public class ${className}CallDetailQueryRsp extends ${className}BaseRsp implements Serializable{

	private static final long serialVersionUID = -6054472081276729806L;

	/**
	 * 1: 存在有效的通话详单; 0: 不存在有效的通话详单
	 */
	int existValid;

	public int getExistValid() {
		return existValid;
	}

	public void setExistValid(int existValid) {
		this.existValid = existValid;
	} 
}
