<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.api;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.sinaif.king.common.task.TaskQueueManager;
import com.sinaif.king.common.utils.HNUtil;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.finance.message.LogReqResultBean;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.api.base.LogDbTask;
import com.sinaif.king.finance.service.helper.CommonServiceHelper;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CodeStatusEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.data.EncryptData;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}BaseBankListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}BaseCityInfoReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCardListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}BaseReq;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}BaseBankListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}BaseCityInfoRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCardListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}CommonRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}RspHeader;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}ProductParamsMapHelper;
import com.sinaif.king.finance.${classNameLower}.utils.DataUtils;
import com.sinaif.king.finance.${classNameLower}.utils.OkHttpUtil;
import com.sinaif.king.model.datasync.yjyh.UserLoginLogBean;
import com.sinaif.king.service.data.UserResouceService;
import com.sinaif.king.service.message.LogRequestService;
import com.sinaif.king.service.product.finance.FinanceControlService;
import com.sinaif.mt.proxy.common.model.ApiResult;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;


<#include "/java_imports.include" />
@Service
@Scope("prototype")
public class ${className}RequestTask {

	private  static Logger logger = LoggerFactory.getLogger(${className}RequestTask.class);

	private Map<String, String> productParamsMap;
	@Autowired
	private LogRequestService logRequestService;
	@Autowired
	private CommonServiceHelper commonServiceHelper;
	@Autowired
	private UserResouceService userResouceService;
	@Autowired
	private FinanceControlService financeControlService;

	public ${className}CommonRsp invoke(${className}BaseReq req) throws FinanceException {
		String result = getHttpRequestData(req);
		${className}CommonRsp commonRsp = JSONObject.parseObject(result, ${className}CommonRsp.class);
		return commonRsp;
	}

	/***
	 * ????????????????????????
	 * @param req
	 * @param t
	 * @return
	 */
	public  <T> T  invoke(${className}BaseReq req, Class<T> t) throws FinanceException {

		// ??????????????????????????????IP??????
		if (StringUtils.isBlank(req.getClientIp())) {
			UserLoginLogBean userLoginLogBean = userResouceService
					.findLastOneUserLoginLog(req.getHeader().getTerminalid(), req.getHeader().getUserid());
			if (null == userLoginLogBean || StringUtils.isBlank(userLoginLogBean.getLoginip())) {
				String msg = "???${log_finance_name}???LoginIp??????";
				logger.info(msg);
			}
			req.setClientIp(userLoginLogBean.getLoginip());
		}

		String result = null;

		try {
			result = getHttpRequestData(req);
			${className}CommonRsp commonRsp = JSONObject.parseObject(result, ${className}CommonRsp.class);
			if (commonRsp.getErrCode() == null) {
				logger.error("${log_finance_name}????????????code??????");
				throw new ApiException(500, "??????????????????code??????");
			}
			T respObj = null;
			if (${className}CodeStatusEnum.SUCCESS.getCode() == commonRsp.getErrCode() && StringUtils.isNotEmpty(commonRsp.getData())) {
				if (req instanceof ${className}BaseBankListReq) {
					${className}BaseBankListRsp rep = new ${className}BaseBankListRsp();
					rep.setBankInfoArray(commonRsp.getData());
					respObj = (T)rep;
				} else if (req instanceof ${className}BaseCityInfoReq) {
					${className}BaseCityInfoRsp rep = new ${className}BaseCityInfoRsp();
					rep.setCityInfoArray(commonRsp.getData());
					respObj = (T)rep;
				}else if (req instanceof ${className}UserCardListReq) {
					JSONArray cardArray = JSONArray.parseArray(commonRsp.getData());
					if(cardArray.size()>0) {
						${className}UserCardListRsp rep = JSON.parseObject(cardArray.get(0).toString(), ${className}UserCardListRsp.class);
						respObj = (T)rep;
					}
				} else {
					respObj = JSONObject.parseObject(commonRsp.getData(), t);
				}
			}
			
			if(respObj == null) {
				respObj = t.newInstance();
			}
			
			${className}BaseRsp rspBody = (${className}BaseRsp) respObj;
			${className}RspHeader header = new ${className}RspHeader();
			header.setCode(commonRsp.getErrCode());
			header.setMsg(commonRsp.getErrStr());
			rspBody.setHeader(header);
			
			logger.info("????????????:{}", JSONObject.toJSONString(rspBody));
			return respObj;
		} catch (ApiException e) {
			throw e;
		} catch (Exception e) {
			logger.error("??????????????????????????????:" + result, e);
			throw new RuntimeException("???????????????????????????");
		}

	}

	/**
	 * ??????????????????????????????????????????
	 * @return String ?????????????????????
	 */
	protected String getHttpRequestData(${className}BaseReq req) {
        /** ???????????????????????? **/
        String serviceUrl = ${className}ProductParamsMapHelper.getServerUrl(productParamsMap);
        /** ???????????????????????? **/
        String partnerPrivateKey = ${className}ProductParamsMapHelper.getPrivateKey(productParamsMap);
        /** ??????????????? **/
        String ${classNameLower}PublicKey = ${className}ProductParamsMapHelper.getClientPublicKey(productParamsMap);
        /** md5???????????????????????? **/
        String md5Key = ${className}ProductParamsMapHelper.getMd5Key(productParamsMap);

		String ${classNameLower}PartenerFlag = ${className}ProductParamsMapHelper.getPartenerFlag(productParamsMap);
		/** md5???????????????????????? **/


        String requestContent = JSON.toJSONString(req, SerializerFeature.WriteNullStringAsEmpty);

        boolean isOK = false;
        ${className}TransCode transCode = req.getTransCode();
        String terminalid = req.getHeader().getTerminalid();
        String userid = req.getHeader().getUserid();

        EncryptData encryptData;
        String responseBody;
        try {
            encryptData = DataUtils.encrypt(${classNameLower}PartenerFlag, ${classNameLower}PublicKey, md5Key, requestContent);
        } catch (Exception e) {
            logger.error("${log_finance_name}?????????????????????", e);
            throw new ApiException(ApiErrorEnum.COMMON_DATA_ERROR.getCode(), "${log_finance_name}?????????????????????");
        }
        Map<String, String> params = new HashMap<>();
        params.put("key", encryptData.getKey());
        params.put("content", encryptData.getContent());
        params.put("timestamp", String.valueOf(encryptData.getTimestamp()));
        params.put("sign", encryptData.getSign());

        LogReqResultBean request = new LogReqResultBean();
        request.setBusinessid(req.getHeader().getUserid());
        request.setBusinesstype(req.getTransCode().getCode());
        request.setRequesttime(new Date());
        request.setCreatetime(new Date());
        request.setId(HNUtil.getId());

        request.setProductid(req.getHeader().getProductid());
        request.setRequeststatus(1);
        request.setTerminalid(req.getHeader().getTerminalid());
        request.setBaseTransCode(transCode);

		request.setRequestbody(requestContent);

        logger.info("??????id???{}???????????????{}?????????{}???,??????????????????\n{}", userid, transCode.getUri() + "-" + transCode
                .getDesc(), serviceUrl, com.sinaif.king.common.utils.StringUtils.subStr4Log(requestContent));

		if (financeControlService != null){
			serviceUrl = financeControlService.getServerUrl(req.getHeader().getProductid(),userid, productParamsMap);
		}

        final String finalUrl = serviceUrl + req.getTransCode().getUri() + "?partner=" + ${classNameLower}PartenerFlag;

		request.setRequestdesc("???" + transCode.getDesc() + "???" + finalUrl);
        try {

			if (null != commonServiceHelper && commonServiceHelper.ifUnifyPostSwitchOpen(terminalid, ProductEnum.${classNameUpper}.id)) {
				Map<String, String> headMap = new HashMap<>();
				headMap.put("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
                ApiResult<String> result = commonServiceHelper
                        .unifyPostParam(request, terminalid, ProductEnum.${classNameUpper}, req.getTransCode().getCode(), finalUrl, params,headMap,true);
                responseBody = result.getData();
                request.setResponsetime(new Date());
                logger.info("??????:{},{},??????????????????????????????", userid, finalUrl);
            } else {
            	// ???????????????????????????????????????
                responseBody = OkHttpUtil.post(finalUrl, params);
                logger.info("??????:{},{},?????????????????????????????????", userid, finalUrl);
                request.setResponsetime(new Date());
            }
            if(StringUtils.isEmpty(responseBody)) {
            	request.setRemark("??????????????????????????????");
                request.setResponseid(Constants.ERROR.toString());
                throw new ApiException(HttpStatus.SC_INTERNAL_SERVER_ERROR, "??????????????????????????????");
            }
            
            try {
            	EncryptData resEncryptData = JSON.parseObject(responseBody, EncryptData.class);
            	String decryptContent = DataUtils.decrypt(${classNameLower}PartenerFlag, partnerPrivateKey, md5Key, resEncryptData);
            	request.setResponsebody(decryptContent);
            	isOK = true;
            	return decryptContent;
            } catch (Exception e) {
                logger.error("${log_finance_name}??????????????????"+responseBody, e);
                throw new ApiException(ApiErrorEnum.COMMON_DATA_ERROR.getCode(), "${log_finance_name}??????????????????");
            }
           
        } catch (Exception e) {
            isOK = false;
            logger.error("????????????????????????" + e.getMessage(), e);
            throw new ApiException(HttpStatus.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        } finally {
            try {
                request.setStatus(isOK ? 1 : 0);
                request.setResponsestatus(isOK ? 1 : 0);
                if (logRequestService != null) {
                    TaskQueueManager.getIntance().addTask(new LogDbTask(request, logRequestService));
                }
            } catch (Exception e) {
                logger.error("????????????????????????", e);
            }
        }
    }





	public Map<String, String> getProductParamsMap() {
		return productParamsMap;
	}

	public void setProductParamsMap(Map<String, String> productParamsMap) {
		this.productParamsMap = productParamsMap;
	}


	
}
