<#include "/java_copyright.include">
<#assign className = table.className>
<#assign classNameLower = className?uncap_first>
package ${base_package}.${project_name}.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.ArrayUtils;

import cn.com.sinaif.framework.core.page.Page;
import cn.com.sinaif.framework.core.mybatis.plugin.PaginationUtils;
import cn.com.sinaif.framework.core.page.PageUtils;
import cn.com.sinaif.framework.core.utils.DateUtils;

import ${base_package}.${project_name}.dao.${className}Dao;
import ${base_package}.${project_name}.entity.${className};
import cn.com.sinaif.framework.core.mybatis.BaseSvc;
import ${base_package}.${project_name}.entity.${className}Example;

import java.util.Objects;
import java.util.List;

import java.util.Date;

<#include "/java_imports.include">
@Transactional
@Service
public class ${className}Svc extends BaseSvc<${className}, ${table.pkColumns[0].simpleJavaType}, ${className}Dao> {

    private static Logger logger = LoggerFactory.getLogger(${className}Svc.class);

    private final String PRE_TABLENAME = "${table.sqlName}";

    @Autowired
    @Override
    public void setDao(${className}Dao ${classNameLower}Dao) {
        super.setDao(${classNameLower}Dao);
    }

    public Page<${className}> pagination(Integer pageNo, Integer pageSize, String queryUserName, String queryUserId) {
        ${className}Example example = new ${className}Example();
        ${className}Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotBlank(queryUserId)) {
            criteria.andIdEqualTo(queryUserId);
        }
        if (StringUtils.isNotBlank(queryUserName)) {
            //criteria.andUsernameEqualTo(queryUserName);
        }
        return PaginationUtils.page(PageUtils.checkPageNo(pageNo), pageSize).doSelect(() -> getListByExample(example)).toPage();
    }

    public List<${className}> getListByExample(${className}Example example) {
        List<${className}> list = dao.selectListByExample(example);
        return list;
    }

    public List<${className}> getListByExampleFromTableName(${className}Example example) {
        if(StringUtils.isBlank(example.getPaginationTableName())){
            return null;
        }
        try {
            List<${className}> list = dao.selectListByExampleFromTableName(example);
            return list;
        }catch (Exception e){
            e.getStackTrace();
            return null;
        }
    }


    public Page<${className}> page(Integer pageNo, Integer pageSize, String queryUserName, String queryUserId) {
        ${className}Example example = new ${className}Example();
        ${className}Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotBlank(queryUserName)) {
            //criteria.andUsernameEqualTo(queryUserName);
        }
        if (StringUtils.isNotBlank(queryUserId)) {
            //criteria.andIdEqualTo(queryUserId);
        }
        Integer totalCount = dao.countByExample(example);
        Page<${className}> page = null;
        if (totalCount > 0) {
            page = new Page<>(PageUtils.checkPageNo(pageNo), pageSize, totalCount);
            example.setOrderByClause(" createtime desc ");
            example.setPaginationByLimit(page.getOffset() + "," + page.getLimit());
            try {
                List<${className}> list = dao.selectListByExample(example);
                page.setList(list);
            } catch (Exception e) {
                e.getStackTrace();
            }
        }
        return page;
    }

    private String getPaginationTableName(Date d){
        if (null == d) {
            d = new Date();
        }
            String tableNameSuffix= DateUtils.formatDate(d,"yyyyMMdd");
            String  tableName= PRE_TABLENAME +"_"+tableNameSuffix;
        return tableName;
    }

}