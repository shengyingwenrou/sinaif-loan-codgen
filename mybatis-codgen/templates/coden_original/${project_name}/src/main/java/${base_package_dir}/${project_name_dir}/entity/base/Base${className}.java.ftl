<#include "/macro.include" />
<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.${project_name}.entity.base;

import java.io.Serializable;
<#if table.dateColumns?size gt 0>
import java.util.Date;
</#if>

@SuppressWarnings("serial")
public abstract class Base${className} implements Serializable {

    <#list table.columns as column>
    private ${column.simpleJavaType} ${column.fieldNameFirstLower};
    </#list>

    <@generateJavaColumns />
}
<#macro generateJavaColumns>
	<#list table.columns as column>

	public void set${column.fieldName}(${column.simpleJavaType} value) {
		this.${column.fieldNameFirstLower} = value;
	}

	public ${column.simpleJavaType} get${column.fieldName}() {
		return this.${column.fieldNameFirstLower};
	}
	</#list>
</#macro>