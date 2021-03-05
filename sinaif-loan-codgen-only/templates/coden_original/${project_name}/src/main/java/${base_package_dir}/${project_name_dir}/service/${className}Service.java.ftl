<#include "/java_copyright.include">
<#assign className = table.className>
<#assign classNameLower = className?uncap_first>
package ${base_package}.service.${project_name};

import ${base_package}.model.${project_name}.${className};
import ${base_package}.model.${project_name}.${className}Example;

import java.util.List;

<#include "/java_imports.include">

public interface ${className}Service {

    /** 创建${classNameLower} **/
    public int create(${className} ${classNameLower});

    /** 根据${className}检索 **/
    public ${className} getByCondition(${className} ${classNameLower});

    /** 根据主键更新${classNameLower} **/
    public void updateByPrimaryKey(${className} ${classNameLower});

}