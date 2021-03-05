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
        // 进件接口这里独立处理
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
     * 正式进件
     * @param creditApplyBean 订单信息
     * @param flowId 注册流程ID
     * @return boolean 是否补件
     */
    public boolean userApply(CreditApplyBean creditApplyBean,String flowId, UserBankCardVO userCreditBankCardVO){
        boolean passProcess = false;
        ${className}ApplyApplyReq req = new ${className}ApplyApplyReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);

        req = initReqCheck(req);

        // 基础进件信息缺失拒件处理
        if (null == req) {
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"【${log_finance_name}】基础进件信息缺失拒件处理 OsType deviceType ClientIp ");
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

        // 申请金额，范围必须在授信配置之间
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
            String errMsg = "补件资料项不存在";
            logger.error(LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), errMsg);
            return false;
        }
        String strLoanPeriod = this.getDataInfoLoanPeriod(creditApplyBean.getProductid(),creditApplyBean.getTerminalid(),dataInfoBeans);
        if(StringUtils.isBlank(strLoanPeriod)){
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"【${log_finance_name}】正式进件补件资料项借款期限为空");
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
            logger.info(LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),"【${log_finance_name}】正式进件成功");
            creditApplyService.updateCreditApplyBeanRemark(creditApplyBean.getId(), "【${log_finance_name}】正式进件成功");
            creditFinaServItemHelper.successCreditApplySubmit(creditApplyBean);
        }else{
            ${className}UserApplyStatusEnum ${classNameLower}UserApplyStatusEnum = ${className}UserApplyStatusEnum.getByCode(errorCode);
            if (null != ${classNameLower}UserApplyStatusEnum) {
                if(${classNameLower}UserApplyStatusEnum==${className}UserApplyStatusEnum.ACCESS_LIMIT||
                        ${classNameLower}UserApplyStatusEnum==${className}UserApplyStatusEnum.REPEAT_APPLY){
                       // ${classNameLower}UserApplyStatusEnum==${className}UserApplyStatusEnum.PROCESS_EX 跟资方同步重复进件
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"【${log_finance_name}】正式进件:"+${classNameLower}UserApplyStatusEnum.getRemark());
                    return false;
                }
            }
            // 卡队列的状态码
            String remark = "【${log_finance_name}】正式进件:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】正式进件:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }


    /**
     * 上传通话详单
     * @param creditApplyBean 订单信息
     * @param flowId 注册流程ID
     * @param cardno 身份证号
     * @param userInfoVo 用户信息
     * @return 上传结果
     */
    public boolean pushCall(CreditApplyBean creditApplyBean,String flowId, String cardno, UserInfoVo userInfoVo){
        boolean passProcess = false;
        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(), "上传通话详单");

        ${className}CallDetailPushReq req = new ${className}CallDetailPushReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);
        //天贝运营商资料填写状态调用
        Integer status = userResouceService.getChargeStatus(creditApplyBean.getUserid(), creditApplyBean.getTerminalid());
        logger.info( msgInfo + "【${log_finance_name}】运营商认证失败返件 认证状态:"+status);
        if (status.equals(ChargeDataStatusEnum.UNDO.getCode()) || status.equals(ChargeDataStatusEnum.FAIL.getCode()) || status
                .equals(ChargeDataStatusEnum.OVERDUE.getCode())) {
            commonServiceHelper.updateCreditApplyBeanRemark(creditApplyBean.getId(), "运营商未认证，状态" + ChargeDataStatusEnum.getByCode(status).getDesc());
            List<String> itemnoList = Lists.newArrayList();
            itemnoList.add(CommonEnum.DATA_ITEM_CONF_OPERATOR.getCode());
            ${className}CreditApplyFailHelper
                    .returnProcess(creditApplyBean, FlowEnum.FIXED_CREDIT_SEND, itemnoList, true, "【${log_finance_name}】运营商认证失败 认证状态" + status);
            return false;
        } else if (status == null || status.equals(ChargeDataStatusEnum.DOING.getCode())) {
            logger.info( msgInfo + "【${log_finance_name}】运营商认证过度状态中,请等待 认证状态:"+status);
            return false;
        }
        //运营商认证原始数据
        JSONObject jsonObject = phoneOperatorService.getOriginalDataPointMemberJson(userInfoVo.getUsername(), cardno);
        if (null == jsonObject) {
            // 前一步做了返件 此处判断防止获取节点数据为空
            logger.error(msgInfo + "【${log_finance_name}】获取运营商认证原始数据,获取节点数据为空");
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
            String remark = "【${log_finance_name}】上传通话详单:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】上传通话详单结果:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }

    /**
     * 查询是否有有效的通话详单
     * @param creditApplyBean 订单信息
     * @param flowId 注册流程ID
     * @return boolean 是否有有效的通话详单
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
            String remark = "【${log_finance_name}】查询是否有有效的通话详单:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】查询通话详单:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }

    /**
     * 上传人脸识别照片
     * @param creditApplyBean 订单信息
     * @param flowId 人脸识别检测
     * @param cardBean 身份证对象信息
     * @return  boolean 处理结果
     */
    public boolean faceDetectImage(CreditApplyBean creditApplyBean,String flowId,IDCardVO cardBean) {

        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(), "上传人脸识别照片");

        boolean passProcess = false;
        ${className}UserFaceDetectImageReq req = new ${className}UserFaceDetectImageReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);

        Map<String, String> productParamsMap = ProductParamsMap.getMap(ProductEnum.${classNameUpper});
        req.setSource(${className}ProductParamsMapHelper.getFaceSource(productParamsMap));

        //判断活体信息是否已经识别完成
        String livingBestPhotoUrl = cardBean.getImageurl();
        logger.info( msgInfo + "【${log_finance_name}】上传人脸识别照片时,活体图片地址livingBestPhotoUrl:"+livingBestPhotoUrl);

        RemoteFile livingBestPhotoFile = null;
        String livingBestPhotoBase64Str;
        try {
            livingBestPhotoFile = new RemoteFile(livingBestPhotoUrl);
            try {
                livingBestPhotoBase64Str = ImageUtil.encodeImgageToBase64(livingBestPhotoFile.getFile());
                livingBestPhotoBase64Str = livingBestPhotoBase64Str.replaceAll("\r|\n", "");
            } catch (Exception e) {
                ${className}CreditApplyFailHelper.returnIdcardVivo(creditApplyBean, "【${log_finance_name}】上传人脸识别照片时活体图片文件编码时失败返件");
                logger.error(msgInfo + "【${log_finance_name}】上传人脸识别照片时活体图片文件编码时失败返件ex:" + e.getMessage());
                return false;
            }
        } catch (RuntimeException e) {
            logger.error(msgInfo + "【${log_finance_name}】上传人脸识别用户活体图片时文件下载异常返件 ex:" + e.getMessage());
            ${className}CreditApplyFailHelper.returnIdcardVivo(creditApplyBean, "【${log_finance_name}】上传人脸识别用户活体图片文件下载异常返件");
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
            String remark = "【${log_finance_name}】上传人脸识别照片:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】上传人脸识别检测:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }



    /**
     * 资方信息采集
     * @param creditApplyBean 订单信息
     * @param flowId 注册流程ID
     * @param basicInfo 基本信息
     * @return  boolean 处理结果
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
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"【${log_finance_name}】联系人信息为空拒件");
            return false;
        }

        ${className}AddressInfo addressInfo = new ${className}AddressInfo(cityCode, familyAdress);
        req.setAddressInfo(addressInfo);

        ${className}Contact emergencyContact = null;
        ${className}Contact frequentContact = null;

        for(ContactData contactData:contactList) {
            // 获取资方要求的紧急联系人
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

            // 获取资方要求的常用联系人  note:兄弟姐妹时 不送件
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
            ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean, Constants.${classNameUpper}_SHOW_TIP_MSG, "【${log_finance_name}】进件前信息采集常用或者紧急联系人信息匹配为空拒件处理");
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
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"【${log_finance_name}】资方信息采集失败"+${classNameLower}UserInfoCollectStatusEnum.getRemark());
                }else if( ${classNameLower}UserInfoCollectStatusEnum==${className}UserInfoCollectStatusEnum.IDCARD_LOST){
                    ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】资方信息采集缺少身份证返件");
                    return false;
                }
            }
            String remark = "【${log_finance_name}】资方信息采集失败 原因:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】资方信息采集失败:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result.getHeader().getCode() + ":" + result.getHeader().getMsg());
        return passProcess;
    }


    /**
     * 检测是否绑卡 没绑做返件
     * @param creditApplyBean  订单信息
     * @return  boolean  检查结果
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
     * 用户借款资格注册
     * @param userInfoVo 用户身份信息
     * @param creditApplyBean 订单信息
     * @return String 用户借款资格注册流程flowId
     */
    public String accessRegisterFlow(UserInfoVo userInfoVo,CreditApplyBean creditApplyBean, IDCardVO cardBean) {

        String flowId = null;

        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(),"用户借款资格注册时");

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
            logger.error(msgInfo + "【${log_finance_name}】用户证件反面图片地址为空返件");
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户证件反面图片地址为空返件");
            return null;
        }

        String cardFrontImgUrl = cardBean.getPosimageurl();
        if(StringUtils.isBlank(cardFrontImgUrl)){
            logger.error(msgInfo + "【${log_finance_name}】用户证件正面图片地址为空返件");
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户证件正面图片地址为空返件");
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
                logger.error(msgInfo + "【${log_finance_name}】用户证件反面文件下载失败返件");
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户证件反面文件下载失败返件");
                return null;
            }

            if (null == cardBackImgFile) {
                logger.error(msgInfo + "【${log_finance_name}】用户证件正面文件下载失败返件");
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户证件正面文件下载失败返件");
                return null;
            }

            try {
                cardBackImgBase64Str = ImageUtil.encodeImgageToBase64(cardBackImgFile.getFile());
                cardBackImgBase64Str = cardBackImgBase64Str.replaceAll("\r|\n", "");

                cardFrontImgBase64Str = ImageUtil.encodeImgageToBase64(cardFrontImgFile.getFile());
                cardFrontImgBase64Str = cardFrontImgBase64Str.replaceAll("\r|\n", "");
            }catch (Exception e){
                logger.error(msgInfo + "【${log_finance_name}】用户证件正反面文件编码时失败返件ex:"+e.getMessage());
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户证件正反面文件编码时失败返件");
                return null;
            }

        } catch (RuntimeException e) {
            logger.error(msgInfo + "【${log_finance_name}】用户身份证正反面文件不存在或下载异常返件 ex:"+e.getMessage());
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户身份证正反面文件不存在或下载异常返件");
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
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"【${log_finance_name}】借款资格注册失败"+${classNameLower}UseRregisterFlowStatusEnum.getRemark());
                }
                // ${className}UseRregisterFlowStatusEnum.FAIL 处理为卡队列重复进件
            }
            String remark = "【${log_finance_name}】借款资格注册失败 原因:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】借款资格注册:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result.getHeader().getCode() + ":" + result.getHeader().getMsg());
        return flowId;
    }



    /**
     * 卡贷信息查询
     * @param orderId 订单ID
     * @return  ${className}ApplyQuery2Rsp 卡贷信息查询结果集
     */
    public ${className}ApplyQuery2Rsp creditApplyQuery(String orderId) {

        ${className}ApplyQuery2Rsp ${className}ApplyQuery2Rsp = null;

        if (StringUtils.isBlank(orderId)) {
            return null;
        }
        CreditApplyBean creditApplyBean = creditApplyService.getbyId(orderId);
        if (null == creditApplyBean) {
            throw new ApiException(ApiErrorEnum.COMMON_DATA_ERROR.getCode(), "卡贷信息查询时订单信息为空");
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
        logger.error("【${log_finance_name}】卡贷信息查询结果:" + LogTemplate.LOG_TEMPLATE_ORDER, creditApplyBean.getUserid(), creditApplyBean.getId(), result
                .getHeader().getCode() + ":" + result.getHeader().getMsg());
        return ${className}ApplyQuery2Rsp;
    }



    /**
     * 获取用户准入信息结果
     * @param creditApplyBean 订单信息
     * @param userInfoVo 用户
     * @return  boolean 用户准入信息结果
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
                    ${className}CreditApplyFailHelper.rejectProcess(creditApplyBean,Constants.${classNameUpper}_SHOW_TIP_MSG,"【${log_finance_name}】用户准入结果不通过");
                }
            }
        }else{
            String remark = "用户准入失败原因:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】用户准入信息结果:"+LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),
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
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, ${className}TransCode.TRANSCODE_APPLY_QUERY2.getDesc() + "出现异常：" + result.getHeader().getMsg());
			throw new ApiException(resCode, result.getHeader().getMsg());
		} else {
			logger.error(LogTemplate.LOG_TEMPLATE_ORDER, userid, orderid, "获取订单状态失败：" + result.getHeader().getMsg());
			return null;
		}
	}

    /**
     * 进件结果=107 补件逻辑
     * @param creditApplyBean 订单信息
     * @return boolean 补件结果状态
     */
    public boolean userSupplement(CreditApplyBean creditApplyBean,String flowId,IDCardVO cardBean){
        boolean passProcess = false;
        String msgInfo = String.format(LogTemplate.STR_FORMAT_LOG_PROCESS, creditApplyBean.getUserid(), creditApplyBean.getId(),"107补件");
        ${className}UserSupplementReq req = new ${className}UserSupplementReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BizFinanceRefServiceHelper
                .buildReqHeader(creditApplyBean.getTerminalid(), creditApplyBean.getUserid());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);

        String livingBestPhotoUrl = cardBean.getImageurl();
        logger.info( msgInfo + "【${log_finance_name}】补件逻辑,活体图片地址livingBestPhotoUrl:"+livingBestPhotoUrl);

        RemoteFile livingBestPhotoFile=null;
        String livingBestPhotoBase64Str;
        try {
            livingBestPhotoFile = new RemoteFile(livingBestPhotoUrl);
            if (null == livingBestPhotoFile) {
                ${className}CreditApplyFailHelper.returnIdcardVivo(creditApplyBean, "【${log_finance_name}】补件时用户证活体文件下载失败返件");
                logger.error(msgInfo + "【${log_finance_name}】补件时用户活体文件下载失败返件");
                return false;
            }
            try {
                livingBestPhotoBase64Str = ImageUtil.encodeImgageToBase64(livingBestPhotoFile.getFile());
                livingBestPhotoBase64Str = livingBestPhotoBase64Str.replaceAll("\r|\n", "");
            } catch (Exception e) {
                logger.error(msgInfo + "【${log_finance_name}】补件时活体文件编码时失败返件ex:" + e.getMessage());
                ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】补件时活体文件编码时失败返件ex");
                return false;
            }
        } catch (Exception e) {
            logger.error(msgInfo + "【${log_finance_name}】补件时用户活体文件下载异常返件 ex:" + e.getMessage());
            ${className}CreditApplyFailHelper.returnIDCardProcess(creditApplyBean, "【${log_finance_name}】用户活体文件下载异常返件");
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
            logger.info(LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),"【${log_finance_name}】正式补件成功");
            creditApplyService.updateCreditApplyBeanRemark(creditApplyBean.getId(), "【${log_finance_name}】正式补件成功");
            creditFinaServItemHelper.successCreditApplySubmit(creditApplyBean);
        }else{
            String remark = "【${log_finance_name}】正式补件失败 原因:"+  result.getHeader().getCode()+":"+result.getHeader().getMsg();
            ${className}CreditApplyFailHelper.addCreditApplyRemark(creditApplyBean,remark);
        }
        logger.error("【${log_finance_name}】正式补件结果:"+LogTemplate.LOG_TEMPLATE_ORDER,creditApplyBean.getUserid(),creditApplyBean.getId(),
                result.getHeader().getCode()+":"+result.getHeader().getMsg());
        return passProcess;
    }

    /**
     * 关系检查
     * @param productid 产品ID
     * @param terminalid 终端ID
     * @param contactData 联系人信息
     * @return 联系人关系类型
     */
    private String getRelationCode(String productid, String terminalid, ContactData contactData) {
        return productParamRelService.selectCodeByProductidAndSysCode(productid,
                SystemParamTypeEnum.CONTACTRELATION.val, String.valueOf(contactData.getContacttype()), terminalid);
    }

    /**
     * 获取补件项里面的借款期限
     * @param productid 产品ID
     * @param terminalid 终端ID
     * @param dataInfoBeans 补件项
     * @return String 款期限
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
