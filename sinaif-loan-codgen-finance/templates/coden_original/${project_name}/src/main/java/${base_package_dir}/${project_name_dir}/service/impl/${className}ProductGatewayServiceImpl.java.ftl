<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import org.springframework.stereotype.Service;

import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.gateway.product.flow.impl.AbstractProductGatewayService;
import com.sinaif.king.model.finance.base.BaseParamBean;
import com.sinaif.king.model.finance.credit.CreditInfoBean;

<#include "/java_imports.include" />
@Service
public class ${className}ProductGatewayServiceImpl extends AbstractProductGatewayService {

    @Override
    public ProductEnum getServiceName() {
        return ProductEnum.${classNameUpper};
    }

	@Override
	public CreditInfoBean getCreditInfoRemote(BaseParamBean params) {
		// TODO Auto-generated method stub
		return null;
	}
}
