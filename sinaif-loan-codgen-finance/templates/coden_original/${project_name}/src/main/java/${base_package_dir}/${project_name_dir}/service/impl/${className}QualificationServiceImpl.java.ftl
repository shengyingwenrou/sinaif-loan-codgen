<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.gateway.access.item.QualificationService;
import com.sinaif.king.gateway.access.item.impl.AbstractQualificationService;
import com.sinaif.king.model.finance.access.AccessVO;
import com.sinaif.king.model.finance.access.ProductUserAccessBean;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

<#include "/java_imports.include" />
@Service
public class ${className}QualificationServiceImpl extends AbstractQualificationService implements QualificationService {

    private static Logger logger = LoggerFactory.getLogger(${className}QualificationServiceImpl.class);

    @Autowired
    private ${className}BusinessServiceHelper businessServiceHelper;



    @Override
    public ProductEnum getServiceName() {
        return ProductEnum.${classNameUpper};
    }

    @Override
    public Boolean riskIntercept(AccessVO vo) {
        return null;
    }

    @Override
    public ProductUserAccessBean qualificationCheckItem(AccessVO vo) {

        return businessServiceHelper.buildProductUserAccessBean(vo,getServiceName());
    }
}