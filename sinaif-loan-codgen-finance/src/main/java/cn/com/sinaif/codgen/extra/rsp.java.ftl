
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
public class ${className}UserCheckLoanRsp extends ${className}BaseRsp implements Serializable{

	private static final long serialVersionUID = -1771060528545516344L;
	
	/**
	 * 是否可以申请 1: 可以申请; 0: 不可以申请
	 */
	Integer checkLoan;

	public Integer getCheckLoan() {
		return checkLoan;
	}

	public void setCheckLoan(Integer checkLoan) {
		this.checkLoan = checkLoan;
	}
	

}
