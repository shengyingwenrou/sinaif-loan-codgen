
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.constant;
<#include "/java_imports.include" />
public interface ExceptionType {

    /** 返件异常类型 **/
     String RETURN_EX = "return_ex";
    /** 返件联系人 **/
    String RETURN_CONTACT_EX = "return_contact_ex";
    /** 返件资料项 **/
    String RETURN_DATAINFO_EX = "return_dataInfo_ex";

    /** 拒件异常类型 **/
     String REJECT_EX = "reject_ex";
    /** 资方接口错误状态码异常 **/
     String REJECT_FLAG = "finance_error_ex";
    /** 我方数据为空 **/
     String DATA_EXCEPTION = "data_info_null_ex";

}
