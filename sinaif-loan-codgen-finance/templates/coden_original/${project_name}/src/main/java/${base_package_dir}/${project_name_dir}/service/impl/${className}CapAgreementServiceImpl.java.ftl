<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.sinaif.king.common.Constants;
import com.sinaif.king.common.ErrorCode;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.finance.agreement.AgreementShowmethodEnum;
import com.sinaif.king.enums.finance.agreement.AgreementTypeEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.finance.api.FinanceProcessorFactory;
import com.sinaif.king.finance.service.item.helper.CommonFinaServItemHelper;
import com.sinaif.king.finance.${classNameLower}.enums.${className}AgreementServiceEnum;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}AgreementGetAgreementListReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}AgreementGetAgreementListRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}Agreement;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BizFinanceRefServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.gateway.agreement.cap.CapAgreementService;
import com.sinaif.king.model.finance.product.vo.AgreementReqVo;
import com.sinaif.king.model.finance.product.vo.FinanceAgreementVO;
import com.sinaif.king.model.finance.request.FinanceApiRequest;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;

<#include "/java_imports.include" />
@Service
public class ${className}CapAgreementServiceImpl implements CapAgreementService {

    Logger logger = LoggerFactory.getLogger(${className}CapAgreementServiceImpl.class);

    private static final String AGREEMENT_NAME_PREFIX = "《";
    private static final String AGREEMENT_NAME_SUFFIX = "》";

    @Autowired
    private ${className}BusinessServiceHelper ${className}BusinessServiceHelper;
    @Autowired
    private FinanceProcessorFactory financeProcessorFactory;
    @Autowired
    protected LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;
    @Autowired
    protected CommonFinaServItemHelper commonHelper;

    @Autowired
    private ${className}BizFinanceRefServiceHelper ${className}BizFinanceRefServiceHelper;
    @Override
    public ProductEnum getServiceName() {
        return ProductEnum.${classNameUpper};
    }

    @Override
    public List<FinanceAgreementVO> getLoanAgreementList(AgreementReqVo vo) {
        if (StringUtils.isBlank(vo.getUserid())) {
            throw new ApiException(ErrorCode.REQUEST_ARGS_ERROR, "参数缺失");
        }
        List<FinanceAgreementVO> agreementList = Lists.newArrayList();

        String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(vo.getUserid(),vo.getProductid(),vo.getOrderid(), vo.getTerminalid());
        logger.info("【${log_finance_name}】获取订单号flowId={},orderid={},terminalid={}", flowId, vo.getOrderid(), vo.getTerminalid());

        ${className}AgreementGetAgreementListReq ${className}AgreementGetAgreementListReq = new ${className}AgreementGetAgreementListReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper.buildReqHeader(vo.getTerminalid(), vo.getUserid());
        ${className}AgreementGetAgreementListReq.setHeader(${className}ReqHeader);
        ${className}AgreementGetAgreementListReq.setFlowId(flowId);

        if (vo.getService() == ${className}AgreementServiceEnum.OPEN_ACCOUNT.getCode()) {
            // 注册阶段合同
            String[] sceneArray = new String[2];
            sceneArray[0] = ${className}AgreementGetAgreementListReq.register;
            sceneArray[1] = ${className}AgreementGetAgreementListReq.apply;
            ${className}AgreementGetAgreementListReq.setSceneList(sceneArray);
        } else if (vo.getService() == ${className}AgreementServiceEnum.BIND_CARD.getCode()) {
            // 绑卡阶段合同
            String[] array = new String[1];
            array[0] = ${className}AgreementGetAgreementListReq.bindCreditCard;
            ${className}AgreementGetAgreementListReq.setSceneList(array);
        } else {
            // 贷后跳向${log_finance_name}资方页面 无需处理协议
            return null;
        }

        ${className}AgreementGetAgreementListRsp result;
        try {
            String msgInfo = "${log_finance_name}【合同查询】terminalid:【" + vo.getTerminalid() + "】订单ID【" + vo.getOrderid() + "】产品ID【" + vo
                    .getProductid() + "】用户ID【" + vo.getUserid() + "】";
            logger.info(msgInfo + "开始");
            FinanceApiRequest<${className}AgreementGetAgreementListReq> apiReq = new FinanceApiRequest<>(vo
                    .getProductid(), ${className}AgreementGetAgreementListReq);
            result = financeProcessorFactory.getProcesser(ProductEnum.${classNameUpper}).getCommonApiService()
                                            .commonRequest(apiReq, ${className}AgreementGetAgreementListRsp.class, ${className}TransCode.TRANSCODE_AGREEMENT_GETAGREEMENTLIST);
            if (result == null) {
                logger.info(msgInfo + "${log_finance_name}【合同查询】结果为空");
                throw new ApiException(ApiErrorEnum.COMMON_SERVICE_ERROR.getCode(), msgInfo + Constants.CUSTOMER_PHONE);
            }
        } catch (Exception e) {
            logger.info("${log_finance_name}【合同查询】接口异常:" + e.getMessage());
            throw new ApiException(ApiErrorEnum.COMMON_FINANCE_REMOTE_CONNECTION_ERROR.getCode(), "${log_finance_name}【合同查询】接口异常:" + e.getMessage());
        }

        if (null != result && CollectionUtils.isNotEmpty(result.getAgreements())) {
            List<${className}Agreement> agreements = result.getAgreements();
            agreements.stream().forEach(a -> {
                FinanceAgreementVO financeAgreementVO = new FinanceAgreementVO();
                financeAgreementVO.setLink(a.getUrl());
                String agreementName = a.getTitle();
                StringBuffer contractNameBuilder = new StringBuffer();
                if (!agreementName.startsWith(AGREEMENT_NAME_PREFIX)) {
                    contractNameBuilder.append(AGREEMENT_NAME_PREFIX);
                }
                contractNameBuilder.append(agreementName);
                if (!agreementName.endsWith(AGREEMENT_NAME_SUFFIX)) {
                    contractNameBuilder.append(AGREEMENT_NAME_SUFFIX);
                }
                financeAgreementVO.setTitle(contractNameBuilder.toString());
                financeAgreementVO.setProductid(vo.getProductid());
                financeAgreementVO.setShowmethod(AgreementShowmethodEnum.SHOW.getCode());
                financeAgreementVO.setType(AgreementTypeEnum.GENERATION.getCode());
                agreementList.add(financeAgreementVO);
            });
        }
        return agreementList;
    }
}
