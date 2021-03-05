/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.meta;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;

import cn.com.sinaif.codgen.utils.CodgenUtil;

/**
 * 包含一组Column对象的容器类.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 上午10:56
 */
public class ColumnSet {
	private LinkedHashSet<Column> columns = Sets.newLinkedHashSet();

	public ColumnSet() {
	}

	public ColumnSet(Collection<? extends Column> columns) {
		this.columns = new LinkedHashSet<Column>(columns);
	}

	public LinkedHashSet<Column> getColumns() {
		return columns;
	}

	public void setColumns(LinkedHashSet<Column> columns) {
		this.columns = columns;
	}

	/**
	 * @return 得到主键总数
	 */
	public int getPkCount() {
		int pkCount = 0;
		for (Column c : columns) {
			if (c.isPK()) {
				pkCount++;
			}
		}
		return pkCount;
	}

	public void addColumn(Column c) {
		columns.add(c);
	}

	public Column getByFieldName(String name) {
		if (null == name) {
			return null;
		}

		for (Column c : columns) {
			if (name.equals(c.getFieldName())) {
				return c;
			}
		}
		return null;
	}

	public Column getByName(String name) {
		if (null == name) {
			return null;
		}

		Column c = getBySqlName(name);
		if (null == c) {
			c = getBySqlName(CodgenUtil.toUnderscoreName(name));
		}
		return c;
	}

	public Column getByName(String name, int sqlType) {
		Column c = getBySqlName(name, sqlType);
		if (null == c) {
			c = getBySqlName(CodgenUtil.toUnderscoreName(name), sqlType);
		}
		return c;
	}

	public Column getBySqlName(String name) {
		if (null == name) {
			return null;
		}

		for (Column c : columns) {
			if (name.equalsIgnoreCase(c.getSqlName())) {
				return c;
			}
		}
		return null;
	}

	public Column getBySqlName(String name, int sqlType) {
		for (Column c : columns) {
			if (name.equalsIgnoreCase(c.getSqlName()) && c.getSqlType() == sqlType) {
				return c;
			}
		}
		return null;
	}

	/**
	 * @return 得到是日期类型的全部column
	 */
	public List<Column> getDateColumns() {
		List<Column> results = Lists.newArrayList();
		for (Column c : getColumns()) {
			if (c.isDateTimeColumn()) {
				results.add(c);
			}
		}
		return results;
	}

	/**
	 * @return 得到不是主键的全部column
	 */
	public List<Column> getNotPkColumns() {
		List<Column> results = Lists.newArrayList();
		for (Column c : getColumns()) {
			if (!c.isPK()) {
				results.add(c);
			}
		}
		return results;
	}

	/**
	 * 得到单主键,等价于getPkColumns().get(0)
	 */
	public Column getPkColumn() {
		if (getPkColumns().isEmpty()) {
			return null;
		}
		return getPkColumns().get(0);
	}

	/**
	 * @return 得到是主键的全部column
	 */
	public List<Column> getPkColumns() {
		List<Column> results = Lists.newArrayList();
		for (Column c : getColumns()) {
			if (c.isPK()) {
				results.add(c);
			}
		}
		return results;
	}
}
