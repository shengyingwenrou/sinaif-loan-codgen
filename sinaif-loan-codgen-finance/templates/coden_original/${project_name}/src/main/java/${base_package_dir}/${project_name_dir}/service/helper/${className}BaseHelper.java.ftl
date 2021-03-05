
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.helper;

import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.finance.api.ProductParamsMap;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

<#include "/java_imports.include" />
public class ${className}BaseHelper {

    private static Logger logger = LoggerFactory.getLogger(${className}BaseHelper.class);

    public ${className}ReqHeader buildReqHeader(String terminalid, String userid) {

        Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});

        ${className}ReqHeader header = new ${className}ReqHeader();
        header.setTerminalid(terminalid);
        header.setUserid(userid);
        header.setProductid(ProductEnum.${classNameUpper}.id);
        return header;
    }


}
