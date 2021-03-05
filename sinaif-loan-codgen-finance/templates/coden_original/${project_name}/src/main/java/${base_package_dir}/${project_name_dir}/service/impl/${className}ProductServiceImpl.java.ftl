<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import com.sinaif.king.enums.data.BankTypeEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.model.finance.credit.AfterLoanResultBean;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.service.credit.flow.impl.AbstractProductService;
import org.springframework.stereotype.Service;

<#include "/java_imports.include" />
@Service
public class ${className}ProductServiceImpl extends AbstractProductService {

    @Override
    public ProductEnum getServiceName() {
        return ProductEnum.${classNameUpper};
    }

	@Override
	protected AfterLoanResultBean getAfterLoanRemote(CreditApplyBean creditApplyBean) {
		return null;
	}
	
	/* 
	 * 返回放款银行卡类型
	 */
	@Override
	public BankTypeEnum getWithdrawBankCard() {
		return BankTypeEnum.CREDIT_CARD;
	}
}
