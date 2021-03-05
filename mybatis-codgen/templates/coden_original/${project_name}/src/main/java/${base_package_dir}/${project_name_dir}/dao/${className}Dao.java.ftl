<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.${project_name}.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

import ${base_package}.${project_name}.entity.${className};
import ${base_package}.${project_name}.entity.${className}Example;
import cn.com.sinaif.framework.core.mybatis.IBaseDao;
import cn.com.sinaif.framework.core.mybatis.MybatisDao;

<#include "/java_imports.include" />
@MybatisDao
@Repository
public interface ${className}Dao extends IBaseDao<${className}, ${table.pkColumns[0].simpleJavaType}> {

    int countByExample(${className}Example example);

    List<${className}> selectListByExample(${className}Example example);

    int updateByExampleSelective(@Param("record") ${className} record, @Param("example") ${className}Example example);

    int updateByExample(@Param("record") ${className} record, @Param("example") ${className}Example example);

    int deleteByExample(${className}Example example);

    List<${className}> selectListByExampleFromTableName(${className}Example example);
}