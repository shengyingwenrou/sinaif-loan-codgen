<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.helper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.sinaif.king.common.io.RemoteFile;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.app.SystemParamTypeEnum;
import com.sinaif.king.enums.app.UserContactTypeEnum;
import com.sinaif.king.enums.charge.ChargeDataStatusEnum;
import com.sinaif.king.enums.common.CommonEnum;
import com.sinaif.king.enums.finance.flow.FlowEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.finance.api.FinanceProcessorFactory;
import com.sinaif.king.finance.api.ProductParamsMap;
import com.sinaif.king.finance.service.helper.CommonServiceHelper;
import com.sinaif.king.finance.service.item.helper.CreditFinaServItemHelper;
import com.sinaif.king.finance.util.ImageUtil;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CheckLoanEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}CodeStatusEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}QueryCallDetailEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.enums.${className}UseRregisterFlowStatusEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}UserApplyStatusEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}UserInfoCollectStatusEnum;
import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}AddressInfo;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyApplyReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyQuery2Req;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailPushReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailQueryReq;
import com.sinaif.king.finance.${classNameLower}.model.request.vo.${className}Contact;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckLoanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCollectReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserFaceDetectImageReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserRegisterFlowReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserSupplementReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyApplyRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}ApplyQuery2Rsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}CallDetailPushRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}CallDetailQueryRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCheckLoanRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCollectRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserFaceDetectImageRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserRegisterFlowRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserSupplementRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;
import com.sinaif.king.model.app.enums.DeviceTypeEnum;
import com.sinaif.king.model.datasync.yjyh.UserLoginLogBean;
import com.sinaif.king.model.finance.base.BaseParamBean;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.data.DataInfoBean;
import com.sinaif.king.model.finance.data.vo.BasicInfoVO;
import com.sinaif.king.model.finance.data.vo.ContactData;
import com.sinaif.king.model.finance.data.vo.IDCardVO;
import com.sinaif.king.model.finance.data.vo.UserBankCardVO;
import com.sinaif.king.model.finance.data.vo.UserInfoVo;
import com.sinaif.king.model.finance.product.ProductWithdrawConfBean;
import com.sinaif.king.model.finance.request.FinanceApiRequest;
import com.sinaif.king.service.credit.CreditApplyService;
import com.sinaif.king.service.data.PhoneOperatorService;
import com.sinaif.king.service.data.UserResouceService;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;
import com.sinaif.king.service.product.ProductParamRelService;
import com.sinaif.king.service.product.ProductWithdrawConfService;

<#include "/java_imports.include" />
@Component
public class ${className}CreditApplyProcessHelper extends ${className}BaseHelper{

    private static Logger logger = LoggerFactory.getLogger(${className}CreditApplyProcessHelper.class);

    @Autowired
    protected LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;
    @Autowired
    private UserResouceService userResouceService;
    @Autowired
    private FinanceProcessorFactory financeProcessorFactory;
    @Autowired
    private CommonServiceHelper commonServiceHelper;

    @Autowired
    private CreditApplyService creditApplyService;
    
    @Autowired
    private ${className}BizFinanceRefServiceHelper ${className}BizFinanceRefServiceHelper;

    @Autowired
    private ${className}BusinessServiceHelper ${className}BusinessServiceHelper;

    @Autowired
    private ${className}CreditApplyFailHelper ${className}CreditApplyFailHelper;

    @Autowired
    private ProductParamRelService productParamRelService;

    @Autowired
    private ProductWithdrawConfService productWithdrawConfService;

    @Autowired
    protected PhoneOperatorService phoneOperatorService;

    @Autowired
    private CreditFinaServItemHelper creditFinaServItemHelper;

    private ${className}ApplyApplyReq initReqCheck(${className}ApplyApplyReq req) {
        // ??????????????????????????????
        UserLoginLogBean userLoginLogBean = userResouceService
                .findLastOneUserLoginLog(req.getHeader().getTerminalid(), req.getHeader().getUserid());
        if (null != userLoginLogBean) {
            int deviceType = userLoginLogBean.getDevicetype();
            req.setDeviceId(userLoginLogBean.getDeviceid());
            req.setClientIp(userLoginLogBean.getLoginip());
            DeviceTypeEnum deviceTypeEnum = DeviceTypeEnum.getEnum(deviceType);
            if (null != deviceTypeEnum) {
                if (deviceTypeEnum == DeviceTypeEnum.ANDROID) {
                    req.setOsType(DeviceTypeEnum.ANDROID.desc.toLowerCase());
                } else if (deviceTypeEnum == DeviceTypeEnum.IPHONE) {
                    req.setOsType(DeviceTypeEnum.IPHONE.desc.toLowerCase());
                } else {
                    req.setOsType("h5");
                }
                return req;
            }
        }
        return null;
    }

    /**
     * ????????????
     * @param creditApplyBean ????????????
     * @param flowId ????????????ID
     * @return boolean ????????????
     */
    public boolean userApply(CreditApplyBean creditApplyBean,String flowId, UserBankCardVO userCreditBankCardVO){
        boolean passProcess = false;
        ${className}ApplyApplyReq req = new ${className}ApplyApplyReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);

        req = initReqCheck(req);

        // ????????????????????????????????????
        if (null == req) {
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"???${log_finance_name}??????????????????????????????????????? OsType deviceType ClientIp ");
            return false;
        }

        BasicInfoVO basicInfo = userResouceService.queryBasicInfoVo(creditApplyBean.getUserid(), creditApplyBean.getTerminalid(), creditApplyBean.getId());
        BigDecimal applyamount = basicInfo.getApplyamount();

        ProductWithdrawConfBean productWithdrawConfBean=productWithdrawConfService.findByProductId(creditApplyBean.getProductid(),creditApplyBean.getTerminalid());
        BigDecimal creditApplyAmountMin = Constants.CREDIT_APPLY_AMOUNT_MIN;
        BigDecimal creditApplyAmountMax = Constants.CREDIT_APPLY_AMOUNT_MAX;
        if(null!=productWithdrawConfBean){
            creditApplyAmountMin=productWithdrawConfBean.getMinamount();
            creditApplyAmountMax=productWithdrawConfBean.getMaxamount();
        }

        int gap = applyamount.compareTo(creditApplyAmountMax);
        int minGap = applyamount.compareTo(creditApplyAmountMin);

        // ????????????????????????????????????????????????
        BigDecimal per = new BigDecimal(100);
        if (minGap == -1) {
            req.setAmount(Constants.CREDIT_APPLY_AMOUNT_MIN.multiply(per).intValue());
        } else if (gap == 1) {
            req.setAmount(Constants.CREDIT_APPLY_AMOUNT_MAX.multiply(per).intValue());
        } else {
            req.setAmount(applyamount.multiply(per).intValue());
        }
        List<DataInfoBean> dataInfoBeans = userResouceService.selectDataInfoList(creditApplyBean.getUserid(),
                creditApplyBean.getId(), creditApplyBean.getTerminalid());
        if (CollectionUtils.isEmpty(dataInfoBeans)) {
            String errMsg = "????????????????????????";
            logger.error(LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), errMsg);
            return false;
        }
        String strLoanPeriod = this.getDataInfoLoanPeriod(creditApplyBean.getProductid(),creditApplyBean.getTerminalid(),dataInfoBeans);
        if(StringUtils.isBlank(strLoanPeriod)){
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"???${log_finance_name}????????????????????????????????????????????????");
            return false;
        }
        req.setPeriods(Integer.parseInt(strLoanPeriod));
        Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
        req.setIntention(Integer.parseInt(${className}ProductParamsMapHelper.getLoanIntention(productParamsMap)));


        req.setCreditCardId(userCreditBankCardVO.getBankid());
        FinanceApiRequest<${className}ApplyApplyReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        ${className}ApplyApplyRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                                          .commonRequest(apiReq, ${className}ApplyApplyRsp.class, ${className}TransCode.TRANSCODE_APPLY_APPLY);

        int errorCode = result.getHeader().getCode();
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            passProcess = true;
            logger.info(LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),"???${log_finance_name}?????????????????????");
            creditApplyService.updateCreditApplyBeanRemark(creditApplyBean.getId(), "???${log_finance_name}?????????????????????");
            creditFinaServItemHelper.successCreditApplySubmit(creditApplyBean);
        }else{
            ${className}UserApplyStatusEnum ${classNameLower}UserApplyStatusEnum = ${className}UserApplyStatusEnum.getByCode(errorCode);
            if (null != ${classNameLower}UserApplyStatusEnum) {
                if(${classNameLower}UserApplyStatusEnum==${className}UserApplyStatusEnum.ACCESS_LIMIT||
                        ${classNameLower}UserApplyStatusEnum==${className}UserApplyStatusEnum.REPEAT_APPLY){
                       // ${classNameLower}UserApplyStatusEnum==${className}UserApplyStatusEnum.PROCESS_EX ???????????????????????????
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"???${log_finance_name}???????????????:"+${classNameLower}UserApplyStatusEnum.getRemark());
                    return false;
                }
            }
            // ?????????????????????
            String remark = "???${log_finance_name}???????????????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}???????????????:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }


    /**
     * ??????????????????
     * @param creditApplyBean ????????????
     * @param flowId ????????????ID
     * @param cardno ????????????
     * @param userInfoVo ????????????
     * @return ????????????
     */
    public boolean pushCall(CreditApplyBean creditApplyBean,String flowId, String cardno, UserInfoVo userInfoVo){
        boolean passProcess = false;
        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(), "??????????????????");

        ${className}CallDetailPushReq req = new ${className}CallDetailPushReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);
        //???????????????????????????????????????
        Integer status = userResouceService.getChargeStatus(creditApplyBean.getUserid(), creditApplyBean.getTerminalid());
        logger.info( msgInfo + "???${log_finance_name}?????????????????????????????? ????????????:"+status);
        if (status.equals(ChargeDataStatusEnum.UNDO.getCode()) || status.equals(ChargeDataStatusEnum.FAIL.getCode()) || status
                .equals(ChargeDataStatusEnum.OVERDUE.getCode())) {
            commonServiceHelper.updateCreditApplyBeanRemark(creditApplyBean.getId(), "???????????????????????????" + ChargeDataStatusEnum.getByCode(status).getDesc());
            List<String> itemnoList = Lists.newArrayList();
            itemnoList.add(CommonEnum.DATA_ITEM_CONF_OPERATOR.getCode());
            ${className}CreditApplyFailHelper
                    .returnProcess(creditApplyBean, FlowEnum.FIXED_CREDIT_SEND, itemnoList, true, "???${log_finance_name}???????????????????????? ????????????" + status);
            return false;
        } else if (status == null || status.equals(ChargeDataStatusEnum.DOING.getCode())) {
            logger.info( msgInfo + "???${log_finance_name}?????????????????????????????????,????????? ????????????:"+status);
            return false;
        }
        //???????????????????????????
        JSONObject jsonObject = phoneOperatorService.getOriginalDataPointMemberJson(userInfoVo.getUsername(), cardno);
        if (null == jsonObject) {
            // ????????????????????? ??????????????????????????????????????????
            logger.error(msgInfo + "???${log_finance_name}????????????????????????????????????,????????????????????????");
            return false;
        }
        JSONObject members = jsonObject;
        req.setCallDetail(members.toString());

        FinanceApiRequest<${className}CallDetailPushReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        ${className}CallDetailPushRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                                              .commonRequest(apiReq, ${className}CallDetailPushRsp.class, ${className}TransCode.TRANSCODE_CALLDETAIL_PUSH);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            passProcess = true;
        }else{
            String remark = "???${log_finance_name}?????????????????????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}???????????????????????????:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }

    /**
     * ????????????????????????????????????
     * @param creditApplyBean ????????????
     * @param flowId ????????????ID
     * @return boolean ??????????????????????????????
     */
    public boolean queryCall(CreditApplyBean creditApplyBean,String flowId){
        boolean passProcess = false;
        ${className}CallDetailQueryReq req = new ${className}CallDetailQueryReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);
        FinanceApiRequest<${className}CallDetailQueryReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        ${className}CallDetailQueryRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                                               .commonRequest(apiReq, ${className}CallDetailQueryRsp.class, ${className}TransCode.TRANSCODE_CALLDETAIL_QUERY);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            if (result.getExistValid() == ${className}QueryCallDetailEnum.YES.getCode()) {
                passProcess = true;
            }
        }else{
            String remark = "???${log_finance_name}???????????????????????????????????????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}?????????????????????:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }

    /**
     * ????????????????????????
     * @param creditApplyBean ????????????
     * @param flowId ??????????????????
     * @param cardBean ?????????????????????
     * @return  boolean ????????????
     */
    public boolean faceDetectImage(CreditApplyBean creditApplyBean,String flowId,IDCardVO cardBean) {

        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(), "????????????????????????");

        boolean passProcess = false;
        ${className}UserFaceDetectImageReq req = new ${className}UserFaceDetectImageReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);

        Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
        req.setSource(${className}ProductParamsMapHelper.getFaceSource(productParamsMap));

        //??????????????????????????????????????????
        String livingBestPhotoUrl = cardBean.getImageurl();
        logger.info( msgInfo + "???${log_finance_name}??????????????????????????????,??????????????????livingBestPhotoUrl:"+livingBestPhotoUrl);

        RemoteFile livingBestPhotoFile = null;
        String livingBestPhotoBase64Str;
        try {
            livingBestPhotoFile = new RemoteFile(livingBestPhotoUrl);
            try {
                livingBestPhotoBase64Str = ImageUtil.encodeImgageToBase64(livingBestPhotoFile.getFile());
                livingBestPhotoBase64Str = livingBestPhotoBase64Str.replaceAll("\r|\n", "");
            } catch (Exception e) {
                ${className}CreditApplyFailHelper.returnIdcardVivo(creditApplyBean, "???${log_finance_name}?????????????????????????????????????????????????????????????????????");
                logger.error(msgInfo + "???${log_finance_name}?????????????????????????????????????????????????????????????????????ex:" + e.getMessage());
                return false;
            }
        } catch (RuntimeException e) {
            logger.error(msgInfo + "???${log_finance_name}?????????????????????????????????????????????????????????????????? ex:" + e.getMessage());
            ${className}CreditApplyFailHelper.returnIdcardVivo(creditApplyBean, "???${log_finance_name}???????????????????????????????????????????????????????????????");
            return false;
        } finally {
            if (null != livingBestPhotoFile) {
                livingBestPhotoFile.free();
            }
        }
        req.setImageBase64(livingBestPhotoBase64Str);
        FinanceApiRequest<${className}UserFaceDetectImageReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        ${className}UserFaceDetectImageRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                                                   .commonRequest(apiReq, ${className}UserFaceDetectImageRsp.class, ${className}TransCode.TRANSCODE_USER_FACEDETECTIMAGE);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            passProcess = true;
        }else{
            String remark = "???${log_finance_name}???????????????????????????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}???????????????????????????:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }



    /**
     * ??????????????????
     * @param creditApplyBean ????????????
     * @param flowId ????????????ID
     * @param basicInfo ????????????
     * @return  boolean ????????????
     */
    public boolean uploadUserInfoCollect(CreditApplyBean creditApplyBean,String flowId, BasicInfoVO basicInfo){

        boolean passProcess = false;
        ${className}UserCollectReq req = new ${className}UserCollectReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);

        final String familyAdress = basicInfo.getAddr();
        final String cityCode = basicInfo.getAddrcity();

        List<ContactData> contactList = userResouceService.queryContactInfoList(creditApplyBean.getUserid(),
                creditApplyBean.getTerminalid(), creditApplyBean.getId());

        if (CollectionUtils.isEmpty(contactList)) {
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"???${log_finance_name}??????????????????????????????");
            return false;
        }

        ${className}AddressInfo addressInfo = new ${className}AddressInfo(cityCode, familyAdress);
        req.setAddressInfo(addressInfo);

        ${className}Contact emergencyContact = null;
        ${className}Contact frequentContact = null;

        for(ContactData contactData:contactList) {
            // ????????????????????????????????????
            if (null == emergencyContact) {
                if (contactData.contacttype == UserContactTypeEnum.PARENTS.val
                        || contactData.contacttype == UserContactTypeEnum.CHILD.val
                        || contactData.contacttype == UserContactTypeEnum.SPOUSE.val) {
                    emergencyContact = new ${className}Contact();
                }
                if (null != emergencyContact) {
                    emergencyContact.setName(contactData.getContactname());
                    emergencyContact.setMobile(contactData.getContactphone());

                    String emergencyRelation = this
                            .getRelationCode(creditApplyBean.getProductid(), creditApplyBean.getTerminalid(), contactData);
                    if (StringUtils.isNotBlank(emergencyRelation)) {
                        emergencyContact.setContactType(Integer.parseInt(emergencyRelation));
                    }
                }
            }

            // ????????????????????????????????????  note:??????????????? ?????????
            if (null == frequentContact) {
                if (contactData.contacttype == UserContactTypeEnum.FRIEND.val ||
                    contactData.contacttype == UserContactTypeEnum.WORKMATE.val ||
                    contactData.contacttype == UserContactTypeEnum.BROTHERS.val ||
                    contactData.contacttype == UserContactTypeEnum.SISTERS.val) {
                    frequentContact = new ${className}Contact();
                }

                if (null != frequentContact) {
                    frequentContact.setName(contactData.getContactname());
                    frequentContact.setMobile(contactData.getContactphone());
                    String frequentRelation = this
                            .getRelationCode(creditApplyBean.getProductid(), creditApplyBean.getTerminalid(), contactData);
                    if (StringUtils.isNotBlank(frequentRelation)) {
                        frequentContact.setContactType(Integer.parseInt(frequentRelation));
                    }
                }
            }
        }

        if (null == emergencyContact || null == frequentContact) {
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean, Constants.${classNameUpper}_SHOW_TIP_MSG, "???${log_finance_name}?????????????????????????????????????????????????????????????????????????????????");
            return false;
        }

        req.setEmergencyContact(emergencyContact);
        req.setFrequentContact(frequentContact);
        FinanceApiRequest<${className}UserCollectReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        ${className}UserCollectRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                                           .commonRequest(apiReq, ${className}UserCollectRsp.class, ${className}TransCode.TRANSCODE_USER_COLLECT);
        logger.info(LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), JSON.toJSONString(result));
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            passProcess = true;
        }else{
            int errorCode = result.getHeader().getCode();
            ${className}UserInfoCollectStatusEnum ${classNameLower}UserInfoCollectStatusEnum = ${className}UserInfoCollectStatusEnum.getByCode(errorCode);
            if (null != ${classNameLower}UserInfoCollectStatusEnum) {
                if(${classNameLower}UserInfoCollectStatusEnum==${className}UserInfoCollectStatusEnum.ADRESS_LOST||
                        ${classNameLower}UserInfoCollectStatusEnum==${className}UserInfoCollectStatusEnum.EMERGENCY_CONTACT_LOST||
                        ${classNameLower}UserInfoCollectStatusEnum==${className}UserInfoCollectStatusEnum.FREQUENT_CONTACT_LOST){
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"???${log_finance_name}???????????????????????????"+${classNameLower}UserInfoCollectStatusEnum.getRemark());
                }else if( ${classNameLower}UserInfoCollectStatusEnum==${className}UserInfoCollectStatusEnum.IDCARD_LOST){
                    ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}??????????????????????????????????????????");
                    return false;
                }
            }
            String remark = "???${log_finance_name}??????????????????????????? ??????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}???????????????????????????:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result.getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }


    /**
     * ?????????????????? ???????????????
     * @param creditApplyBean  ????????????
     * @return  boolean  ????????????
     */
    public boolean checkCreditCard(CreditApplyBean creditApplyBean) {
        BaseParamBean baseParamBean = new BaseParamBean();
        baseParamBean.setUserid(creditApplyBean.getUserid());
        baseParamBean.setProductid(creditApplyBean.getProductid());
        baseParamBean.setTerminalid(creditApplyBean.getTerminalid());
        baseParamBean.setOrderid(creditApplyBean.getId());
        UserBankCardVO userBankCardVO = ${className}BizFinanceRefServiceHelper
                .getCreditCard(creditApplyBean.getUserid(), creditApplyBean.getProductid(), creditApplyBean
                        .getTerminalid());
        if (null == userBankCardVO) {
            return false;
        }
        return true;
    }

    /**
     * ????????????????????????
     * @param userInfoVo ??????????????????
     * @param creditApplyBean ????????????
     * @return String ??????????????????????????????flowId
     */
    public String accessRegisterFlow(UserInfoVo userInfoVo,CreditApplyBean creditApplyBean, IDCardVO cardBean) {

        String flowId = null;

        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(),"???????????????????????????");

        ${className}UserRegisterFlowReq req = new ${className}UserRegisterFlowReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setMobile(userInfoVo.getUsername());
        Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
        String clientProductId = ${className}ProductParamsMapHelper.getClientProductId(productParamsMap);
        if (StringUtils.isBlank(clientProductId)) {
            clientProductId = Constants.${classNameUpper}_PRODUCT_ID;
        }
        req.setProductId(clientProductId);
        req.setName(cardBean.getCardname());

        String cardBackImgUrl = cardBean.getOppimageurl();
        if(StringUtils.isBlank(cardBackImgUrl)){
            logger.error(msgInfo + "???${log_finance_name}?????????????????????????????????????????????");
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}?????????????????????????????????????????????");
            return null;
        }

        String cardFrontImgUrl = cardBean.getPosimageurl();
        if(StringUtils.isBlank(cardFrontImgUrl)){
            logger.error(msgInfo + "???${log_finance_name}?????????????????????????????????????????????");
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}?????????????????????????????????????????????");
            return null;
        }

        RemoteFile cardBackImgFile = null;
        RemoteFile cardFrontImgFile = null;

        String cardBackImgBase64Str;
        String cardFrontImgBase64Str;
        try {
            cardBackImgFile = new RemoteFile(cardBackImgUrl);
            cardFrontImgFile = new RemoteFile(cardFrontImgUrl);

            if (null == cardBackImgFile) {
                logger.error(msgInfo + "???${log_finance_name}?????????????????????????????????????????????");
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}?????????????????????????????????????????????");
                return null;
            }

            if (null == cardBackImgFile) {
                logger.error(msgInfo + "???${log_finance_name}?????????????????????????????????????????????");
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}?????????????????????????????????????????????");
                return null;
            }

            try {
                cardBackImgBase64Str = ImageUtil.encodeImgageToBase64(cardBackImgFile.getFile());
                cardBackImgBase64Str = cardBackImgBase64Str.replaceAll("\r|\n", "");

                cardFrontImgBase64Str = ImageUtil.encodeImgageToBase64(cardFrontImgFile.getFile());
                cardFrontImgBase64Str = cardFrontImgBase64Str.replaceAll("\r|\n", "");
            }catch (Exception e){
                logger.error(msgInfo + "???${log_finance_name}???????????????????????????????????????????????????ex:"+e.getMessage());
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}???????????????????????????????????????????????????");
                return null;
            }

        } catch (RuntimeException e) {
            logger.error(msgInfo + "???${log_finance_name}??????????????????????????????????????????????????????????????? ex:"+e.getMessage());
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}???????????????????????????????????????????????????????????????");
            return null;

        } finally {
            if (null != cardBackImgFile) {
                cardBackImgFile.free();
            }
            if (null != cardFrontImgFile) {
                cardBackImgFile.free();
            }
        }
        req.setIdentity(cardBean.getCardno());
        req.setIdFrontBase64(cardFrontImgBase64Str);
        req.setIdBackBase64(cardBackImgBase64Str);

        req.setMobile(userInfoVo.getMobile());
        ${className}UserRegisterFlowRsp result;
        FinanceApiRequest<${className}UserRegisterFlowReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);

        result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                        .commonRequest(apiReq, ${className}UserRegisterFlowRsp.class, ${className}TransCode.TRANSCODE_USER_REGISTERFLOW);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            flowId = result.getFlowId();
            ${className}BizFinanceRefServiceHelper.saveOrUpdateFlowId(creditApplyBean.getUserid(), creditApplyBean.getProductid(), creditApplyBean
                    .getId(), creditApplyBean.getTerminalid(), flowId);
        }else {
            int errorCode = result.getHeader().getCode();
            ${className}UseRregisterFlowStatusEnum ${classNameLower}UseRregisterFlowStatusEnum = ${className}UseRregisterFlowStatusEnum.getByCode(errorCode);
            if (null != ${classNameLower}UseRregisterFlowStatusEnum) {
                if (${classNameLower}UseRregisterFlowStatusEnum == ${className}UseRregisterFlowStatusEnum.RREGISTER_LIMIT
                        ||${classNameLower}UseRregisterFlowStatusEnum == ${className}UseRregisterFlowStatusEnum.IDCARD_LIMIT
                        ||${classNameLower}UseRregisterFlowStatusEnum == ${className}UseRregisterFlowStatusEnum.AUTH_FAIL
                        ) {
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"???${log_finance_name}???????????????????????????"+${classNameLower}UseRregisterFlowStatusEnum.getRemark());
                }
                // ${className}UseRregisterFlowStatusEnum.FAIL ??????????????????????????????
            }
            String remark = "???${log_finance_name}??????????????????????????? ??????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}?????????????????????:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result.getHeader().getCode() + ":" + result.getHeader().getMsg());
        return flowId;
    }



    /**
     * ??????????????????
     * @param orderId ??????ID
     * @return  ${className}ApplyQuery2Rsp ???????????????????????????
     */
    public ${className}ApplyQuery2Rsp creditApplyQuery(String orderId) {

        ${className}ApplyQuery2Rsp ${className}ApplyQuery2Rsp = null;

        if (StringUtils.isBlank(orderId)) {
            return null;
        }
        CreditApplyBean creditApplyBean = creditApplyService.getbyId(orderId);
        if (null == creditApplyBean) {
            throw new ApiException(ApiErrorEnum.COMMON_DATA_ERROR.getCode(), "???????????????????????????????????????");
        }
        String flowId = ${className}BizFinanceRefServiceHelper
                .getFlowId(creditApplyBean.getUserid(), creditApplyBean.getProductid(), creditApplyBean.getId(), creditApplyBean
                        .getTerminalid());
        if (StringUtils.isBlank(flowId)) {
            return null;
        }
        ${className}ApplyQuery2Req req = new ${className}ApplyQuery2Req();
        ${className}ReqHeader ${className}ReqHeader = ${className}BizFinanceRefServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);
        req.setAdditionInfoList(null);
        FinanceApiRequest<${className}ApplyQuery2Req> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        ${className}ApplyQuery2Rsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                                           .commonRequest(apiReq, ${className}ApplyQuery2Rsp.class, ${className}TransCode.TRANSCODE_APPLY_QUERY2);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            ${className}ApplyQuery2Rsp = result;
        }
        logger.error("???${log_finance_name}???????????????????????????:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return ${className}ApplyQuery2Rsp;
    }



    /**
     * ??????????????????????????????
     * @param creditApplyBean ????????????
     * @param userInfoVo ??????
     * @return  boolean ????????????????????????
     */
    public boolean userCheckLoan(CreditApplyBean creditApplyBean, UserInfoVo userInfoVo) {

        boolean passProcess = false;

        ${className}UserCheckLoanReq req = new ${className}UserCheckLoanReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);

        Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
        String clientProductId = ${className}ProductParamsMapHelper.getClientProductId(productParamsMap);
        if (StringUtils.isBlank(clientProductId)) {
            clientProductId = Constants.${classNameUpper}_PRODUCT_ID;
        }
        req.setProductId(clientProductId);

        req.setMobile(userInfoVo.getMobile());
        ${className}UserCheckLoanRsp result;
        FinanceApiRequest<${className}UserCheckLoanReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                        .commonRequest(apiReq, ${className}UserCheckLoanRsp.class, ${className}TransCode.TRANSCODE_USER_CHECKLOAN);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            if (${className}CheckLoanEnum.CHECK_LOAN_YES.getCode() == result.getCheckLoan()) {
                passProcess = true;
            }else{
                if(${className}CheckLoanEnum.CHECK_LOAN_NO.getCode() == result.getCheckLoan()){
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"???${log_finance_name}??????????????????????????????");
                }
            }
        }else{
            String remark = "????????????????????????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}???????????????????????????:"+LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),
                result.getHeader().getCode()+":"+result.getHeader().getMsg());
        return passProcess;
    }


	public List<${className}RepayPlan> query${className}RepayPlanList(String userId, String orderId, String terminalId) {
		String productId = ProductEnum.${classNameUpper}.id;
		String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(userId, productId, orderId, terminalId);
		if (StringUtils.isBlank(flowId)) {
			return null;
		}
		${className}ApplyQuery2Req req = new ${className}ApplyQuery2Req();
		${className}ReqHeader ${className}ReqHeader = ${className}BizFinanceRefServiceHelper.buildReqHeader(terminalId, userId);
		req.setHeader(${className}ReqHeader);
		req.setFlowId(flowId);
		req.setAdditionInfoList(new String[] { Constants.${classNameUpper}_ADDITION_INFO_REPAYPLANLIST });

		FinanceApiRequest<${className}ApplyQuery2Req> apiReq = new FinanceApiRequest<>(productId, req);
		${className}ApplyQuery2Rsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
				.commonRequest(apiReq, ${className}ApplyQuery2Rsp.class, ${className}TransCode.TRANSCODE_APPLY_QUERY2);

		if (result != null && result.getRepayPlanList() != null) {
			List<${className}RepayPlan> list = JSON.parseArray(result.getRepayPlanList().toJSONString(), ${className}RepayPlan.class);
			return list;
		}
		return null;
	}
	
	public ${className}ApplyQuery2Rsp query${className}WithdrawStatus(String userid, String orderid, String terminalid) {
		String productId = ProductEnum.${classNameUpper}.id;
		String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(userid, productId, orderid, terminalid);
		if (StringUtils.isBlank(flowId)) {
			return null;
		}
		${className}ApplyQuery2Req req = new ${className}ApplyQuery2Req();
		${className}ReqHeader ${className}ReqHeader = ${className}BizFinanceRefServiceHelper.buildReqHeader(terminalid, userid);
		req.setHeader(${className}ReqHeader);
		req.setFlowId(flowId);

		FinanceApiRequest<${className}ApplyQuery2Req> apiReq = new FinanceApiRequest<>(productId, req);
		${className}ApplyQuery2Rsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
				.commonRequest(apiReq, ${className}ApplyQuery2Rsp.class, ${className}TransCode.TRANSCODE_APPLY_QUERY2);

		int resCode = result.getHeader().getCode();
		if (${className}CodeStatusEnum.SUCCESS.getCode() == resCode) {
			return result;
		} else if (${className}CodeStatusEnum.PARAM_EXCEPTION.getCode() == resCode
				|| ${className}CodeStatusEnum.SYS_EXCEPTION.getCode() == resCode) {
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, ${className}TransCode.TRANSCODE_APPLY_QUERY2.getDesc() + "???????????????" + result.getHeader().getMsg());
			throw new ApiException(resCode, result.getHeader().getMsg());
		} else {
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "???????????????????????????" + result.getHeader().getMsg());
			return null;
		}
	}

    /**
     * ????????????=107 ????????????
     * @param creditApplyBean ????????????
     * @return boolean ??????????????????
     */
    public boolean userSupplement(CreditApplyBean creditApplyBean,String flowId,IDCardVO cardBean){
        boolean passProcess = false;
        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(),"107??????");
        ${className}UserSupplementReq req = new ${className}UserSupplementReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BizFinanceRefServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);

        String livingBestPhotoUrl = cardBean.getImageurl();
        logger.info( msgInfo + "???${log_finance_name}???????????????,??????????????????livingBestPhotoUrl:"+livingBestPhotoUrl);

        RemoteFile livingBestPhotoFile=null;
        String livingBestPhotoBase64Str;
        try {
            livingBestPhotoFile = new RemoteFile(livingBestPhotoUrl);
            if (null == livingBestPhotoFile) {
                ${className}CreditApplyFailHelper.returnIdcardVivo(creditApplyBean, "???${log_finance_name}???????????????????????????????????????????????????");
                logger.error(msgInfo + "???${log_finance_name}????????????????????????????????????????????????");
                return false;
            }
            try {
                livingBestPhotoBase64Str = ImageUtil.encodeImgageToBase64(livingBestPhotoFile.getFile());
                livingBestPhotoBase64Str = livingBestPhotoBase64Str.replaceAll("\r|\n", "");
            } catch (Exception e) {
                logger.error(msgInfo + "???${log_finance_name}?????????????????????????????????????????????ex:" + e.getMessage());
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}?????????????????????????????????????????????ex");
                return false;
            }
        } catch (Exception e) {
            logger.error(msgInfo + "???${log_finance_name}???????????????????????????????????????????????? ex:" + e.getMessage());
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "???${log_finance_name}???????????????????????????????????????");
            return false;
        } finally {
            if (livingBestPhotoFile != null) {
                livingBestPhotoFile.free();
            }
        }
        req.setIdHandBase64(livingBestPhotoBase64Str);
        FinanceApiRequest<${className}UserSupplementReq> apiReq = new FinanceApiRequest<>(ProductEnum.${classNameUpper}.id, req);
        ${className}UserSupplementRsp result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                                              .commonRequest(apiReq, ${className}UserSupplementRsp.class, ${className}TransCode.TRANSCODE_USER_SUPPLEMENT);
        if (Constants.SUCCESS == result.getHeader().getCode()) {
            passProcess = true;
            logger.info(LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),"???${log_finance_name}?????????????????????");
            creditApplyService.updateCreditApplyBeanRemark(creditApplyBean.getId(), "???${log_finance_name}?????????????????????");
            creditFinaServItemHelper.successCreditApplySubmit(creditApplyBean);
        }else{
            String remark = "???${log_finance_name}????????????????????? ??????:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("???${log_finance_name}?????????????????????:"+LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),
                result.getHeader().getCode()+":"+result.getHeader().getMsg());
        return passProcess;
    }

    /**
     * ????????????
     * @param productid ??????ID
     * @param terminalid ??????ID
     * @param contactData ???????????????
     * @return ?????????????????????
     */
    private String getRelationCode(String productid, String terminalid, ContactData contactData) {
        return productParamRelService.selectCodeByProductidAndSysCode(productid,
                SystemParamTypeEnum.CONTACTRELATION.val, String.valueOf(contactData.getContacttype()), terminalid);
    }

    /**
     * ????????????????????????????????????
     * @param productid ??????ID
     * @param terminalid ??????ID
     * @param dataInfoBeans ?????????
     * @return String ?????????
     */
    private String getDataInfoLoanPeriod(String productid, String terminalid, List<DataInfoBean> dataInfoBeans) {
        return getParamMapValue(productid, terminalid, dataInfoBeans, CommonEnum.DATA_ITEM_CONF_LOANPERIOD,
                SystemParamTypeEnum.LOAN_PERIOD);
    }

    private String getParamMapValue(String productid, String terminalid, List<DataInfoBean> dataInfoBeans,
            CommonEnum commonEnum, SystemParamTypeEnum sysParamTypeEnum) {
        DataInfoBean dataInfoBean = userResouceService.selectDataInfo(dataInfoBeans, commonEnum.getCode());
        if(dataInfoBean == null) {
            return null;
        }
        String debtcode = productParamRelService.selectCodeByProductidAndSysCode(productid, sysParamTypeEnum.val,
                dataInfoBean.getItemvalue(), terminalid);
        return debtcode;
    }

}
