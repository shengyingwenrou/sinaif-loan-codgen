/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.meta;

import org.apache.commons.lang3.StringUtils;

import java.util.LinkedHashSet;
import java.util.List;

import cn.com.sinaif.codgen.config.CodgenConfig;
import cn.com.sinaif.codgen.utils.CodgenUtil;

/**
 * 表.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 上午9:32
 */
public class Table {

	ColumnSet columns = new ColumnSet();
	private String sqlName;
	private String remarks;
	private String className;

	public String getClassName() {
		if (StringUtils.isBlank(className)) {
			String removedPrefixSqlName = removeTableSqlNamePrefix(sqlName);
			className = CodgenUtil.makePascalCase(removedPrefixSqlName);
		}
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	/**
	 * @param sqlName 数据库表名
	 * @return 移除前缀
	 */
	private String removeTableSqlNamePrefix(String sqlName) {
		String prefixStr = CodgenConfig.getTableRemovePrefixes();
		String[] prefixes = prefixStr.split(",");
		for (String prefix : prefixes) {
			String removedPrefixSqlName = CodgenUtil.removePrefix(sqlName, prefix, true);
			if (!removedPrefixSqlName.equals(sqlName)) {
				return removedPrefixSqlName;
			}
		}
		return sqlName;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getSqlName() {
		return sqlName;
	}

	public void setSqlName(String sqlName) {
		this.sqlName = sqlName;
	}

	/**
	 * 增加列
	 *
	 * @param column 列
	 */
	public void addColumn(Column column) {
		columns.addColumn(column);
	}

	/**
	 * @return 返回值为getClassName(), 第一个字母小写
	 */
	public String getClassNameFirstLower() {
		return StringUtils.uncapitalize(getClassName());
	}

	/**
	 * @return 等价于getClassName().toLowerCase()
	 */
	public String getClassNameLowerCase() {
		return getClassName().toLowerCase();
	}

	public LinkedHashSet<Column> getColumns() {
		return columns.getColumns();
	}

	/**
	 * @return 用于得到常量名, 如className=UserInfo,则constantName=USER_INFO
	 */
	public String getConstantName() {
		return CodgenUtil.toUnderscoreName(getClassName()).toUpperCase();
	}

	/**
	 * @return 得到是日期类型的全部column
	 */
	public List<Column> getDateColumns() {
		return columns.getDateColumns();
	}

	/**
	 * @return 得到不是主键的全部column
	 */
	public List<Column> getNotPkColumns() {
		return columns.getNotPkColumns();
	}

	/**
	 * 得到单主键,等价于getPkColumns().get(0)
	 */
	public Column getPkColumn() {
		Column c = columns.getPkColumn();
		if (null == c) {
			throw new IllegalStateException("not found primary key on table:" + getSqlName());
		}
		return c;
	}

	/**
	 * @return 得到是主键的全部column
	 */
	public List<Column> getPkColumns() {
		return columns.getPkColumns();
	}

	/**
	 * @return 得到主键总数
	 */
	public int getPkCount() {
		return columns.getPkCount();
	}

	/**
	 * @return 得到用下划线分隔的类名称, 如className=UserInfo,则underscoreName=user_info
	 */
	public String getUnderscoreName() {
		return CodgenUtil.toUnderscoreName(getClassName()).toLowerCase();
	}

	public void setColumns(LinkedHashSet<Column> columns) {
		this.columns.setColumns(columns);
	}
}
