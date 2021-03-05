<#include "/macro.include" />
<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.${project_name}.entity.base

import java.io.Serializable
<#if table.dateColumns?size gt 0>
import java.util.*
</#if>

abstract class Base${className} : Serializable {
<#list table.columns as column>
    var ${column.fieldNameFirstLower}: ${column.kotlinType}? = null
</#list>
}