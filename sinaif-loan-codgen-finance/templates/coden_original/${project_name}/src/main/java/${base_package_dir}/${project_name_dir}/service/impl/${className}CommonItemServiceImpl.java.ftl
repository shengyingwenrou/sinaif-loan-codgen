<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sinaif.king.common.ErrorCode;
import com.sinaif.king.common.utils.HNUtil;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.enums.ApiErrorEnum;
import com.sinaif.king.enums.app.SystemParamTypeEnum;
import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.enums.finance.product.ProductFlag;
import com.sinaif.king.enums.finance.product.ProductMsgType;
import com.sinaif.king.exception.ApiException;
import com.sinaif.king.exception.FinanceException;
import com.sinaif.king.finance.api.FinanceProcessorFactory;
import com.sinaif.king.finance.${classNameLower}.common.LogTemplate;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.finance.${classNameLower}.model.request.${className}UserCheckDebitCardReq;
import com.sinaif.king.finance.${classNameLower}.model.request.base.${className}ReqHeader;
import com.sinaif.king.finance.${classNameLower}.model.respone.${className}UserCheckDebitCardRsp;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BizFinanceRefServiceHelper;
import com.sinaif.king.finance.${classNameLower}.service.helper.${className}BusinessServiceHelper;
import com.sinaif.king.gateway.common.item.CommonItemService;
import com.sinaif.king.model.finance.common.ApplyForBindingCardVO;
import com.sinaif.king.model.finance.data.BankCardPreResultBean;
import com.sinaif.king.model.finance.data.vo.UserInfoVo;
import com.sinaif.king.model.finance.loan.LoanBizFinanceRefBean;
import com.sinaif.king.model.finance.request.FinanceApiRequest;
import com.sinaif.king.service.data.UserResouceService;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;
import com.sinaif.king.service.product.ProductMsgConfService;
import com.sinaif.king.service.product.ProductParamRelService;
import com.sinaif.king.service.system.ISystemParamConfService;

<#include "/java_imports.include" />
@Service
@ProductFlag(ProductEnum.${classNameUpper})
public class ${className}CommonItemServiceImpl implements CommonItemService {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private FinanceProcessorFactory financeProcessorFactory;

    @Autowired
    protected ISystemParamConfService systemParamConfService;
    @Autowired
    private LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;
    @Autowired
    private ProductMsgConfService productMsgConfService;
    @Autowired
    private ProductParamRelService productParamRelService;


    @Autowired
    private ${className}BusinessServiceHelper ${className}BusinessServiceHelper;

    @Autowired
    private UserResouceService userResouceService;

    @Autowired
    private ${className}BizFinanceRefServiceHelper ${className}BizFinanceRefServiceHelper;


    /** 绑定储蓄卡 预绑卡(主要:发送短信以及获取绑卡时资方返回的verifiedData)
     *
     * **/
    /**
     *
     * @param vo 预绑储蓄卡需要的表单数据
     * @return
     */
    @Override
    public BankCardPreResultBean applyForBindingCard(ApplyForBindingCardVO vo) {
    	String productid = vo.getProductId();
        String terminalid = vo.getTerminalId();
        String userid = vo.getUserId();
        String orderid = vo.getOrderid();
        String flowId = ${className}BizFinanceRefServiceHelper.getFlowId(vo.getUserId(),vo.getProductId(),vo.getOrderid(), vo.getTerminalId());

        if(StringUtils.isBlank(flowId)){
            String msg= "【${log_finance_name}】绑卡申请时注册流程flowId为空";
            logger.info(msg);
            throw new ApiException(ErrorCode.USER_INFO_ERROR, msg);
        }
        UserInfoVo userInfoVo = userResouceService.queryUserInfoVo(userid);
    	if(userInfoVo == null) {
    		String errMsg = "用户不存在";
    		logger.error(LogTemplate.LOG_TEMPLATE_ORDER,userid,orderid,errMsg);
    		throw new FinanceException("",errMsg);
    	}
      
        String bankCode = productParamRelService.selectCodeByProductidAndSysCode(productid, SystemParamTypeEnum.OPENBANK.val,
				vo.getBankCode(), terminalid);
        ${className}UserCheckDebitCardReq req = new ${className}UserCheckDebitCardReq();
        ${className}ReqHeader ${className}ReqHeader = ${className}BusinessServiceHelper.buildReqHeader(vo.getTerminalId(), vo.getUserId());
        req.setHeader(${className}ReqHeader);
        req.setFlowId(flowId);
        req.setBankCode(bankCode);
        req.setCardMobile(userInfoVo.getUsername());
        req.setCardNo(vo.getBankCardNum());

        ${className}UserCheckDebitCardRsp result;
        try {

            FinanceApiRequest<${className}UserCheckDebitCardReq> apiRequest = new FinanceApiRequest<>(vo.getProductId(), req);
            result = financeProcessorFactory.getProcesser(ProductEnum.getById(vo.getProductId())).getCommonApiService()
                                            .commonRequest(apiRequest, ${className}UserCheckDebitCardRsp.class, ${className}TransCode.TRANSCODE_USER_CHECKDEBITCARD);
            String verifiedData = result.getVerifiedData();
            if(StringUtils.isEmpty(verifiedData)) {
            	
            }
            ${className}BizFinanceRefServiceHelper
                    .saveOrUpdateVerifiedData(vo.getUserId(), vo.getProductId(), vo.getOrderid(), vo.getTerminalId(), verifiedData);
            BankCardPreResultBean resultBean = new BankCardPreResultBean();
			resultBean.setNeedSms(productMsgConfService.checkSend(vo.getProductId(), ProductMsgType.BANK.getCode(),
					vo.getTerminalId()));
			resultBean.setTerminalid(vo.getTerminalId());
			return resultBean;
        } catch (Exception e) {
            logger.error("【${log_finance_name}】储蓄卡绑定检查接口(会发短信校验码)接口异常", e);
            throw new ApiException(ApiErrorEnum.FINANCE_BINDCARD_ERROR);
        }

    }

    /**
     * 保存鉴权接口返回的protocolNbr
     *
     * @param vo
     * @param servicetype  业务类型：1授信申请，2提款申请，3还款申请，4产品准入
     * @param datafrom     数据来源：1资金方；2本系统
     * @param financekey   资金方业务名称
     * @param financevalue 资金方业务值
     */
    private void saveFinanceNo(ApplyForBindingCardVO vo, int servicetype, int datafrom, String financekey, String financevalue, String terminalid) {
        LoanBizFinanceRefBean refBean = new LoanBizFinanceRefBean();
        refBean.setId(HNUtil.getId());
        refBean.setTerminalid(terminalid);
        refBean.setUserid(vo.getUserId());
        refBean.setProductid(vo.getProductId());
        refBean.setServicetype(servicetype);
        refBean.setDatafrom(datafrom);
        refBean.setServiceid(vo.getUserId());
        refBean.setFinancekey(financekey);
        refBean.setFinancevalue(financevalue);
        refBean.setApplytime(new Date());
        refBean.setTerminalid(terminalid);
        loanBizFinanceRefBeanService.save(refBean);
    }

	@Override
	public boolean isReadOnlyPhoneWithBank() {
		return false;
	}

	@Override
	public boolean isStandardization() {
		return false;
	}
}
