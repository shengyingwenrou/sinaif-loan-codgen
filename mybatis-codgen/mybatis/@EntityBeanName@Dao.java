/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.@Component@.@FunctionName@.dao;

import cn.com.sinaif.framework.core.mybatis.IBaseDao;
import cn.com.sinaif.framework.core.mybatis.MybatisDao;
import cn.com.sinaif.@Component@.@FunctionName@.entity.@EntityBeanName@;
import org.springframework.stereotype.Repository;

/**
 * // @EntityBeanName@Dao
 * User: skysong(841676215@qq.com)
 */
@MybatisDao
@Repository
public interface @EntityBeanName@Dao
        extends IBaseDao<@EntityBeanName@, Integer> {

}
