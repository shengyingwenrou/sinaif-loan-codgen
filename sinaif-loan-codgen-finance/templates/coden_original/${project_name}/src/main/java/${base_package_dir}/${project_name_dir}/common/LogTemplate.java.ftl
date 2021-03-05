
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.common;

<#include "/java_imports.include" />

public interface LogTemplate {

	String LOG_TEMPLATE = "userId={} | msg={}";
	
	String LOG_TEMPLATE_DATA = "userId={} | orderId={} | msg={} | data={}";
	
	String LOG_TEMPLATE_ORDER = "userId={} | orderId={} | msg={}";

	String STR_FORMAT_LOG_PROCESS = "userId=%s | orderId=%s | msg=%s";

	String LOG_HTTP_REQUEST="userId={} | interface={} | serviceUrl={} " ;
}
