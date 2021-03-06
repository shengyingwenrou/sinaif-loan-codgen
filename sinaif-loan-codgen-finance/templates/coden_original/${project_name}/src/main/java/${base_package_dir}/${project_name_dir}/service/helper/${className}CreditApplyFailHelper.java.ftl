<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.helper;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.sinaif.king.common.utils.DateUtils;
import com.sinaif.king.common.utils.StringUtils;
import com.sinaif.king.constant.DataUtil;
import com.sinaif.king.enums.common.CommonEnum;
import com.sinaif.king.enums.common.FinanceCommonParamEnum;
import com.sinaif.king.enums.common.KeyWordReplaceEnum;
import com.sinaif.king.enums.common.LoanProgressTypeEnum;
import com.sinaif.king.enums.finance.flow.FlowEnum;
import com.sinaif.king.finance.service.helper.CommonServiceHelper;
import com.sinaif.king.finance.${classNameLower}.constant.Constants;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.data.vo.DataInfoReturnVO;
import com.sinaif.king.service.credit.CreditApplyService;
import com.sinaif.king.service.data.DataInfoReturnService;
import com.sinaif.king.service.flow.item.FlowService;
import com.sinaif.king.service.loan.LoanBizFinanceRefBeanService;
import com.sinaif.king.service.loan.LoanProgressBeanService;
import com.sinaif.king.service.product.finance.FinanceParamConfService;

<#include "/java_imports.include" />
@Component
public class ${className}CreditApplyFailHelper extends ${className}BaseHelper{

    private static Logger logger = LoggerFactory.getLogger(${className}BaseHelper.class);

    @Autowired
    protected LoanBizFinanceRefBeanService loanBizFinanceRefBeanService;

    @Autowired
    private DataInfoReturnService dataInfoReturnService;

    @Autowired
    private LoanProgressBeanService loanProgressBeanService;

    @Autowired
    private FlowService<Void, Void, Void> flowService;

    @Autowired
    private FinanceParamConfService financeParamConfService;

    @Autowired
    private CreditApplyService creditApplyService;

    @Autowired
    private CommonServiceHelper commonServiceHelper;

    /**
     * ??????????????????
     * @param creditApplyBean ????????????
     * @param msg ????????????
     */
    public void addCreditApplyRemark(CreditApplyBean creditApplyBean,String msg){
        commonServiceHelper.updateCreditApplyBeanRemark(creditApplyBean.getId(), msg);
    }

    /**
     *
     * @param bean  ????????????
     * @param isShowTipMsg ????????????????????????
     * @param rejectReason ????????????
     */
    public void rejectProcess(CreditApplyBean bean,int isShowTipMsg,String rejectReason) {
        // ?????????????????????????????????
        String userId = bean.getUserid();
        String orderId = bean.getId();
        String terminalId = bean.getTerminalid();
        String productId = bean.getProductid();

        int creditWaitday = Constants.${classNameUpper}_DEFAULT_CREDIT_WAIT_DAY;
        Map<String, String> productParamsMap = financeParamConfService.initRedisApiProductParamsMap(bean.getProductid());

        String creditWaitdayConfig = productParamsMap.get(FinanceCommonParamEnum.PCODE_CREDITWAITDAY.getCode());
        if (!StringUtils.isEmpty(creditWaitdayConfig)) {
            creditWaitday = Integer.parseInt(creditWaitdayConfig);
        }

        // ???????????????
        Date waitdate = DateUtils.addDate(new Date(), creditWaitday,
                Integer.parseInt(CommonEnum.CREDIT_INFO_PERIODUNIT_DAY.getCode()));
        CreditApplyBean updateBean = new CreditApplyBean();
        updateBean.setId(bean.getId());
        updateBean.setWaitdate(waitdate);
        updateBean.setFailurereason(rejectReason);
        creditApplyService.updateByPrimaryKeySelective(updateBean);
        // ????????????
        Map<String, Object> keyMap = new HashMap<String, Object>();
        keyMap.put(KeyWordReplaceEnum.CREDITDAY.desc, creditWaitday);
        commonServiceHelper.updateCreditApplyBeanRemark(bean.getId(), rejectReason);
        loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.WAITINGPERIOD, userId, productId, null, null,
                orderId, null, 0, null, isShowTipMsg, keyMap, terminalId);
        // ????????????
        flowService.rejectFlow(orderId, null, FlowEnum.FIXED_CREDIT_SEND_RESULT.getId(), null, null, rejectReason);
    }


    /**
     * ????????????????????????????????????
     * @param bean  ????????????
     * @param isShowTipMsg ????????????????????????
     * @param rejectReason ????????????????????????????????????(???????????????????????????)
     */
    public void rejectToCreditInfoExpire(CreditApplyBean bean,int isShowTipMsg,String rejectReason) {
        String userId = bean.getUserid();
        String orderId = bean.getId();
        String terminalId = bean.getTerminalid();
        String productId = bean.getProductid();

        CreditApplyBean updateBean = new CreditApplyBean();
        updateBean.setId(bean.getId());
        updateBean.setWaitdate(new Date());
        updateBean.setFailurereason(rejectReason);
        creditApplyService.updateByPrimaryKeySelective(updateBean);

        commonServiceHelper.updateCreditApplyBeanRemark(bean.getId(), rejectReason);
        loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.WAITINGPERIOD, userId, productId, null, null,
                orderId, null, 0, null, isShowTipMsg, null, terminalId);
        flowService.rejectFlow(orderId, null, FlowEnum.FIXED_CREDIT_SEND_RESULT.getId(), null, null, rejectReason);
    }

    /**
     * ???????????????[????????????]
     * @param creditApplyBean ????????????
     * @param returnReason ?????????????????????
     */
    public void returnIDCardProcess(CreditApplyBean creditApplyBean,String returnReason){
        List<String> itemnoList = Lists.newArrayList();
        itemnoList.add(DataUtil.getItemNo(CommonEnum.DATA_ITEM_CONF_IDCARD_ALL.getCode(), creditApplyBean.getProductid()));
        this.returnProcess(creditApplyBean,FlowEnum.FIXED_CREDIT_SEND, itemnoList,true,  returnReason);
    }


    /**
     * ????????????[????????????]
     * @param creditApplyBean ????????????
     * @param returnReason ??????????????????
     */
    public void returnIdcardVivo(CreditApplyBean creditApplyBean,String returnReason){
        List<String> itemnoList = Lists.newArrayList();
        itemnoList.add(CommonEnum.DATA_ITEM_CONF_VIVO.getCode());
        this.returnProcess(creditApplyBean,FlowEnum.FIXED_CREDIT_SEND, itemnoList,true,  returnReason);
    }


    /**
     * ??????
     * @param bean ????????????
     * @param stageCode ????????????code
     * @param itemnoList ???????????????
     * @param isShowTipMsg ????????????????????????
     * @param returnReason  ????????????
     */
    public void returnProcess(CreditApplyBean bean,FlowEnum stageCode,List<String> itemnoList,boolean isShowTipMsg,String returnReason) {
        // ??????????????????????????????
        if(CollectionUtils.isEmpty(itemnoList)){
            logger.error("???${log_finance_name}?????????????????????????????????");
            return;
        }
        DataInfoReturnVO returnVO = new DataInfoReturnVO();
        returnVO.setProductid(bean.getProductid());
        returnVO.setUserid(bean.getUserid());
        returnVO.setOrderid(bean.getId());
        returnVO.setStagecode(stageCode.getId());
        returnVO.setItemnoList(itemnoList);
        returnVO.setTerminalid(bean.getTerminalid());
        // ????????????????????????
        returnVO.setErrorMsgFlag(isShowTipMsg);
        dataInfoReturnService.saveDataInfoReturn(returnVO);
        loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.CREDITBACK, bean.getUserid(), bean.getProductid(),
                null, null, bean.getId(), null, 0, null, 1, null, bean.getTerminalid());
        flowService.returnFlow(bean.getId(), null, FlowEnum.FIXED_CREDIT_SEND.getId(), null, null, returnReason);
    }
}
