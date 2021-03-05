<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import org.springframework.stereotype.Service;

import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.gateway.credit.flow.item.impl.AbstractCreditItemService;

<#include "/java_imports.include" />
@Service
public class ${className}CreditItemServiceImpl extends AbstractCreditItemService {
    @Override
    public ProductEnum getServiceName() {
        return ProductEnum.${classNameUpper};
    }
}
