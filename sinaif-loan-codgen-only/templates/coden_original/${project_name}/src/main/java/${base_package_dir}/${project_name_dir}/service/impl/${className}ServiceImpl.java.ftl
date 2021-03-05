<#include "/java_copyright.include">
<#assign className = table.className>
<#assign classNameLower = className?uncap_first>
package ${base_package}.${project_name}.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.apache.commons.lang3.ArrayUtils;
import ${base_package}.dao.${project_name}.${className}Dao;
import ${base_package}.model.${project_name}.${className};

import ${base_package}.model.${project_name}.${className}Example;
import ${base_package}.service.${project_name}.${className}Service;

import java.util.Objects;
import java.util.List;

<#include "/java_imports.include">
@Transactional
@Service
public class ${className}ServiceImpl implements ${className}Service {

    @Autowired
    private ${className}Dao ${classNameLower}Dao;

    /** 创建新${className} **/
    public int create(${className} ${classNameLower}){
        return ${classNameLower}Dao.insert(${classNameLower});
    }

    /** 根据${className}检索 **/
    public ${className} getByCondition(${className} ${classNameLower}) {
        ${className} result = ${classNameLower}Dao.selectByCondition(${classNameLower});
        return result;
    }

    /** 根据主键更新${className} **/
    public void updateByPrimaryKey(${className} ${classNameLower}) {
        ${classNameLower}Dao.updateByPrimaryKey(${classNameLower});
    }

}