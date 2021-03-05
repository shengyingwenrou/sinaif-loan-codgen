<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.${project_name}.dao

import cn.com.magicwifi.framework.core.mybatis.IBaseDao
import cn.com.magicwifi.framework.core.mybatis.MybatisDao
import ${base_package}.${project_name}.entity.${className}
import ${base_package}.${project_name}.entity.${className}Example
import org.apache.ibatis.annotations.Param
import org.springframework.stereotype.Repository

<#include "/java_imports.include" />
@MybatisDao
@Repository
interface ${className}Dao : IBaseDao<${className}, ${table.pkColumns[0].kotlinType}> {
    fun countByExample(example: ${className}Example): Int

    fun selectListByExample(example: ${className}Example): List<${className}>

    fun updateByExampleSelective(@Param("record") record: ${className}, @Param("example") example: ${className}Example): Int

    fun updateByExample(@Param("record") record: ${className}, @Param("example") example: ${className}Example): Int

    fun deleteByExample(example: ${className}Example): Int
}