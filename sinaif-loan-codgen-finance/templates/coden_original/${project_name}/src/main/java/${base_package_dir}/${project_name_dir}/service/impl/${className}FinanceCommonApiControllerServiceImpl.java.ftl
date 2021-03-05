<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.sinaif.king.common.RemoteResult;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.common.FinanceCommonControllerEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.enums.finance.product.ProductFlag;
import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.service.base.BaseFinanceCommonApiControllerServiceImpl;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.model.finance.data.vo.UserBankCardVO;

<#include "/java_imports.include" />
@Service
@ProductFlag(ProductEnum.${classNameUpper})
public class ${className}FinanceCommonApiControllerServiceImpl extends BaseFinanceCommonApiControllerServiceImpl {
	private Logger logger = LoggerFactory.getLogger(${className}FinanceCommonApiControllerServiceImpl.class);
	@Autowired
	${className}BusinessServiceHelper ${className}BusinessServiceHelper;

	@Override
	public RemoteResult<String> router(String params, String requestType, String userid, String terminalid,
			String productid) {
		switch (FinanceCommonControllerEnum.getByCode(requestType)) {
		case ${classNameUpper}_BIND_CREDITCARD:
			try {
				${className}BusinessServiceHelper.bindCreditCard(params, userid, terminalid, productid);
				return new RemoteResult<>();
			} catch (FinanceException e) {
				return new RemoteResult<String>(ApiErrorEnum.COMMON_SYSTEM_ERROR.getCode(), e.getMessage());
			} catch (Exception e) {
				logger.error(LogTemplate.LOG_TEMPLATE, userid, e.getMessage(), e);
				return new RemoteResult<String>(ApiErrorEnum.COMMON_SYSTEM_ERROR.getCode(), "系统异常");
			}
		case ${classNameUpper}_GET_CREDITCARD:
			String orderid = JSON.parseObject(params).getString("orderid");
			UserBankCardVO card = ${className}BusinessServiceHelper.getCreditCard(orderid, userid, terminalid, productid);
			return new RemoteResult<>(JSON.toJSONString(card));

		default:
			logger.error("requestType[{}]请求接口路由没有找到", requestType);
			return new RemoteResult<String>(ApiErrorEnum.COMMON_PARAMS_ERROR.getCode(), "请求接口没有找到");
		}
	}
}
