<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.api;

import com.sinaif.king.finance.api.IFinanceInLoanApiService;
import com.sinaif.king.model.finance.request.FinanceApiRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

<#include "/java_imports.include" />
@Service
@Scope("prototype")
public class ${className}FinanceInLoanApiServiceImpl extends ${className}BaseApiService implements IFinanceInLoanApiService {
	
	protected Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public <E, T> T withdrawApply(FinanceApiRequest<E> apiRequest, Class<T> t) {
		return null;
	}

	@Override
	public <E, T> T withdrawApplyConfirm(FinanceApiRequest<E> apiRequest, Class<T> t) {
		return null;
	}

	@Override
	public <E, T> T withdrawApplyResultQuery(FinanceApiRequest<E> apiRequest, Class<T> t) {
		return null;
	}
}
