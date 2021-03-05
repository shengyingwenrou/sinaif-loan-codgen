<#include "/java_copyright.include">
<#assign className = table.className>
<#assign classNameLower = className?uncap_first>
package ${base_package}.${project_name}.service

import cn.com.magicwifi.framework.core.mybatis.BaseSvc
import ${base_package}.${project_name}.dao.${className}Dao
import ${base_package}.${project_name}.entity.${className}
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

<#include "/java_imports.include">
@Transactional
@Service
open class ${className}Svc : BaseSvc<${className}, ${table.pkColumns[0].kotlinType}, ${className}Dao>() {

    @Autowired
    override fun setDao(${classNameLower}Dao: ${className}Dao) {
        super.setDao(${classNameLower}Dao)
    }
}