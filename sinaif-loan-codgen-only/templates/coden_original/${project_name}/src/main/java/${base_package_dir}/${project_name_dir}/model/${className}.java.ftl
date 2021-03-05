<#include "/macro.include" />
<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.model.${project_name};

import ${base_package}.model.${project_name}.base.Base${className};

<#include "/java_imports.include" />
@SuppressWarnings("serial")
public class ${className}
		extends Base${className} {
}