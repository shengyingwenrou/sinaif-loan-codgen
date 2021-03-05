
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.sinaif.king.common.ErrorCode;
import com.sinaif.king.common.db.RedisCache;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.data.BankTypeEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.finance.api.FinanceProcessorFactory;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserBindDebitCardRsp;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BizFinanceRefServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.gateway.data.bank.BankAccessService;
import com.sinaif.king.model.finance.data.vo.UserDataInfoVO;
import com.sinaif.king.model.finance.request.FinanceApiRequest;
import com.sinaif.king.service.data.DepositBankService;
import com.sinaif.king.service.data.UserResouceService;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;
import com.sinaif.king.service.product.ProductParamRelService;

<#include "/java_imports.include" />
@Service
public class ${className}BankAccessServiceImpl implements BankAccessService {

	private static final Logger logger = LoggerFactory.getLogger(${className}BankAccessServiceImpl.class);
	@Autowired
	private ${className}BusinessServiceHelper ${className}BusinessServiceHelper;
	@Autowired
	protected FinanceProcessorFactory financeProcessorFactory;
	@Autowired
	protected LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;
	@Autowired
	protected ProductParamRelService productParamRelService;

	@Autowired
	private UserResouceService userResouceService;

	@Autowired
	private ${className}BizFinanceRefServiceHelper ${className}BizFinanceRefServiceHelper;
	@Autowired
	private RedisCache redisCache;

	@Autowired
	private DepositBankService depositBankService;

	@Override
	public ProductEnum getServiceName() {
		return ProductEnum.${classNameUpper};
	}

	/**
	 * 绑定储蓄卡
	 * 
	 * @param vo 绑卡基本数据
	 * @return
	 */
	private void bindDebitCard(UserDataInfoVO vo) {

		String bankno = ""; // 银行卡号
		String verifySms = ""; // 短信验证码
		String userid = vo.getUserid(); // 用户ID
		String terminalid = vo.getTerminalid(); // 终端ID
		String orderid = vo.getOrderid(); // 订单ID
		String productid = vo.getProductids().get(0); // 产品ID
		String bankName = ""; // 银行名称

		for (Map.Entry<String, String> entry : vo.getItemMap().entrySet()) {
			if (entry.getKey().indexOf("bankno") != -1) {
				bankno = entry.getValue();
			} else if (entry.getKey().indexOf("banksend") != -1) {
				verifySms = entry.getValue();
			} else if (entry.getKey().indexOf("bankname") != -1) {
				bankName = entry.getValue();
			}
		}
		String msgInfo = String.format("用户编号【%s】订单号【%s】", vo.getUserid(), vo.getOrderid());
		logger.info("【${log_finance_name}】用户绑定储蓄卡开始了，" + msgInfo);
		String key = vo.getUserid() + bankno;
		Object object = redisCache.get(vo.getTerminalid() + "bankAccess", key);
		if (object != null) {
			logger.info("1分钟内不允许重复请求: {}", JSON.toJSONString(vo));
			throw new ApiException(ErrorCode.REQUEST_AGAIN, "1分钟内不允许多次请求");
		}
		redisCache.put(vo.getTerminalid() + "bankAccess", key, String.valueOf(System.currentTimeMillis()), 1,
				TimeUnit.MINUTES);

		String verifiedData = ${className}BizFinanceRefServiceHelper.getVerifiedData(vo.getUserid(), productid, orderid,
				terminalid);

		String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(vo.getUserid(), productid, orderid, terminalid);
		${className}UserBindDebitCardReq req = new ${className}UserBindDebitCardReq();
		${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper.buildReqHeader(vo.getTerminalid(), vo.getUserid());
		req.setHeader(${className}ReqHeader);
		req.setFlowId(flowId);
		req.setSmsCode(verifySms);
		req.setVerifiedData(verifiedData);

		${className}UserBindDebitCardRsp result;
		try {
			FinanceApiRequest<${className}UserBindDebitCardReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
			result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
					.commonRequest(apiReq, ${className}UserBindDebitCardRsp.class, ${className}TransCode.TRANSCODE_USER_BINDDEBITCARD);
			if (null != result && Constants.SUCCESS == result.getHeader().getCode() && StringUtils.isNotEmpty(result.getCardId())) {
				//从资方同步一下，调用公用方法保存
				${className}BusinessServiceHelper.syncDebitCard(orderid, userid, terminalid, productid);
				redisCache.remove(vo.getTerminalid() + "bankAccess", key);
				logger.info(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,"储蓄银行卡保存成功");
				return;
			}
			logger.info("终端【{}】产品【{}】用户【{}】绑定储蓄卡失败:{}", vo.getTerminalid(), vo.getProductids(), vo.getUserid(),
					result.getHeader().getMsg());
			throw new ApiException(ApiErrorEnum.BIND_BANK_CARD_FAILED);
		} catch (Exception e) {
			logger.error("终端【{}】产品【{}】用户【{}】绑定储蓄卡异常:{}", vo.getTerminalid(), vo.getProductids(), vo.getUserid(),
					e.getMessage(),e);
			throw new ApiException(ApiErrorEnum.FINANCE_BINDCARD_ERROR);
		} 
		
	}

	@Override
	public String bankAccess(Integer bankType, UserDataInfoVO vo) {


		if (BankTypeEnum.DEBIT_CARD == BankTypeEnum.getByCode(bankType)) {
			bindDebitCard(vo);
		}

		return null;
	}

}