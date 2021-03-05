<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.dao.${project_name};

import java.util.List;

import ${base_package}.model.${project_name}.${className};
import ${base_package}.model.${project_name}.${className}Example;

import org.apache.ibatis.annotations.Param;


<#include "/java_imports.include" />


public interface ${className}Dao  {

    int countByCondition(${className} record);

    ${className} selectByPrimaryKey(String id);

    ${className} selectByCondition(${className} record);

    List<${className}> selectListByPrimaryKeys(${className} record);

    int countAll();

    List<${className}> selectListByCondition(${className} record);

    int countByExample(${className}Example example);

    List<${className}> selectListByExample(${className}Example example);

    int deleteByPrimaryKey(String id);

    int deleteByCondition(${className} record);

    int deleteByExample(${className}Example example);

    int insert(${className} record);

    int insertSelective(${className} record);

    int updateByPrimaryKeySelective(${className} record);

    int updateByPrimaryKey(${className} record);

    int updateByExampleSelective(@Param("record") ${className} record, @Param("example") ${className}Example example);

    int updateByExample(@Param("record") ${className} record, @Param("example") ${className}Example example);

}