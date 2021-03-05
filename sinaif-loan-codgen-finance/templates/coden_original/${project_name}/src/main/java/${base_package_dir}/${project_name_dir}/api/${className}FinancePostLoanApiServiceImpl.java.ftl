<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.api;

import com.sinaif.king.finance.api.IFinancePostLoanApiService;
import com.sinaif.king.model.finance.request.FinanceApiRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

<#include "/java_imports.include" />
@Service
@Scope("prototype")
public class ${className}FinancePostLoanApiServiceImpl extends ${className}BaseApiService implements IFinancePostLoanApiService {

	protected Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public <E, T> T getLoanBill(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T loanPlanQuery(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T repaymentApply(FinanceApiRequest<E> apiRequest, Class<T> t) {
       return null;
    }

    @Override
    public <E, T> T repaymentApplyConfirm(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T repaymentApplyResultQuery(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T repaymentHistoryQuery(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T billDownload(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }
}
