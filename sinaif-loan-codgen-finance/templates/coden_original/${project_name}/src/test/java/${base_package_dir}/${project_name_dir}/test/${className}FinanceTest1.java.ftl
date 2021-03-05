<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.test;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.junit.Test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.finance.util.ImageUtil;
import com.sinaif.king.finance.${classNameLower}.base.BaseTest;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}AddressInfo;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}AgreementGetAgreementListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyApplyReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyComputeRepayPlanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyQuery2Req;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailPushReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailQueryReq;
import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}Contact;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindCreditCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCardListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckLoanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCollectReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserFaceDetectImageReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserRegisterFlowReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserSupplementReq;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyComputeRepayPlanRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyQuery2Rsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserBindCreditCardRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCardListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserRegisterFlowRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;

<#include "/java_imports.include" />

public class ${className}FinanceTest1 extends BaseTest{
	
	final static String PRODUCT_ID = ProductEnum.${classNameUpper}.id;
	final static String IP = "111.1.109.51";
	static String flowId = "20190617192859674FLOW5070";//"20190614154305473FLOW8677";105:"20190611143910078FLOW1558";//"20190605163429501FLOW8375";
	
	final static String MOBILE = "18588233682";
	final static String NAME = "张空即";
	final static String GENDER = "男";
	final static String ID_CARD = "360102199003076475";//"440303198603074978";
	final static String ID_CARD_ADDRESS = "广东省深圳市罗湖区建设路";
	final static String LIVING_CITY_CODE = "440300"; 
	final static String LIVING_ADDRESS = "广东省深圳市罗湖区西康路658号";
	final static String NATION = "汉";
	final static String PROVINCE = "广东省";
	final static String CITY = "深圳市";
	final static String TERMINAL_ID = "2001";
	final static String USER_ID = "2019060511040000004";
	final static String ORDER_ID = "155772371978401631";
	final static String ID_CARDF_RONT = "C:/Users/dell/Desktop/idcard/107.jpg";
	final static String ID_CARD_REVERSE = "C:/Users/dell/Desktop/idcard/1071.jpg";
	final static String LIVING_BEST_PHOTO = "C:/Users/dell/Desktop/idcard/1042.jpg";
	
	final static String MOBILE_CARRIERS_DATA = "C:/Users/dell/Desktop/idcard/mobileCarriersData.json";
	final static String MOBILE_DETAIL_DATA = "C:/Users/dell/Desktop/idcard/mobileDetailData-g.json";
	final static Integer APPLY_AMOUNT = 10000;
	final static Integer LOANA_MOUNT = 7400;
	final static Integer LOAN_PERIOD = 12;
	
	final static String ID_FRONT_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/png/104";
	final static String ID_BACK_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/png/1041";
	final static String ID_HAND_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/jpg/1042";
	
	@Test
	public void userApplyAll() {
		this.userCheckLoanTest();
		this.userRegisterFlowTest();
		this.userBindCreditCardTest();
		this.callDetailPushTest();
		this.userCollectTest();
		this.userFaceDetectImageTest();
		this.userApplyApplyTest();
	}
	

	@Test
	public void userCheckLoanTest() {
		${className}UserCheckLoanReq req = new ${className}UserCheckLoanReq();
		req.getHeader().setUserid(USER_ID);
		req.setMobile(MOBILE);
		req.setProductId(FINANCE_PRODUCT_ID);
		req.setClientIp(IP);
		try {
			String resStr = request(MOCK_URL, req);
			System.out.println(resStr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

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
	

	@Test
	public void userCollectTest() {
		${className}UserCollectReq req = new ${className}UserCollectReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		int emergencyContactType = 1;
		String emergencyName = "张乾";
		String emergencyMobile = "18588233589";
		
		int frequentContactType = 4;
		String frequentName = "王小康";
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
	 * Description: 用户活体照片上传
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
	 * Description: 补件接口
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
	 * Description: 通话详单查询
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
	 * Description: 通话详单上传
	 * @Date  2019年6月5日 下午6:24:33
	 */
	@Test
	public void callDetailPushTest() {
		${className}CallDetailPushReq req = new ${className}CallDetailPushReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		String callDetail = getTrimJson(MOBILE_DETAIL_DATA);//运营商详单
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
	 * Description: 绑卡信息查询
	 * @Date  2019年6月5日 下午6:24:33
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
	
	static String creditCardId = "200011786";//"200011725";
	static String debitCardId = null;
	/**
	 * Description: 信用卡绑卡
	 * @Date  2019年6月5日 下午6:24:33
	 */
	@Test
	public void userBindCreditCardTest() {
		${className}UserBindCreditCardReq req = new ${className}UserBindCreditCardReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		String bankCode = "ICBC";
		String cardNo = "5240 9188 8888 8888";
		String cardMobile = MOBILE;
		req.setBankCode(bankCode);
		req.setCardMobile(cardMobile);
		req.setCardNo(cardNo);
		try {
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
	
	/**
	 * Description: 进件接口
	 * @Date  2019年6月5日 下午6:24:33
	 */
	@Test
	public void userApplyApplyTest() {
		${className}ApplyApplyReq req = new ${className}ApplyApplyReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);
		
		int intention = 9;//还信用卡
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
	
	@Test
	public void applyComputeRepayPlanTest() {
		${className}ApplyComputeRepayPlanReq req = new ${className}ApplyComputeRepayPlanReq();
		req.getHeader().setUserid(USER_ID);
		req.setClientIp(IP);
		req.setFlowId(flowId);

		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			JSONObject json = JSON.parseObject(resStr);
			${className}ApplyComputeRepayPlanRsp rsp = JSON.parseObject(json.getJSONObject("data").toJSONString(),${className}ApplyComputeRepayPlanRsp.class);
			System.out.println(rsp.getRepayPlans().size());
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		
	}
	
	@Test
	public void agreementGetAgreementListTest() {
		${className}AgreementGetAgreementListReq req = new ${className}AgreementGetAgreementListReq();
		req.getHeader().setUserid(USER_ID);
        req.setFlowId(flowId);
        req.setClientIp(IP);
        String[] array =new String[2];
        array[0]=${className}AgreementGetAgreementListReq.register;
//        array[0]=${className}AgreementGetAgreementListReq.bindDebitCard;
        array[1]=${className}AgreementGetAgreementListReq.apply;
        req.setSceneList(array);
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
//			JSONObject json = JSON.parseObject(resStr);
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		
	}
	
	@Test
	public void applyQuery2Test() {
		${className}ApplyQuery2Req req = new ${className}ApplyQuery2Req();
		req.getHeader().setUserid(USER_ID);
        req.setFlowId(flowId);
//        req.setClientIp(IP);
        req.setAdditionInfoList(new String[] {"repayPlanList"});
		try {
			String resStr = request(serverUrl_test, req);
			System.out.println(resStr);
			JSONObject json = JSON.parseObject(resStr);
			${className}ApplyQuery2Rsp rsp = JSON.parseObject(json.getJSONObject("data").toJSONString(),${className}ApplyQuery2Rsp.class);
			if(rsp != null && rsp.getRepayPlanList() != null) {
				List<${className}RepayPlan> list = JSON.parseArray(rsp.getRepayPlanList().toJSONString(), ${className}RepayPlan.class);
				System.out.println(list.size());
            }
			
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		
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
		String path = "C:/mine/test/logs/2019060511040000003_user_collect_encry_req.txt";
		String json = getTrimJson(path);
		EncryptData encryptData = JSON.parseObject(json, EncryptData.class);
		String decrypt = super.decrypt(PARTNER_FLAG, partnerPrivateKey, md5Key, encryptData);
		System.out.println(decrypt);
	}
}
