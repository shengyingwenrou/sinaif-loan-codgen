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
     * 记录订单日志
     * @param creditApplyBean 订单信息
     * @param msg 错误信息
     */
    public void addCreditApplyRemark(CreditApplyBean creditApplyBean,String msg){
        commonServiceHelper.updateCreditApplyBeanRemark(creditApplyBean.getId(), msg);
    }

    /**
     *
     * @param bean  订单信息
     * @param isShowTipMsg 是否展示提示信息
     * @param rejectReason 拒件原因
     */
    public void rejectProcess(CreditApplyBean bean,int isShowTipMsg,String rejectReason) {
        // 获取授信等待期天数配置
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

        // 更新等待期
        Date waitdate = DateUtils.addDate(new Date(), creditWaitday,
                Integer.parseInt(CommonEnum.CREDIT_INFO_PERIODUNIT_DAY.getCode()));
        CreditApplyBean updateBean = new CreditApplyBean();
        updateBean.setId(bean.getId());
        updateBean.setWaitdate(waitdate);
        updateBean.setFailurereason(rejectReason);
        creditApplyService.updateByPrimaryKeySelective(updateBean);
        // 保存进度
        Map<String, Object> keyMap = new HashMap<String, Object>();
        keyMap.put(KeyWordReplaceEnum.CREDITDAY.desc, creditWaitday);
        commonServiceHelper.updateCreditApplyBeanRemark(bean.getId(), rejectReason);
        loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.WAITINGPERIOD, userId, productId, null, null,
                orderId, null, 0, null, isShowTipMsg, keyMap, terminalId);
        // 更新流程
        flowService.rejectFlow(orderId, null, FlowEnum.FIXED_CREDIT_SEND_RESULT.getId(), null, null, rejectReason);
    }


    /**
     * 通过等待期立即扭转到补件
     * @param bean  订单信息
     * @param isShowTipMsg 是否展示消息类型
     * @param rejectReason 通过等待期立即扭转到补件(取消此单开新单送件)
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
     * 身份证返件[多原因时]
     * @param creditApplyBean 订单信息
     * @param returnReason 身份证返件原因
     */
    public void returnIDCardProcess(CreditApplyBean creditApplyBean,String returnReason){
        List<String> itemnoList = Lists.newArrayList();
        itemnoList.add(DataUtil.getItemNo(CommonEnum.DATA_ITEM_CONF_IDCARD_ALL.getCode(), creditApplyBean.getProductid()));
        this.returnProcess(creditApplyBean,FlowEnum.FIXED_CREDIT_SEND, itemnoList,true,  returnReason);
    }


    /**
     * 活体返件[多原因时]
     * @param creditApplyBean 订单信息
     * @param returnReason 活体返件原因
     */
    public void returnIdcardVivo(CreditApplyBean creditApplyBean,String returnReason){
        List<String> itemnoList = Lists.newArrayList();
        itemnoList.add(CommonEnum.DATA_ITEM_CONF_VIVO.getCode());
        this.returnProcess(creditApplyBean,FlowEnum.FIXED_CREDIT_SEND, itemnoList,true,  returnReason);
    }


    /**
     * 返件
     * @param bean 订单信息
     * @param stageCode 返件状态code
     * @param itemnoList 返件步骤项
     * @param isShowTipMsg 是否展示错误信息
     * @param returnReason  返件原因
     */
    public void returnProcess(CreditApplyBean bean,FlowEnum stageCode,List<String> itemnoList,boolean isShowTipMsg,String returnReason) {
        // 插入返件字段到返件表
        if(CollectionUtils.isEmpty(itemnoList)){
            logger.error("【${log_finance_name}】返件时返件步骤项为空");
            return;
        }
        DataInfoReturnVO returnVO = new DataInfoReturnVO();
        returnVO.setProductid(bean.getProductid());
        returnVO.setUserid(bean.getUserid());
        returnVO.setOrderid(bean.getId());
        returnVO.setStagecode(stageCode.getId());
        returnVO.setItemnoList(itemnoList);
        returnVO.setTerminalid(bean.getTerminalid());
        // 错误信息返回标识
        returnVO.setErrorMsgFlag(isShowTipMsg);
        dataInfoReturnService.saveDataInfoReturn(returnVO);
        loanProgressBeanService.saveLoanProgress(LoanProgressTypeEnum.CREDITBACK, bean.getUserid(), bean.getProductid(),
                null, null, bean.getId(), null, 0, null, 1, null, bean.getTerminalid());
        flowService.returnFlow(bean.getId(), null, FlowEnum.FIXED_CREDIT_SEND.getId(), null, null, returnReason);
    }
}
