<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.api;

import com.sinaif.king.finance.api.IFinancePreLoanApiService;
import com.sinaif.king.model.finance.request.FinanceApiRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

<#include "/java_imports.include" />
@Service
@Scope("prototype")
public class ${className}FinancePreLoanApiServiceImpl extends ${className}BaseApiService implements IFinancePreLoanApiService {
	
	protected Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public <E, T> T loanValidation(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T uploadLoanFile(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T registerLoanInfo(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T loanApply(FinanceApiRequest<E> apiRequest, Class<T> t) {
       return null;
    }

    @Override
    public <E, T> T queryApplyProgress(FinanceApiRequest<E> apiRequest, Class<T> t) {

        return null;
    }

    @Override
    public <E, T> T patchApply(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }
}
