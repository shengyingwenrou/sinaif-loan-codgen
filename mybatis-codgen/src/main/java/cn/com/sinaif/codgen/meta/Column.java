/*
 Copyright (c) 2015 magicwifi.com.cn
 */
package cn.com.sinaif.codgen.meta;

import org.apache.commons.lang3.StringUtils;

import cn.com.sinaif.codgen.config.CodgenConfig;
import cn.com.sinaif.codgen.utils.CodgenUtil;
import cn.com.sinaif.codgen.utils.DBDataTypeUtil;
import cn.com.sinaif.codgen.utils.JavaPrimitiveTypeMapping;

/**
 * 列.
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 上午9:27
 */
public class Column {
    private int sqlType;
    private String sqlTypeName;
    private String sqlName;

    private boolean isPK;
    private boolean isNullable;
    private boolean isUnique;
    private boolean isIndexed;

    private String remarks;
    private String defaultValue;

    private int size;
    private int decimalDigits;
    private String javaType;
    private String kotlinType;

    private String fieldName;
    private String enumClassName;

    public Column(int sqlType, String sqlTypeName, String sqlName, boolean PK, boolean nullable, boolean unique, boolean indexed,
            String remarks, String defaultValue, int size, int decimalDigits) {
        this.sqlType = sqlType;
        this.sqlTypeName = sqlTypeName;
        this.sqlName = sqlName;
        isPK = PK;
        isNullable = nullable;
        isUnique = unique;
        isIndexed = indexed;
        this.remarks = remarks;
        this.defaultValue = defaultValue;
        this.size = size;
        this.decimalDigits = decimalDigits;

        String normalJdbcJavaType = DBDataTypeUtil.getPreferredJavaType(getSqlType(), getSize(), getDecimalDigits());
        javaType = CodgenConfig.getProperty("java_type_mapping." + normalJdbcJavaType, normalJdbcJavaType).trim();
        kotlinType = CodgenConfig.getProperty("kotlin_type_mapping." + normalJdbcJavaType, normalJdbcJavaType).trim();
        fieldName = CodgenUtil.makePascalCase(getSqlName());
        enumClassName = getFieldName() + "Enum";
    }

    public int getDecimalDigits() {
        return decimalDigits;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public String getEnumClassName() {
        return enumClassName;
    }

    public String getFieldName() {
        return fieldName;
    }

    public String getJavaType() {
        return javaType;
    }

    public String getKotlinType() {
        return kotlinType;
    }

    public String getRemarks() {
        return remarks;
    }

    public int getSize() {
        return size;
    }

    public String getSqlName() {
        return sqlName;
    }

    public int getSqlType() {
        return sqlType;
    }

    public String getSqlTypeName() {
        return sqlTypeName;
    }

    /**
     * 列的常量名称, e.g: BIRTH_DATE
     */
    public String getConstantName() {
        return CodgenUtil.toUnderscoreName(getFieldName()).toUpperCase();
    }

    /**
     * 第一个字母小写的 fieldName,e.g:birthDate
     */
    public String getFieldNameFirstLower() {
        return StringUtils.uncapitalize(getFieldName());
    }

    /**
     * 全部小写的 fieldName,e.g:birthdate
     */
    public String getFieldNameLowerCase() {
        return getFieldName().toLowerCase();
    }

    /**
     * 列是否是日期类型
     */
    public boolean isDateTimeColumn() {
        return DBDataTypeUtil.isDate(getJavaType());
    }

    /**
     * 列是否是Number类型
     */
    public boolean isNumberColumn() {
        return DBDataTypeUtil.isFloatNumber(getJavaType()) || DBDataTypeUtil.isIntegerNumber(getJavaType());
    }

    /**
     * 列是否是String类型
     */
    public boolean isStringColumn() {
        return DBDataTypeUtil.isString(getJavaType());
    }

    /**
     * @return 得到原生类型的javaType, 如java.lang.Integer将返回int, 非原生类型,将直接返回getSimpleJavaType()
     */
    public String getPrimitiveJavaType() {
        return JavaPrimitiveTypeMapping.getPrimitiveType(getSimpleJavaType());
    }

    /**
     * 获取MybatisJdbcType
     */
    public String getMybatisJdbcType() {
        return JavaPrimitiveTypeMapping.getMybatisType(getSimpleJavaType());
    }

    /**
     * 获取JFinalJdbcType
     */
    public String getJfinalJdbcType() {
        return JavaPrimitiveTypeMapping.getJFinalType(getSimpleJavaType());
    }

    /**
     * @return 得到简短的javaType的名称, com.company.model.UserInfo,将返回 UserInfo
     */
    public String getSimpleJavaType() {
        return CodgenUtil.getJavaClassSimpleName(getJavaType());
    }

    public String getUnderscoreName() {
        return getSqlName().toLowerCase();
    }

    public boolean isIndexed() {
        return isIndexed;
    }

    public boolean isNullable() {
        return isNullable;
    }

    public boolean isPK() {
        return isPK;
    }

    public boolean isUnique() {
        return isUnique;
    }

}
