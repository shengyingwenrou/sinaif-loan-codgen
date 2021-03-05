<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${base_package}.dao.${project_name}.${className}Dao">
    <!-- 返回结果映射 -->
    <resultMap id="BaseResultMap" type="${base_package}.model.${project_name}.${className}">
        <#list table.pkColumns as c>
        <id column="${c.sqlName}" property="${c.fieldNameFirstLower}" jdbcType="${c.mybatisJdbcType}"/>
        </#list>
        <#list table.notPkColumns as c>
        <result column="${c.sqlName}" property="${c.fieldNameFirstLower}" jdbcType="${c.mybatisJdbcType}"/>
        </#list>
    </resultMap>

    <!-- Example查询条件 -->
    <sql id="Example_Where_Clause">
        <where>
            <foreach collection="oredCriteria" item="criteria" separator="or">
                <if test="criteria.valid">
                    <trim prefix="(" prefixOverrides="and" suffix=")">
                        <foreach collection="criteria.criteria" item="criterion">
                            <choose>
                                <when test="criterion.noValue">
                                    and ${r"${"}criterion.condition}
                                </when>
                                <when test="criterion.singleValue">
                                    and ${r"${"}criterion.condition} ${r"#{"}criterion.value}
                                </when>
                                <when test="criterion.betweenValue">
                                    and ${r"${"}criterion.condition} ${r"#{"}criterion.value} and ${r"#{"}criterion.secondValue}
                                </when>
                                <when test="criterion.listValue">
                                    and ${r"${"}criterion.condition}
                                    <foreach close=")" collection="criterion.value" item="listItem" open="(" separator=",">
                                    ${r"#{"}listItem}
                                    </foreach>
                                </when>
                            </choose>
                        </foreach>
                    </trim>
                </if>
            </foreach>
        </where>
    </sql>

    <!-- Example更新条件 -->
    <sql id="Update_By_Example_Where_Clause">
        <where>
            <foreach collection="example.oredCriteria" item="criteria" separator="or">
                <if test="criteria.valid">
                    <trim prefix="(" prefixOverrides="and" suffix=")">
                        <foreach collection="criteria.criteria" item="criterion">
                            <choose>
                                <when test="criterion.noValue">
                                    and ${r"${"}criterion.condition}
                                </when>
                                <when test="criterion.singleValue">
                                    and ${r"${"}criterion.condition} ${r"#{"}criterion.value}
                                </when>
                                <when test="criterion.betweenValue">
                                    and ${r"${"}criterion.condition} ${r"#{"}criterion.value} and ${r"#{"}criterion.secondValue}
                                </when>
                                <when test="criterion.listValue">
                                    and ${r"${"}criterion.condition}
                                    <foreach close=")" collection="criterion.value" item="listItem" open="(" separator=",">
                                    ${r"#{"}listItem}
                                    </foreach>
                                </when>
                            </choose>
                        </foreach>
                    </trim>
                </if>
            </foreach>
        </where>
    </sql>

    <!-- 列 -->
    <sql id="Base_Column_List">
        <#list table.columns as c>${c.sqlName}<#if c_has_next>, </#if></#list>
    </sql>
    <sql id="Base_Column_List_2">
        <#list table.columns as c>${table.sqlName}.${c.sqlName}<#if c_has_next>, </#if></#list>
    </sql>

    <!-- Where精确匹配字段 -->
    <sql id="equal">
        <#list table.columns as c>
        <if test="null != ${c.fieldNameFirstLower}<#if c.stringColumn> and ${c.fieldNameFirstLower} != ''</#if>">
            and ${c.sqlName} = ${r"#{"}${c.fieldNameFirstLower}}
        </if>
        </#list>
    </sql>

    <!-- 统计表数据量 -->
    <select id="countAll" resultType="java.lang.Integer">
        select count(0)
        from ${table.sqlName}
    </select>

    <!-- 根据条件统计表数据量 -->
    <select id="countByCondition" resultType="java.lang.Integer" parameterType="${base_package}.model.${project_name}.${className}">
        select count(0)
        from ${table.sqlName}
        <where>
            <include refid="equal" />
        </where>
    </select>

    <!-- 根据Example统计数据量 -->
    <select id="countByExample" parameterType="${base_package}.model.${project_name}.${className}Example" resultType="java.lang.Integer">
        select count(0) from ${table.sqlName}
        <if test="_parameter != null">
            <include refid="Example_Where_Clause" />
        </if>
    </select>

    <!-- 根据主键查找 -->
    <select id="selectByPrimaryKey" resultMap="BaseResultMap" parameterType="${table.pkColumns[0].javaType}">
        select
        <include refid="Base_Column_List"/>
        from ${table.sqlName}
        where ${table.pkColumns[0].sqlName} = ${r"#{"}${table.pkColumns[0].fieldNameFirstLower},jdbcType=${table.pkColumns[0].mybatisJdbcType}}
    </select>

    <!-- 根据条件查找单条数据 -->
    <select id="selectByCondition" resultMap="BaseResultMap" parameterType="${base_package}.model.${project_name}.${className}">
        select
        <include refid="Base_Column_List"/>
        from ${table.sqlName}
        <where>
            <include refid="equal" />
        </where>
        limit 1
    </select>

    <!-- 根据主键数组查找数据 -->
    <select id="selectListByPrimaryKeys" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from ${table.sqlName}
        where ${table.pkColumns[0].sqlName} in
        <foreach collection="ids" index="index" item="id" open="(" separator="," close=")">
            ${r"#{"}id}
        </foreach>
    </select>

    <!-- 查找所有 -->
    <select id="selectAll" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from ${table.sqlName}
    </select>

    <!-- 根据组合条件查找列表 -->
    <select id="selectListByCondition" resultMap="BaseResultMap" parameterType="${base_package}.model.${project_name}.${className}">
        select
        <include refid="Base_Column_List"/>
        from ${table.sqlName}
        <where>
            <include refid="equal" />
        </where>
    </select>

    <!-- 根据Example查找 -->
    <select id="selectListByExample" resultMap="BaseResultMap" parameterType="${base_package}.model.${project_name}.${className}Example">
        select
        <if test="distinct">
            distinct
        </if>
        <include refid="Base_Column_List" />
        from ${table.sqlName}
        <if test="_parameter != null">
            <include refid="Example_Where_Clause" />
        </if>

        <if test="regexp != null">
            ${r"${"}regexp}
        </if>

        <if test="orderByClause != null">
            order by ${r"${"}orderByClause}
        </if>
        <if test="paginationByLimit != null">
            limit ${r"${"}paginationByLimit}
        </if>
    </select>

    <!-- 根据主键删除 -->
    <delete id="deleteByPrimaryKey" parameterType="${table.pkColumns[0].javaType}">
        delete from ${table.sqlName}
        where ${table.pkColumns[0].sqlName} = ${r"#{"}${table.pkColumns[0].fieldNameFirstLower},jdbcType=${table.pkColumns[0].mybatisJdbcType}}
    </delete>

    <!-- 根据条件删除 -->
    <delete id="deleteByCondition" parameterType="${base_package}.model.${project_name}.${className}">
        delete from ${table.sqlName}
        <where>
            <include refid="equal" />
        </where>
    </delete>

    <!-- 根据Example删除 -->
    <delete id="deleteByExample" parameterType="${base_package}.model.${project_name}.${className}Example">
        delete from ${table.sqlName}
        <if test="_parameter != null">
            <include refid="Example_Where_Clause" />
        </if>
    </delete>

    <!-- 插入 -->
    <insert id="insert" parameterType="${base_package}.model.${project_name}.${className}" keyProperty="id" useGeneratedKeys="true">
        insert into ${table.sqlName} (
            <include refid="Base_Column_List" />
        )
        values
        (
        <#list table.columns as c>
            ${r"#{"}${c.fieldNameFirstLower},jdbcType=${c.mybatisJdbcType}}<#if c_has_next>,</#if>
        </#list>
        )
    </insert>

    <!-- 选择插入 -->
    <insert id="insertSelective" parameterType="${base_package}.model.${project_name}.${className}" keyProperty="id" useGeneratedKeys="true">
        insert into ${table.sqlName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list table.columns as c>
            <if test="${c.fieldNameFirstLower} != null">
                ${c.sqlName},
            </if>
        </#list>
        </trim>
        <trim prefix="VALUES (" suffix=")" suffixOverrides=",">
        <#list table.columns as c>
            <if test="${c.fieldNameFirstLower} != null">
                ${r"#{"}${c.fieldNameFirstLower},jdbcType=${c.mybatisJdbcType}},
            </if>
        </#list>
        </trim>
    </insert>

    <!-- 选择更新 -->
    <update id="updateByPrimaryKeySelective" parameterType="${base_package}.model.${project_name}.${className}">
        update ${table.sqlName}
        <set>
        <#list table.notPkColumns as c>
            <if test="${c.fieldNameFirstLower} != null">
                ${c.sqlName} = ${r"#{"}${c.fieldNameFirstLower},jdbcType=${c.mybatisJdbcType}},
            </if>
        </#list>
        </set>
        where ${table.pkColumns[0].sqlName} = ${r"#{"}${table.pkColumns[0].fieldNameFirstLower},jdbcType=${table.pkColumns[0].mybatisJdbcType}}
    </update>

    <!-- 更新 -->
    <update id="updateByPrimaryKey" parameterType="${base_package}.model.${project_name}.${className}">
        update ${table.sqlName}
        set
        <#list table.notPkColumns as c>
            ${c.sqlName} = ${r"#{"}${c.fieldNameFirstLower},jdbcType=${c.mybatisJdbcType}}<#if c_has_next>,</#if>
        </#list>
        where ${table.pkColumns[0].sqlName} = ${r"#{"}${table.pkColumns[0].fieldNameFirstLower},jdbcType=${table.pkColumns[0].mybatisJdbcType}}
    </update>

    <!-- 根据Example选择更新 -->
    <update id="updateByExampleSelective" parameterType="map">
        update ${table.sqlName}
        <set>
        <#list table.notPkColumns as c>
            <if test="record.${c.fieldNameFirstLower} != null">
            ${c.sqlName} = ${r"#{"}record.${c.fieldNameFirstLower},jdbcType=${c.mybatisJdbcType}},
            </if>
        </#list>
        </set>
        <if test="_parameter != null">
            <include refid="Update_By_Example_Where_Clause" />
        </if>
    </update>

    <!-- 根据Example更新 -->
    <update id="updateByExample" parameterType="map">
        update ${table.sqlName}
        set
        <#list table.notPkColumns as c>
        ${c.sqlName} = ${r"#{"}record.${c.fieldNameFirstLower},jdbcType=${c.mybatisJdbcType}}<#if c_has_next>,</#if>
        </#list>
        <if test="_parameter != null">
            <include refid="Update_By_Example_Where_Clause" />
        </if>
    </update>
</mapper>