<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sinaif.king.enums.common.FinanceCommonParamEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.finance.util.ImageUtil;
import com.sinaif.king.finance.${classNameLower}.api.${className}RequestTask;
import com.sinaif.king.finance.${classNameLower}.base.BaseTest;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}AddressInfo;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyApplyReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyComputeRepayPlanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyQuery2Req;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailPushReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailQueryReq;
import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}Contact;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindCreditCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCardListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckLoanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCollectReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserFaceDetectImageReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserRegisterFlowReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserSupplementReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyComputeRepayPlanRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyQuery2Rsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserBindCreditCardRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserBindDebitCardRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCardListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCheckDebitCardRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserRegisterFlowRsp;

import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


<#include "/java_imports.include" />

public class ${className}FinanceTest2 extends BaseTest{
	
	/**
	 * 
	 * ??????????????????
	 *  
	 */
	final static String mock_adress = "2001";
	final static String terminalid = "2001";
	final static String FINANCE_PRODUCT_ID = "10001";
	final static String PRODUCT_ID = ProductEnum.${classNameUpper}.id;

	final static String IP = "111.1.109.51";
	static String flowId = "20190613154446280FLOW6888";//"20190611143910078FLOW1558";

	final static String ID_CARD = "350122198412104157";//"440303198603074978";
	final static String MOBILE = "13960865378";
	final static String NAME = "?????????";
	final static String USER_ID = "149682417969758984";

	final static String ID_CARDF_RONT = "E:/product_develop_document/????????????md/????????????/2019-06-03_????????????_????????????/????????????/front.png";
	final static String ID_CARD_REVERSE = "E:/product_develop_document/????????????md/????????????/2019-06-03_????????????_????????????/????????????/back.png";
	final static String LIVING_BEST_PHOTO = "E:/product_develop_document/????????????md/????????????/2019-06-03_????????????_????????????/????????????/1042.jpg";


	final static String GENDER = "???";
	final static String ID_CARD_ADDRESS = "????????????????????????????????????";
	final static String LIVING_CITY_CODE = "440300";
	final static String LIVING_ADDRESS = "????????????????????????????????????658???";
	final static String NATION = "???";
	final static String PROVINCE = "?????????";
	final static String CITY = "?????????";
	final static String TERMINAL_ID = "2001";

	final static String ORDER_ID = "155772371978401630";


	final static String MOBILE_CARRIERS_DATA = "C:/Users/dell/Desktop/idcard/mobileCarriersData.json";


	final static String MOBILE_DETAIL_DATA = "E:/product_develop_document/????????????md/????????????/2019-06-03_????????????_????????????/????????????/mobileDetailData-g.json";

	final static Integer APPLY_AMOUNT = 10000;
	final static Integer LOANA_MOUNT = 7400;
	final static Integer LOAN_PERIOD = 12;
	
	final static String ID_FRONT_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/png/104";
	final static String ID_BACK_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/png/1041";
	final static String ID_HAND_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/jpg/1042";

	${className}RequestTask task = new ${className}RequestTask();
	${className}ReqHeader header = new ${className}ReqHeader();

	Map<String, String> financeParamMap = new HashMap<>();

	@Before
	public void testBefore() {

		/**
		 ??????????????????????????????????????????https://ldp.xiaoying.com
		 ??????????????????????????????????????????http://bjtestldp.xiaoying.com
		 **/
		// serverUrl
		financeParamMap.put(FinanceCommonParamEnum.PCODE_SERVERURL.getCode(), serverUrl_test);
		// ????????????
		financeParamMap.put(FinanceCommonParamEnum.PCODE_PRIVATE_KEY.getCode(), partnerPrivateKey);
		// ${log_finance_name}??????
		financeParamMap.put(FinanceCommonParamEnum.PCODE_PUBLIC_KEY.getCode(), ${className}PublicKey);
		// md5????????????????????????
		financeParamMap.put(FinanceCommonParamEnum.PCODE_MD5KEY.getCode(), md5Key);

		financeParamMap.put(FinanceCommonParamEnum.${classNameUpper}_PARTENER_FLAG.getCode(), PARTNER_FLAG);

		task.setProductParamsMap(financeParamMap);

		header.setProductid(FINANCE_PRODUCT_ID);
		header.setTerminalid(terminalid);
		header.setUserid(USER_ID);
		//      ProductParamsMap.setMap(ProductEnum.${classNameUpper}, financeParamMap);
		System.out.println("=========initFinish===========");
	}

	/**
	 * Description: ??????????????????????????????
	 * @Date  2019???6???5??? ??????10:47:40
	 */
	@Test
	public void userCheckLoanTest() {
		${className}UserCheckLoanReq req = new ${className}UserCheckLoanReq();
		req.getHeader().setUserid(USER_ID);
		req.setMobile(MOBILE);
		req.setProductId(FINANCE_PRODUCT_ID);
		req.setClientIp(IP);
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}



	@Test
	public void userCheckLoanTest1() {
		${className}UserCheckLoanReq req = new ${className}UserCheckLoanReq();
		req.getHeader().setUserid("156082584487059335");
		req.getHeader().setProductid("2005201");
		req.setMobile("13048873900");
		req.setProductId(FINANCE_PRODUCT_ID);
		req.setClientIp("192.168.22.74");
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * Description: ????????????????????????
	 */
	@Test
	public void userRegisterFlowTest() {
		${className}UserRegisterFlowReq req = new ${className}UserRegisterFlowReq();
		req.getHeader().setUserid(USER_ID);
		req.setMobile(MOBILE);
		req.setProductId(FINANCE_PRODUCT_ID);
		req.setClientIp(IP);
		
		req.setName(NAME);
		req.setIdentity(ID_CARD);
		String idFrontBase64 = getImgBase64(ID_CARDF_RONT);
		String idBackBase64 = getImgBase64(ID_CARD_REVERSE);
		req.setIdFrontBase64(idFrontBase64);
		req.setIdBackBase64(idBackBase64);
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			JSONObject json = JSON.parseObject(resStr);
			if(json.getInteger("errCode") == 0) {
				flowId = JSON.parseObject(json.getJSONObject("data").toJSONString(), ${className}UserRegisterFlowRsp.class).getFlowId();
			}
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		
	}
	
	/**
	 * Description: ??????????????????
	 */
	@Test
	public void userCollectTest() {
		${className}UserCollectReq req = new ${className}UserCollectReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		int emergencyContactType = 1;
		String emergencyName = "??????";
		String emergencyMobile = "18588233589";
		
		int frequentContactType = 4;
		String frequentName = "?????????";
		String frequentMobile = "18588233885";
		
		${className}AddressInfo addressInfo = new ${className}AddressInfo(LIVING_CITY_CODE, LIVING_ADDRESS);
		${className}Contact emergencyContact = new ${className}Contact(emergencyContactType, emergencyName, emergencyMobile);
		${className}Contact frequentContact = new ${className}Contact(frequentContactType, frequentName, frequentMobile);
		req.setAddressInfo(addressInfo);
		req.setEmergencyContact(emergencyContact);
		req.setFrequentContact(frequentContact);
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
//			JSONObject json = JSON.parseObject(resStr);
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		
	}
	/**
	 * Description: ????????????????????????
	 */
	@Test
	public void userFaceDetectImageTest() {
		${className}UserFaceDetectImageReq req = new ${className}UserFaceDetectImageReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		String source = "faceplusplus";
//		req.setImageUrl(ID_HAND_URL);
		req.setSource(source);
		req.setImageBase64(getImgBase64(LIVING_BEST_PHOTO));
		
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	}
	/**
	 * Description: ????????????
	 */
	@Test
	public void userSupplementTest() {
		${className}UserSupplementReq req = new ${className}UserSupplementReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);

		String idHandBase64 = getImgBase64(LIVING_BEST_PHOTO);
		req.setIdHandBase64(idHandBase64);
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
//			JSONObject json = JSON.parseObject(resStr);
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		
	}
	/**
	 * Description: ??????????????????
	 */
	@Test
	public void callDetailQueryTest() {
		${className}CallDetailQueryReq req = new ${className}CallDetailQueryReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	}
	
	/**
	 * Description: ??????????????????
	 */
	@Test
	public void callDetailPushTest() {
		${className}CallDetailPushReq req = new ${className}CallDetailPushReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		String callDetail = getTrimJson(MOBILE_DETAIL_DATA);//???????????????
		JSONObject json = JSON.parseObject(callDetail);
		JSONObject members = json.getJSONObject("data").getJSONObject("report").getJSONObject("members");
		req.setCallDetail(members.toString());
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	}
	
	/**
	 * Description: ??????????????????
	 * @Date  2019???6???5??? ??????6:24:33
	 */
	@Test
	public void userCardListTest() {
		${className}UserCardListReq req = new ${className}UserCardListReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);

		
		req.setCardType(${className}CardTypeEnum.CREDIT_CARD.getCardType());
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			JSONObject json = JSON.parseObject(resStr);
			if(json.getInteger("errCode") == 0) {
				List<${className}UserCardListRsp> rsp = JSON.parseArray(json.getJSONArray("data").toJSONString(), ${className}UserCardListRsp.class);
				System.out.println(rsp.get(0).getCardNo());
			}
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	}
	
	static String creditCardId = "200011866";//"200011725";
	static String debitCardId = null;
	/**
	 * Description: ???????????????
	 * @Date  2019???6???5??? ??????6:24:33
	 */
	@Test
	public void userBindCreditCardTest() {
		${className}UserBindCreditCardReq req = new ${className}UserBindCreditCardReq();
		req.setHeader(header);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		String bankCode = "ICBC";
		String cardNo = "5240918888888888";
		String cardMobile = MOBILE;
		req.setBankCode(bankCode);
		req.setCardMobile(cardMobile);
		req.setCardNo(cardNo);
		try {
			// {"errCode":0,"errStr":"ok","data":{"cardId":"200011866"}}
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			JSONObject json = JSON.parseObject(resStr);
			if(json.getInteger("errCode") == 0) {
				${className}UserBindCreditCardRsp rsp = JSON.parseObject(json.getJSONObject("data").toJSONString(), ${className}UserBindCreditCardRsp.class);
				creditCardId = rsp.getCardId();
				System.out.println(creditCardId);
			}
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	}


	final static String cardNumber = "6228451168073948879";//????????????
	final static String bankCode="ABC";
	/**
	 * ???????????????????????????  status: pass
	 * **/
	@Test
	public void test_user_checkDebitCard() {
		${className}UserCheckDebitCardReq req = new ${className}UserCheckDebitCardReq();
		req.setHeader(header);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		req.setBankCode(bankCode);
		req.setCardMobile(MOBILE);
		req.setCardNo(cardNumber);

		// {"errCode":0,"errStr":"ok","data":{"verifiedData":"{\"orderId\":\"170575638717595748\"}"}}
		${className}UserCheckDebitCardRsp ${className}UserCheckDebitCardRsp = task.invoke(req, ${className}UserCheckDebitCardRsp.class);
		System.out.println("HHHH_test_user_checkDebitCard:"+ JSON.toJSONString(${className}UserCheckDebitCardRsp));
	}


	/** ????????????????????????????????? **/
	String smsCode = "123456";
	/** ???????????????????????? ??????????????????????????? ??????????????????????????????  **/
	String verifiedData="{\"orderId\":\"170575638717595748\"}";
	/**
	 * ???????????????  status: pass
	 * **/
	@Test
	public void test_user_bindDebitCard() {
		//  test_user_checkDebitCard();
		${className}UserBindDebitCardReq req = new ${className}UserBindDebitCardReq();
		${className}ReqHeader header = new ${className}ReqHeader();
		header.setUserid(USER_ID);
		req.setHeader(header);
		req.setFlowId(flowId);
		req.setClientIp(IP);
		req.setSmsCode(smsCode);
		req.setVerifiedData(verifiedData);
		${className}UserBindDebitCardRsp ${className}UserBindDebitCardRsp = task.invoke(req, ${className}UserBindDebitCardRsp.class);
		System.out.println("HHHH_test_user_bindDebitCard:"+JSON.toJSONString(${className}UserBindDebitCardRsp));
	}
	
	/**
	 * Description: ????????????
	 * @Date  2019???6???5??? ??????6:24:33
	 */
	@Test
	public void userApplyApplyTest() {
		${className}ApplyApplyReq req = new ${className}ApplyApplyReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		int intention = 9;//????????????
		String deviceId = "C3A41D3D-FF28-4053-9EC3-722D419042D9";
		String osType = "android";
		req.setAmount(APPLY_AMOUNT * 100);
		req.setCreditCardId(creditCardId);
		req.setDebitCardId(debitCardId);
		req.setIntention(intention);
		req.setPeriods(LOAN_PERIOD);
		req.setDeviceId(deviceId);
		req.setOsType(osType);
		//req.setOsVersion(osVersion);
		//req.setSoftVersion(softVersion);
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			JSONObject json = JSON.parseObject(resStr);
			if(json.getInteger("errCode") == 0) {
			}
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	}

	/**
	 * ?????????????????????????????????
	 * **/
	@Test
	public void test_apply_computeRepayPlan() {
		${className}ApplyComputeRepayPlanReq req = new ${className}ApplyComputeRepayPlanReq();
		req.setHeader(header);
		req.setFlowId(flowId_register);
		${className}ApplyComputeRepayPlanRsp rsp = task.invoke(req, ${className}ApplyComputeRepayPlanRsp.class);
		System.out.println("HHHH_test_apply_computeRepayPlan:"+JSON.toJSONString(rsp));
	}


	/**
	 * ??????????????????  status: ???????????????????????????
	 * **/

	final static String flowId_register = "20190613154446280FLOW6888";

	@Test
	public void test_apply_query2() {
		${className}ApplyQuery2Req req = new ${className}ApplyQuery2Req();
		req.setHeader(header);
		req.setFlowId(flowId_register);
		req.setClientIp(IP);
		req.setAdditionInfoList(null);
		${className}ApplyQuery2Rsp ${className}ApplyQuery2Rsp = task.invoke(req, ${className}ApplyQuery2Rsp.class);
		System.out.println("HHHH_test_apply_query2:"+JSON.toJSONString(${className}ApplyQuery2Rsp));
		System.out.println("HHHH_test_apply_query21:"+JSON.toJSONString(${className}ApplyQuery2Rsp.getRepayPlans()));
	}



	public static String getTrimJson(String url) {
		File file = new File(url);
		try {
			InputStream is = new FileInputStream(file);
			byte[] bytes = new byte[1024];
			int len = 0;
			ByteArrayOutputStream ois = new ByteArrayOutputStream();
			while((len = is.read(bytes))!=-1) {
				ois.write(bytes, 0, len);
			}
			is.close();
			String line = new String(ois.toByteArray(),"utf-8");
			return (line.replaceAll("\r|\n", ""));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public static String getImgBase64(String url) {
		File ifFile = new File(url);	
		String ifbase64 = ImageUtil.encodeImgageToBase64(ifFile);
		ifbase64 = ifbase64.replaceAll("\r|\n", "");
		return ifbase64;
	}
	
	@Test
	public void testDecrypt() {
		String path = "C:/mine/test/logs/2019060511040000003_user_checkLoan_encry_req_5.txt";
		String json = getTrimJson(path);
		EncryptData encryptData = JSON.parseObject(json, EncryptData.class);
		String decrypt = super.decrypt(PARTNER_FLAG, partnerPrivateKey, md5Key, encryptData);
		System.out.println(decrypt);
	}
}
