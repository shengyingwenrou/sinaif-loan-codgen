<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.api;

import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.finance.api.*;
import com.sinaif.king.finance.service.IFinanceBillService;
import com.sinaif.king.finance.service.IFinanceBusinessService;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.impl.${className}BusinessServiceImpl;
import com.sinaif.king.service.product.finance.FinanceParamConfService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

<#include "/java_imports.include" />
public class ${className}FinanceProcessor implements IFinanceProcessor {

    @Autowired
    private ${className}FinancePreLoanApiServiceImpl preLoanApiService;

    @Autowired
    private ${className}FinanceInLoanApiServiceImpl inLoanApiService;

    @Autowired
    private ${className}FinancePostLoanApiServiceImpl postLoanApiService;

    @Autowired
    private ${className}FinanceCommonApiServiceImpl commonApiService;

    @Autowired
    private ${className}BusinessServiceImpl service;

    @Autowired
    private ${className}BusinessServiceHelper serviceHelper;

    @Autowired
    private FinanceParamConfService financeParamConfService;

    private ProductEnum productEnum = ProductEnum.${classNameUpper};

    public ${className}FinanceProcessor(ProductEnum productEnum) {
        this.setProductType(productEnum);
    }

    /**
     * 根据产品ID初始化资方公共参数
     */
    private void initProductParams() {
    	// 查询产品关联的资方API请求公共参数
        Map<String, String> productParamsMap = financeParamConfService.initRedisApiProductParamsMap(productEnum.id);
        preLoanApiService.init(productParamsMap);
        inLoanApiService.init(productParamsMap);
        postLoanApiService.init(productParamsMap);
        commonApiService.init(productParamsMap);
        
    }

    @Override
    public IFinancePreLoanApiService getPreLoanApiService() {
    	initProductParams();
        return preLoanApiService;
    }

    @Override
    public IFinanceInLoanApiService getInLoanApiService() {
    	initProductParams();
        return inLoanApiService;
    }

    @Override
    public IFinancePostLoanApiService getPostLoanApiService() {
    	initProductParams();
        return postLoanApiService;
    }

    @Override
    public IFinanceCommonApiService getCommonApiService() {
    	initProductParams();
        return commonApiService;
    }

    @Override
    public IFinanceBusinessService getService() {
        return service;
    }

    @Override
    public IFinanceBillService getBillService() {
        return null;
    }

    @Override
    public ProductEnum getProductType() {
        return productEnum;
    }

    @Override
    public void setProductType(ProductEnum productEnum) {
        this.productEnum = productEnum;
    }
}
