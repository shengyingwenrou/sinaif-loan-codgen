<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;

import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.model.finance.enums.BaseTransCode;

import org.springframework.http.HttpStatus;

<#include "/java_imports.include" />
public enum ${className}TransCode implements BaseTransCode {


	/** 进件前-准入 **/
	TRANSCODE_USER_CHECKLOAN("/partner/outApi/user/checkLoan", "POST", "user_checkLoan", "判断用户是否可以申请贷款"),
	/** 进件前-注册 **/
	TRANSCODE_USER_REGISTERFLOW("/partner/outApi/user/registerFlow", "POST", "user_registerFlow", "用户流程注册"),
	/** 进件前-信息采集 **/
	TRANSCODE_USER_COLLECT("/partner/outApi/user/collect", "POST", "user_collect", "采集用户基本信息接口"),
	/** 进件前-活体图片上传 **/
	TRANSCODE_USER_FACEDETECTIMAGE("/partner/outApi/user/faceDetectImage", "POST", "user_faceDetectImage", "上传人脸识别图片检测"),
	/** 进件前-进件审批结果107后补件 **/
	TRANSCODE_USER_SUPPLEMENT("/partner/outApi/user/supplement", "POST", "user_supplement", "补件接口"),
	/** 进件前 返件绑定信用卡 **/
	TRANSCODE_USER_BINDCREDITCARD("/partner/outApi/user/bindCreditCard", "POST", "user_bindCreditCard", "信用卡绑卡接口"),
	/** 进件前 查询有效通话账单 **/
	TRANSCODE_CALLDETAIL_QUERY("/partner/outApi/callDetail/query", "POST", "callDetail_query", "通话详单-查询接口"),
	/** 进件前 无有效通话账单 上传通话账单 **/
	TRANSCODE_CALLDETAIL_PUSH("/partner/outApi/callDetail/push", "POST", "callDetail_push", "通话详单上传接口"),
	/** 正式进件 **/
	TRANSCODE_APPLY_APPLY("/partner/outApi/apply/apply", "POST", "apply_apply", "进件接口"),


	/** 提现页面初始化-银行卡信息初始化 **/
	TRANSCODE_USER_CARDLIST("/partner/outApi/user/cardList", "POST", "user_cardList", "获取已绑卡列表"),
	/** 提现页面预绑定储蓄卡 **/
	TRANSCODE_USER_CHECKDEBITCARD("/partner/outApi/user/checkDebitCard", "POST", "user_checkDebitCard", "储蓄卡绑定检查接口(会发短信校验码)"),
	/** 提现页面绑定储蓄卡 **/
	TRANSCODE_USER_BINDDEBITCARD("/partner/outApi/user/bindDebitCard", "POST", "user_bindDebitCard", "储蓄卡绑定"),
	/** 提现页 卡贷要款 **/
	TRANSCODE_LOAN_GETLOANURL("/partner/outApi/loan/getLoanUrl", "POST", "loan_getLoanUrl", "获取要款地址"),
	/** 提现页 要款前测算还款计划 **/
	TRANSCODE_APPLY_COMPUTEREPAYPLAN("/partner/outApi/apply/computeRepayPlan", "POST", "apply_computeRepayPlan", "要款前测算还款计划"),


	/** 补件页、绑定储蓄卡页、绑定信用卡页、提现 页合同查询 **/
	TRANSCODE_AGREEMENT_GETAGREEMENTLIST("/partner/outApi/agreement/getAgreementList", "POST", "agreement_getAgreementList", "合同查询"),
	/** 送件结果、补件结果、提现结果、账单同步 卡贷信息查询 **/
	TRANSCODE_APPLY_QUERY2("/partner/outApi/apply/query2", "POST", "apply_query2", "卡贷信息查询"),


	/** 提现结果状态变化(资方回调) **/
	TRANSCODE_CALLBACK("/callback/${className}n/orderStateChangeNotify", "POST", "callback", "回调接口"),



	/** 注释: 已经对接但是实际上未使用上 **/
	TRANSCODE_BASE_COMPUTE("/partner/outApi/base/compute", "POST", "base_compute", "贷款计算接口"),
	TRANSCODE_BASE_PRODUCTINFO("/partner/outApi/base/productInfo", "POST", "base_productInfo", "获取贷款产品的基本信息"),
	TRANSCODE_BASE_CITYINFO("/partner/outApi/base/cityInfo", "POST", "base_cityInfo", "获取准入城市、热门城市列表"),
	TRANSCODE_BASE_BANKLIST("/partner/outApi/base/bankList", "POST", "base_bankList", "获取银行列表"),
	TRANSCODE_USER_FACEDETECT("/partner/outApi/user/faceDetect", "POST", "user_faceDetect", "face++活体检测"),
	TRANSCODE_CALLDETAIL_LOGINQUERY("/partner/outApi/callDetail/loginQuery", "POST", "callDetail_loginQuery", "通话详单-登陆信息获取接口"),
	TRANSCODE_CALLDETAIL_LOGINPICCODE("/partner/outApi/callDetail/loginPicCode", "POST", "callDetail_loginPicCode", "通话详单-获取登陆图片验证码接口"),
	TRANSCODE_CALLDETAIL_LOGINDYNCODE("/partner/outApi/callDetail/loginDynCode", "POST", "callDetail_loginDynCode", "通话详单-获取登陆短信验证码接口"),
	TRANSCODE_CALLDETAIL_LOGIN("/partner/outApi/callDetail/login", "POST", "callDetail_login", "通话详单-登录接口"),
	TRANSCODE_CALLDETAIL_CALLPICCODE("/partner/outApi/callDetail/callPicCode", "POST", "callDetail_callPicCode", "获取详单的图片验证码接口"),
	TRANSCODE_CALLDETAIL_CALLDYNCODE("/partner/outApi/callDetail/callDynCode", "POST", "callDetail_callDynCode", "获取通话详单的短信验证码接口"),
	TRANSCODE_CALLDETAIL_COLLECT("/partner/outApi/callDetail/collect", "POST", "callDetail_collect", "通话详单获取接口"),
	;

	${className}TransCode(String uri, String method, String code, String desc) {
		this.uri = uri;
		this.method = method;
		this.code = code;
		this.desc = desc;

	}

	private String uri;

	private String code;

	private String method;

	private String desc;


	public String getUri() {
		return uri;
	}

	public String getCode() {
		return code;
	}

	public String getMethod() {
		return method;
	}

	public String getDesc() {
		return desc;
	}

	@Override
	public boolean ifBusinessSuccess(String code) {
		if (StringUtils.isBlank(code)) {
			return false;
		}
		if (String.valueOf(HttpStatus.OK.value()).equals(code)) {
			return true;
		}
		return false;
	}



}
