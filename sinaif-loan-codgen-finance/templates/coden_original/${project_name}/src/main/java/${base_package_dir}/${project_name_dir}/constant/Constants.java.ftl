
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.constant;
import java.math.BigDecimal;

<#include "/java_imports.include" />

public class Constants {

    /** ${log_finance_name}定义我们的产品ID**/
    public static String ${classNameUpper}_PRODUCT_ID = "10001";

    /** 人脸识别的方式 资方固定**/
    public static String ${classNameUpper}_FACE_SOURCE = "faceplusplus";

    /** 资方申请借款的最小金额 **/
    public static final BigDecimal CREDIT_APPLY_AMOUNT_MIN = new BigDecimal("2000");
    /** 资方申请借款的最大金额 **/
    public static final BigDecimal CREDIT_APPLY_AMOUNT_MAX = new BigDecimal("80000");

    /** 默认拒件等待期 **/
    public static final int ${classNameUpper}_DEFAULT_CREDIT_WAIT_DAY = 90;

    /** 默认拒件展示提示消息 **/
    public static final int ${classNameUpper}_SHOW_TIP_MSG = 1;

    /** 资方审批补件逾期五天后取消订单 **/
    public static final Integer SUPPLEMENT_ACTIVE_DAYS = 5;

    /**
     * 分期还款计划信息 资方配置参数
     * 附加信息列表  注:具体使用中可以按照实际需要配置
     * receiveBankCard：收款银行行卡
     * repayBankCard：还款银行卡
     * repayPlanList：还款计划
     */
    public static final String ${classNameUpper}_ADDITION_INFO_RECEIVEBANKCARD = "receiveBankCard";
    public static final String ${classNameUpper}_ADDITION_INFO_REPAYBANKCARD = "repayBankCard";
    public static final String ${classNameUpper}_ADDITION_INFO_REPAYPLANLIST = "repayPlanList";

    /**
     * 进件审批通过
     * 保存业务需要使用到的信息
     * approvePeriods：审批借款期限
     * approveAmount：审批借款金额
     * applyAmount：申请借款金额
     * applyPeriods 申请借款期数
     * planInsuranceAmount 预计保费
     * loanExpireTime 要款过期时间
     */
    public static final String ${classNameUpper}_ORDER_INFO_APPROVE_PERIODS = "approvePeriods";
    public static final String ${classNameUpper}_ORDER_INFO_APPROVE_AMOUNT = "approveAmount";
    public static final String ${classNameUpper}_ORDER_INFO_APPLY_AMOUNT = "applyAmount";
    public static final String ${classNameUpper}_ORDER_INFO_APPLY_PERIODS = "applyPeriods";
    public static final String ${classNameUpper}_ORDER_INFO_PLANIN_SURANCE_AMOUNT = "planInsuranceAmount";
    public static final String ${classNameUpper}_ORDER_INFO_LOAN_EXPIRE_TIME = "loanExpireTime";


    /**响应成功标识*/
    public static final Integer SUCCESS = 0;
    /**响应异常标识*/
    public static final Integer ERROR = 500;

    /**请求成功标识*/
    public static final Integer YES = 1;
    /**请求失败标识*/
    public static final Integer NO = 0;

}
