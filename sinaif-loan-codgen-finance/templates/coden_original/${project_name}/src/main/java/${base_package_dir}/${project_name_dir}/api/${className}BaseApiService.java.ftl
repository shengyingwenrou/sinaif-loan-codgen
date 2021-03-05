

<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.api;

import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.finance.api.base.AbstractFinanceApiService;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}CommonRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}RspHeader;
import com.sinaif.king.model.finance.request.FinanceApiRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;


<#include "/java_imports.include" />

public class ${className}BaseApiService extends AbstractFinanceApiService {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    protected Map<String, String> productParamsMap;

    @Autowired
    private ${className}RequestTask ${classNameLower}RequestTask;

    public void init(Map<String, String> productParamsMap) {
        ${classNameLower}RequestTask.setProductParamsMap(productParamsMap);
        this.productParamsMap = productParamsMap;
    }

    @Override
    public <E, T> T access(FinanceApiRequest<E> apiRequest, Class<T> t) {
       // ${className}CheckUserReq req = (${className}CheckUserReq) apiRequest.getData();
        return null;
    }

    protected <T> T invokeData(${className}BaseReq req, Class<T> t) {
        return ${classNameLower}RequestTask.invoke(req, t);
    }

    protected <T> T commonRspToCustomRsp(${className}CommonRsp commonRsp, Class<T> t) {
        try {
            T xx = t.newInstance();
            ${className}BaseRsp rspBody = (${className}BaseRsp) xx;
            ${className}RspHeader header = new ${className}RspHeader();
            header.setCode(commonRsp.getErrCode());
            header.setMsg(commonRsp.getErrStr());
            rspBody.setHeader(header);
            return xx;
        } catch (Exception e) {
            logger.error("返回数据对象转换异常", e);
            throw new ApiException(ApiErrorEnum.COMMON_SERVICE_ERROR);
        }
    }
}
