<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.test;

import com.google.common.base.Charsets;

import com.alibaba.fastjson.JSON;
import com.sinaif.king.common.utils.HNUtil;
import com.sinaif.king.enums.common.FinanceCommonParamEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.finance.${classNameLower}.api.${className}RequestTask;
import com.sinaif.king.finance.${classNameLower}.base.BaseTest;
import com.sinaif.king.finance.${classNameLower}.base.${className}CallbackVo;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CardTypeEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}InfoTypeEnum;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}AgreementGetAgreementListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyComputeRepayPlanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyQuery2Req;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}BaseBankListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}BaseCityInfoReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}BaseProductInfoReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}LoanGetLoanUrlReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}AgreementGetAgreementListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyComputeRepayPlanRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyQuery2Rsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}BaseBankListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}BaseCityInfoRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}LoanGetLoanUrlRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ProductInfoQueryRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserBindDebitCardRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCheckDebitCardRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}Agreement;
import com.sinaif.king.finance.${classNameLower}.utils.Md5Util;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


<#include "/java_imports.include" />

@RunWith(SpringJUnit4ClassRunner.class)
public class ${className}FinanceTest extends BaseTest {


    String terminalid = "2001";
    final static String IP = "111.1.109.51";

    String userid = "155486527497485888";

    String phoneNumber = "13430430357";

    String cnid = "420101198806279589";

    String name = "公泽祥";

    String callbackUrl = "http://king-finance-callback-web.king-test.svc.cluster.local:9090/callback/wold/redirectHandle";

    String orderNo = "155503946405212049";

    String type = "fund";

    final static String flowId = "20190605163429501FLOW8375";

    final static String flowId_sucess = "20190611143910078FLOW1558";

    /** 要款成功后的我方页面的url **/
     String redirectUrl = "http://www.baidu.com";

    /** 储蓄卡绑定时短信验证码 **/
     String smsCode = "123456";
    /** 储蓄卡绑定时通过 储蓄卡绑定检查接口 预先拿到的验证字符串  **/
     String verifiedData="{\"orderId\":\"170489038219051122\"}";

    final static String PRODUCT_ID = ProductEnum.${classNameUpper}.id;

    final static String MOBILE = "18588233681";
    final static String NAME = "张锋";
    final static String GENDER = "男";
    final static String ID_CARD = "220102197503078557";
    final static String ID_CARD_ADDRESS = "吉林省长春市难关区拒件路8号";
    final static String LIVING_CITY_CODE = "350100";
    final static String LIVING_ADDRESS = "福建省福州市马尾区西康路658号";
    final static String NATION = "汉";
    final static String PROVINCE = "吉林省";
    final static String CITY = "长春市";
    final static String TERMINAL_ID = "2001";
    final static String USER_ID = "2019060511040000002";
    final static String ORDER_ID = "155772371978401629";
    final static String ID_CARDF_RONT = "C:/Users/dell/Desktop/idcard/104.png";
    final static String ID_CARD_REVERSE = "C:/Users/dell/Desktop/idcard/1041.png";
    final static String LIVING_BEST_PHOTO = "C:/Users/dell/Desktop/idcard/1042.jpg";

    final static String MOBILE_CARRIERS_DATA = "C:/Users/dell/Desktop/idcard/mobileCarriersData.json";
    final static String MOBILE_DETAIL_DATA = "C:/Users/dell/Desktop/idcard/mobileDetailData.json";
    final static Integer APPLY_AMOUNT = 10000;
    final static Integer LOANA_MOUNT = 7400;
    final static Integer LOAN_PERIOD = 12;

    final static String cardNumber = "6228 4511 6807 3948 879";//农业银行
    final static String bankCode="ABC";

    final static String ID_FRONT_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/png/104";
    final static String ID_BACK_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/png/1041";
    final static String ID_HAND_URL = "http://k8s-imgs-dev.sinaif.com:8444/callback/image/jpg/1042";

    Map<String, String> financeParamMap = new HashMap<>();

    XyfqRequestTask task = new XyfqRequestTask();

    XyfqReqHeader header = new XyfqReqHeader();


    @Test
    public void getTestId(){
        System.out.println("id:");
        for (int i=10 ;i<100;i++){
            System.out.println(HNUtil.getId()+" ");
        }
    }


    @Test
    public void genDecryptContent() {
        String flowId = "20185627159859675HLOS5071";
        ${className}CallbackVo vo = new ${className}CallbackVo(flowId, 111);
        String content = JSON.toJSONString(vo);
        EncryptData encryptData = encrypt(PARTNER_FLAG, partnerPublicKey, md5Key, content);
        Map<String, String> params = new HashMap<>();
        params.put("key", encryptData.getKey());
        params.put("content", encryptData.getContent());
        params.put("timestamp", String.valueOf(encryptData.getTimestamp()));
        params.put("sign", encryptData.getSign());
        String signContent = PARTNER_FLAG + content + encryptData.getKey() + String.valueOf(encryptData.getTimestamp()) + md5Key;
        Md5Util.md5(signContent, Charsets.UTF_8);
        System.out.println(com.alibaba.fastjson.JSON.toJSONString(params));
        System.out.println("HHHHHHHHHHHHHH START");
        System.out.println("sign="+encryptData.getSign());
        System.out.println("key="+encryptData.getKey());
        System.out.println("content="+encryptData.getContent());
        System.out.println("timestamp="+encryptData.getTimestamp());
        System.out.println("HHHHHHHHHHHHHH END");
    }



    String pkey="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDC3TMrNpRMYx9JpID04eBf0vj8fHxeAex6ka4Pv3gyCGvRJ3N/SOmrE/gxrOxxjiaH897g/KrCSzhBvAyCcGuXHVkh+fzhbbevZn+/VudYZ8WniTDVLjmQsdeCQT7xYSE9I0vFnCOnZO8Z/fbumsluh5yeNq5DqSrL0NoEiJ6oSQIDAQAB";
    @Test
    public void genDecryptContent1() {
        String flowId = "20190617192859674FLOW5070";
        XyfqCallbackVo status111 = new XyfqCallbackVo(flowId,111);
        String content = JSON.toJSONString(status111);
        EncryptData encryptData = encrypt(PARTNER_FLAG, pkey, md5Key, content);
        Map<String, String> params = new HashMap<>();
        params.put("key", encryptData.getKey());
        params.put("content", encryptData.getContent());
        params.put("timestamp", String.valueOf(encryptData.getTimestamp()));
        params.put("sign", encryptData.getSign());
        System.out.println(com.alibaba.fastjson.JSON.toJSONString(params));
        System.out.println("HHHHHHHHHHHHHH START");
        System.out.println("sign="+encryptData.getSign());
        System.out.println("key="+encryptData.getKey());
        System.out.println("content="+encryptData.getContent());
        System.out.println("timestamp="+encryptData.getTimestamp());
        System.out.println("HHHHHHHHHHHHHH END");
        //System.out.println("签名密文H:"+ sb.toString());
        //sign=1e30e34c9523e87552e83751164e74b9&key=CAdnvO9ZxcI93TZJuPLV/AlN+4ptEL4yxQAUoA35oOghDc0g/c4xQtFO5ckgm4ROsveGT4KiEmi0vQHkpDKuorppFHAgiQ0VLGlXrWioDldAyiHhpVMk6pXRW5QhTHMuJkCBbeT01RU4iVnEFhTvH+46jjZwO0ofAsxshv6rE0s=&content=Jx2Ird3MD79JZvw5cCnrihU1ouSo+aODV2cVMqXxwl7GW8HQnb6Mim4u3uWr0ioGhRx6yxNqGShJRV6Vbs26Pw==&timestamp=1561013049
    }


    @Before
    public void testBefore() {
        /**
         线上环境接口的协议和域名为：https://ldp.xiaoying.com
         测试环境接口的协议和域名为：http://bjtestldp.xiaoying.com
         **/
        // serverUrl
        financeParamMap.put(FinanceCommonParamEnum.PCODE_SERVERURL.getCode(), serverUrl_test);
        // 我方私钥
        financeParamMap.put(FinanceCommonParamEnum.PCODE_PRIVATE_KEY.getCode(), partnerPrivateKey);
        // ${log_finance_name}公钥
        financeParamMap.put(FinanceCommonParamEnum.PCODE_PUBLIC_KEY.getCode(), xyfqPublicKey);
        financeParamMap.put(FinanceCommonParamEnum.PCODE_PUBLIC_KEY.getCode(), xyfqPublicKey);
        // md5签名的附加字符串
        financeParamMap.put(FinanceCommonParamEnum.PCODE_MD5KEY.getCode(), md5Key);
        financeParamMap.put(FinanceCommonParamEnum.${classNameUpper}_PARTENER_FLAG.getCode(), PARTNER_FLAG);
        task.setProductParamsMap(financeParamMap);
        header.setProductid(FINANCE_PRODUCT_ID);
        header.setTerminalid(terminalid);
        header.setUserid(userid);
        //      ProductParamsMap.setMap(ProductEnum.WOKD, financeParamMap);
        System.out.println("=========initFinish===========");
    }

    /**
     * 储蓄卡绑定检查接口  status: pass
     * **/
    @Test
    public void test_user_checkDebitCard() {
        XyfqUserCheckDebitCardReq req = new XyfqUserCheckDebitCardReq();
        req.setHeader(header);
        //req.setClientIp(IP);
        req.setFlowId(flowId_sucess);
        req.setBankCode(bankCode);
        req.setCardMobile(MOBILE);
        req.setCardNo(cardNumber);
        XyfqUserCheckDebitCardRsp xyfqUserCheckDebitCardRsp = task.invoke(req, XyfqUserCheckDebitCardRsp.class);
        verifiedData=xyfqUserCheckDebitCardRsp.getVerifiedData();
        System.out.println("HHHH_test_user_checkDebitCard:"+ JSON.toJSONString(xyfqUserCheckDebitCardRsp));
    }

    /**
     * 储蓄卡绑定  status: pass
     * **/
    @Test
    public void test_user_bindDebitCard() {
      //  test_user_checkDebitCard();
        XyfqUserBindDebitCardReq req = new XyfqUserBindDebitCardReq();
        req.setHeader(header);
        req.setFlowId(flowId_sucess);
        req.setClientIp(IP);
        req.setSmsCode(smsCode);
        req.setVerifiedData(verifiedData);
        XyfqUserBindDebitCardRsp xyfqUserBindDebitCardRsp = task.invoke(req, XyfqUserBindDebitCardRsp.class);
        System.out.println("HHHH_test_user_bindDebitCard:"+JSON.toJSONString(xyfqUserBindDebitCardRsp));
    }


    /**
     * 获取要款地址  status: 等资方进件接口调整
     * **/
    @Test
    public void test_loan_getLoanUrl() {
        XyfqLoanGetLoanUrlReq req = new XyfqLoanGetLoanUrlReq();
        req.setHeader(header);
        req.setFlowId(flowId_sucess);
        req.setClientIp(IP);
        req.setRedirectUrl(redirectUrl);
        XyfqLoanGetLoanUrlRsp xyfqLoanGetLoanUrlRsp = task.invoke(req, XyfqLoanGetLoanUrlRsp.class);
        System.out.println("HHHH_test_loan_getLoanUrl:"+JSON.toJSONString(xyfqLoanGetLoanUrlRsp));
    }

    /**
     * 贷款计算接口(资方弃用)  reason:(现有接口数据结构不达标,资方开发新接口中)
     * **/
    @Test
    @Deprecated
    public void test_base_compute() {
        XyfqApplyQuery2Req req = new XyfqApplyQuery2Req();
        req.setHeader(header);
        req.setFlowId(flowId);
        req.setClientIp(IP);
        req.setAdditionInfoList(null);
        XyfqApplyQuery2Rsp xyfqApplyQuery2Rsp = task.invoke(req, XyfqApplyQuery2Rsp.class);
        System.out.println("HHHH_test_base_compute:"+JSON.toJSONString(xyfqApplyQuery2Rsp));
    }


    /**
     * 要款前测算还款计划接口
     * **/
    @Test
    public void test_apply_computeRepayPlan() {
        XyfqApplyComputeRepayPlanReq req = new XyfqApplyComputeRepayPlanReq();
        req.setHeader(header);
        req.setFlowId(flowId);
        XyfqApplyComputeRepayPlanRsp rsp = task.invoke(req, XyfqApplyComputeRepayPlanRsp.class);
        System.out.println("HHHH_test_apply_computeRepayPlan:"+JSON.toJSONString(rsp));
    }

    /**
     * 合同查询接口  status: pass(资方数据结构不一致)
     * **/
    @Test
    public void test_agreement_getAgreementList() {
        XyfqAgreementGetAgreementListReq req = new XyfqAgreementGetAgreementListReq();
        req.setHeader(header);
        req.setFlowId(flowId);
        req.setClientIp(IP);
        String[] array =new String[4];
        array[0]=XyfqAgreementGetAgreementListReq.register;
        array[1]=XyfqAgreementGetAgreementListReq.bindCreditCard;
        array[2]=XyfqAgreementGetAgreementListReq.bindDebitCard;
        array[3]=XyfqAgreementGetAgreementListReq.apply;
        //array[4]=XyfqAgreementGetAgreementListReq.loan;
        req.setSceneList(array);
        XyfqAgreementGetAgreementListRsp xyfqApplyQuery2Rsp = task.invoke(req, XyfqAgreementGetAgreementListRsp.class);
        List<XyfqAgreement> list= xyfqApplyQuery2Rsp.getAgreements();
        System.out.println("HHHH_test_agreement_getAgreementList list:"+JSON.toJSONString(list));
        System.out.println("HHHH_test_agreement_getAgreementList:"+JSON.toJSONString(xyfqApplyQuery2Rsp));
    }


    /**
     * 获取贷款产品的基本信息 status: pass
     */
    @Test
    public void test_base_productInfo() {
        XyfqBaseProductInfoReq req = new XyfqBaseProductInfoReq();
        req.setProductId(FINANCE_PRODUCT_ID);
        req.setClientIp(IP);
        XyfqProductInfoQueryRsp xyfqProductInfoQueryRsp = task.invoke(req, XyfqProductInfoQueryRsp.class);
        System.out.println("HHHH_test_base_productInfo:"+JSON.toJSONString(xyfqProductInfoQueryRsp));
    }

    /**
     * 获取准入、热门城市列表  status: pass
     * **/
    @Test
    public void test_base_cityInfo() {
        XyfqBaseCityInfoReq req = new XyfqBaseCityInfoReq();
        req.setHeader(header);
        req.setProductId(FINANCE_PRODUCT_ID);
        req.setClientIp(IP);
        req.setInfoType(XyfqInfoTypeEnum.ACCESS_CITY.getCode());
        XyfqBaseCityInfoRsp xyfqBaseCityInfoRsp = task.invoke(req, XyfqBaseCityInfoRsp.class);
        System.out.println("HHHH_test_base_cityInfo:"+JSON.toJSONString(xyfqBaseCityInfoRsp));
    }

    /**
     * 获取银行信息列表  status: pass
     * **/
    @Test
    public void test_base_bankList() {
        XyfqBaseBankListReq req = new XyfqBaseBankListReq();
        req.setHeader(header);
        req.setProductId(FINANCE_PRODUCT_ID);
        req.setClientIp(IP);
        req.setCardType(String.valueOf(XyfqCardTypeEnum.DEBIT_CARD.getCardType()));
        XyfqBaseBankListRsp xyfqBaseBankListRsp = task.invoke(req, XyfqBaseBankListRsp.class);
        System.out.println("HHHH_test_base_bankList:"+JSON.toJSONString(xyfqBaseBankListRsp));
    }

    /**
     * 卡贷信息查询  status: 等资方进件接口调整
     * **/

    final static String flowId_register = "20190613154446280FLOW6888";

    @Test
    public void test_apply_query2() {
        XyfqApplyQuery2Req req = new XyfqApplyQuery2Req();
        req.setHeader(header);
        req.setFlowId(flowId_register);
        req.setClientIp(IP);
        req.setAdditionInfoList(null);
        XyfqApplyQuery2Rsp xyfqApplyQuery2Rsp = task.invoke(req, XyfqApplyQuery2Rsp.class);
        System.out.println("HHHH_test_apply_query2:"+JSON.toJSONString(xyfqApplyQuery2Rsp));
        System.out.println("HHHH_test_apply_query21:"+JSON.toJSONString(xyfqApplyQuery2Rsp.getRepayPlans()));
    }

}
