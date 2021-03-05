<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.enums;
import com.sinaif.king.enums.common.CommonEnumConstant;
import org.apache.commons.lang3.StringUtils;

<#include "/java_imports.include" />

public enum ${className}FinanceParamEnum {


    ${classNameUpper}_PCODE_SINA_PRIVATE_KEY(CommonEnumConstant.FINANCE_PARAM_CONF_PCODE, "${classNameLower}SinaPrivateKey","${log_finance_name}新浪方私钥"),
    ${classNameUpper}_PCODE_PUBLIC_KEY(CommonEnumConstant.FINANCE_PARAM_CONF_PCODE, "${classNameLower}PublicKey","${log_finance_name}公钥"),
    ${classNameUpper}_PCODE_SERVER_URL(CommonEnumConstant.FINANCE_PARAM_CONF_PCODE, "serverUrl","接口请求地址"),
    PCODE_MD5KEY(CommonEnumConstant.FINANCE_PARAM_CONF_PCODE, "md5Key","接口请求地址"),

    /** ${log_finance_name}资金方API字段*/
    LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_ORDERNO(CommonEnumConstant.LOAN_BIZ_FINANCE_REF_FINANCEKEY, "orderNo", "${log_finance_name}的合作方订单号"),
    LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_VERIFIEDDATA(CommonEnumConstant.LOAN_BIZ_FINANCE_REF_FINANCEKEY, "verifiedData", "预绑储蓄卡验证数据(每次绑定都要重新获取)"),

    /** ${log_finance_name} 资金方客户流程id */
    LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_FLOW_ID(CommonEnumConstant.LOAN_BIZ_FINANCE_REF_FINANCEKEY, "flowId","${log_finance_name}资流程ID"),

    /** ${log_finance_name} 保费额id */
    LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_PLAN_INSURANCE_AMOUNT(CommonEnumConstant.LOAN_BIZ_FINANCE_REF_FINANCEKEY, "planInsuranceAmount","保费额"),

    /** ${log_finance_name} 绑信用卡、银行卡资方返回的cardId */
    LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_CARDID(CommonEnumConstant.LOAN_BIZ_FINANCE_REF_FINANCEKEY, "cardId","绑卡鉴权id"),

    /** ${log_finance_name} 用户在资方绑定的银行卡 */
    LOAN_BIZ_FINANCE_REF_FINANCEKEY_${classNameUpper}_BANKCARD(CommonEnumConstant.LOAN_BIZ_FINANCE_REF_FINANCEKEY, "financeBankCard","用户在资方绑定的银行卡号"),


    ;
    // 类型来源CommonEnumType
    private String type;
    // 编码
    private String code;
    // 描述
    private String message;

    public String getType() {
        return type;
    }

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    // 构造方法
    private ${className}FinanceParamEnum(String type, String code, String message){
        this.type = type;
        this.message = message;
        this.code = code;
    }

    // 普通方法
    public static String getName(String type, String code)
    {
        if (StringUtils.isEmpty(code))
        {
            return null;
        }
        // 删除状态
        for (${className}FinanceParamEnum c : ${className}FinanceParamEnum.values())
        {
            if (c.type.equals(type) && c.code.equals(code))
            {
                return c.message;
            }
        }
        return null;
    }
}
