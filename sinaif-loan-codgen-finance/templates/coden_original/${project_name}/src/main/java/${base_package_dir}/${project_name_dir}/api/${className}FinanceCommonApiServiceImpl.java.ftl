<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.api;

import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.api.IFinanceCommonApiService;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}AgreementGetAgreementListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyApplyReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyComputeRepayPlanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}ApplyQuery2Req;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailPushReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}CallDetailQueryReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}LoanGetLoanUrlReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindCreditCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserBindDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCardListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckLoanReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCollectReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserFaceDetectImageReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserFaceDetectReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserRegisterFlowReq;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserSupplementReq;
import com.sinaif.king.model.finance.request.FinanceApiRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

<#include "/java_imports.include" />

@Service
@Scope("prototype")
public class ${className}FinanceCommonApiServiceImpl extends ${className}BaseApiService implements IFinanceCommonApiService {

    /**
     * 资方接口请求分发中心
     * @param apiRequest 接口请求参数
     * @param t 返回结果参数类
     * @param transCode 具体调用transCode枚举类
     * @param <E> 具体请求实体
     * @param <T> 具体响应实体
     * @param <M> 请求的TransCode
     * @return 返回封装后的具体响应实体信息
     */
    @Override
    public <E, T, M> T commonRequest(FinanceApiRequest<E> apiRequest, Class<T> t, M transCode) {
        ${className}TransCode ${classNameLower}TransCode = (${className}TransCode) transCode;
        if (${className}TransCode.TRANSCODE_USER_CHECKLOAN.equals(${classNameLower}TransCode)) {
            return userCheckLoan(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_REGISTERFLOW.equals(${classNameLower}TransCode)) {
            return userRegisterFlow(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_COLLECT.equals(${classNameLower}TransCode)) {
            return userCollect(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_FACEDETECT.equals(${classNameLower}TransCode)) {
            return userFaceDetect(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_FACEDETECTIMAGE.equals(${classNameLower}TransCode)) {
            return userFaceDetectImage(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_SUPPLEMENT.equals(${classNameLower}TransCode)) {
            return userSupplement(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_CARDLIST.equals(${classNameLower}TransCode)) {
            return userCardList(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_CHECKDEBITCARD.equals(${classNameLower}TransCode)) {
            return userCheckDebitCard(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_BINDDEBITCARD.equals(${classNameLower}TransCode)) {
            return userBindDebitCard(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_USER_BINDCREDITCARD.equals(${classNameLower}TransCode)) {
            return userBindCreditCard(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_CALLDETAIL_QUERY.equals(${classNameLower}TransCode)) {
            return callDetailQuery(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_CALLDETAIL_PUSH.equals(${classNameLower}TransCode)) {
            return callDetailPush(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_APPLY_APPLY.equals(${classNameLower}TransCode)) {
            return apply(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_LOAN_GETLOANURL.equals(${classNameLower}TransCode)) {
            return loanGetLoanUrl(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_AGREEMENT_GETAGREEMENTLIST.equals(${classNameLower}TransCode)) {
            return agreementGetAgreementList(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_APPLY_QUERY2.equals(${classNameLower}TransCode)) {
            return applyQuery(apiRequest, t);
        } else if (${className}TransCode.TRANSCODE_APPLY_COMPUTEREPAYPLAN.equals(${classNameLower}TransCode)) {
            return applyComputeRepayPlan(apiRequest, t);
        }else{
            logger.info("非法请求,请核查!");
            throw new FinanceException(ApiErrorEnum.COMMON_SERVICE_NOT_EXISTS);
        }
    }

    /**
     * 判断用户是否可以申请贷款
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userCheckLoan(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserCheckLoanReq req = (${className}UserCheckLoanReq) apiRequest.getData();
        return invokeData(req, t);
    }


    /**
     * 用户流程注册
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userRegisterFlow(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserRegisterFlowReq req = (${className}UserRegisterFlowReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 采集用户基本信息接口
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userCollect(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserCollectReq req = (${className}UserCollectReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * face++活体检测
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userFaceDetect(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserFaceDetectReq req = (${className}UserFaceDetectReq) apiRequest.getData();
        return invokeData(req, t);
    }


    /**
     * 上传活体检测照片
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userFaceDetectImage(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserFaceDetectImageReq req = (${className}UserFaceDetectImageReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 补件接口-判断用户是否可以申请贷款
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userSupplement(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserSupplementReq req = (${className}UserSupplementReq) apiRequest.getData();
        return invokeData(req, t);
    }


    /**
     * 获取已绑卡列表
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userCardList(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserCardListReq req = (${className}UserCardListReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 储蓄卡绑定检查接口(会发短信校验码)
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userCheckDebitCard(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserCheckDebitCardReq req = (${className}UserCheckDebitCardReq) apiRequest.getData();
        return invokeData(req, t);
    }


    /**
     * 储蓄卡绑定
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userBindDebitCard(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserBindDebitCardReq req = (${className}UserBindDebitCardReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 信用卡绑卡接口
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T userBindCreditCard(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}UserBindCreditCardReq req = (${className}UserBindCreditCardReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 通话详单-查询接口
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T callDetailQuery(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}CallDetailQueryReq req = (${className}CallDetailQueryReq) apiRequest.getData();
        return invokeData(req, t);
    }


    /**
     * 通话详单上传接口
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T callDetailPush(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}CallDetailPushReq req = (${className}CallDetailPushReq) apiRequest.getData();
        return invokeData(req, t);
    }


    /**
     * 获取要款地址
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T apply(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}ApplyApplyReq req = (${className}ApplyApplyReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 获取要款地址
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T loanGetLoanUrl(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}LoanGetLoanUrlReq req = (${className}LoanGetLoanUrlReq) apiRequest.getData();
        return invokeData(req, t);
    }


    /**
     * 合同查询
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T agreementGetAgreementList(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}AgreementGetAgreementListReq req = (${className}AgreementGetAgreementListReq) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 卡贷信息查询
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T applyQuery(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}ApplyQuery2Req req = (${className}ApplyQuery2Req) apiRequest.getData();
        return invokeData(req, t);
    }

    /**
     * 要款前测算还款计划
     *
     * @param apiRequest 请求信息
     * @param t          响应结果
     * @param <E>        具体请求实体
     * @param <T>        具体响应实体
     * @return 返回封装后的具体响应实体信息
     */
    private <E, T> T applyComputeRepayPlan(FinanceApiRequest<E> apiRequest, Class<T> t) {
        ${className}ApplyComputeRepayPlanReq req = (${className}ApplyComputeRepayPlanReq) apiRequest.getData();
        return invokeData(req, t);
    }


    @Override
    public <E, T> T modifyUserPhone(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T bindBankCardMsgSend(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T bindBankCard(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }

    @Override
    public <E, T> T sendSms(FinanceApiRequest<E> apiRequest, Class<T> t) {
        return null;
    }


}
