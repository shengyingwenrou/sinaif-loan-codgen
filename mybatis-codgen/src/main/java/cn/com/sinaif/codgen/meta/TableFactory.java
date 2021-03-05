
package cn.com.sinaif.codgen.meta;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cn.com.sinaif.codgen.config.CodgenConfig;
import cn.com.sinaif.framework.core.utils.ExceptionUtils;

/**
 * 根据数据库的元数据(metadata)创建Table对象. (单例)
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 下午2:03
 */
public final class TableFactory {
	private static final Logger LOGGER = LoggerFactory.getLogger(TableFactory.class);
	private static TableFactory instance = null;
	private Connection connection;

	/**
	 * @return TableFactory
	 */
	public synchronized static TableFactory getInstance() {
		if (null == instance) {
			instance = new TableFactory();
		}
		return instance;
	}

	private TableFactory() {
	}

	/**
	 * @return 获取所有Table
	 */
	public List<Table> getAllTables() {
		Connection conn = getConnection();
		try {
			DatabaseMetaData metaData = conn.getMetaData();
			ResultSet rs = metaData.getTables(null, null, null, null);
			List<Table> tables = Lists.newArrayList();
			Table table;
			while (rs.next()) {
				table = createTable(rs);
				if (!isIgnoreTable(table.getSqlName())) {
					tables.add(table);
				}
			}
			return tables;
		} catch (SQLException e) {
			throw ExceptionUtils.unchecked(e);
		}
	}

	/**
	 * @param tableName 表名
	 * @return 根据表名获取表信息
	 */
	public Table getTable(String tableName) {
		return getTable(CodgenConfig.getSchema(), tableName);
	}

	private Table _getTable(String catalog, String schema, String tableName) throws SQLException {
		if (StringUtils.isBlank(tableName)) {
			throw new IllegalArgumentException("tableName must be not empty");
		}
		catalog = StringUtils.trimToNull(catalog);
		schema = StringUtils.trimToNull(schema);

		Connection conn = getConnection();
		DatabaseMetaData dbMetaData = conn.getMetaData();
		ResultSet rs = dbMetaData.getTables(catalog, schema, tableName, null);
		if (rs.next()) {
			return createTable(rs);
		}
		return null;
	}

	/**
	 * @param rs ResultSet
	 * @return 创建Table
	 */
	private Table createTable(ResultSet rs) {
		Table table = new Table();
		try {
			table.setSqlName(rs.getString("TABLE_NAME"));
			table.setRemarks(rs.getString("REMARKS"));

			retrievedTableColumns(table);

			return table;
		} catch (SQLException e) {
			throw new IllegalArgumentException("create table object error : {}");
		}
	}

	/**
	 * @return 获取jdbc Connection
	 */
	private Connection getConnection() {
		try {
			if (null == connection || connection.isClosed()) {
				Class.forName(CodgenConfig.getJdbcDriver());
				connection = DriverManager.getConnection(CodgenConfig.getJdbcUrl(), CodgenConfig.getJdbcUsername(),
						CodgenConfig.getJdbcPassword());
			}
			return connection;
		} catch (Exception e) {
			throw ExceptionUtils.unchecked(e);
		}
	}

	private Table getTable(String schema, String tableName) {
		return getTable(CodgenConfig.getCatalog(), schema, tableName);
	}

	private Table getTable(String catalog, String schema, String tableName) {
		Table t;
		try {
			t = _getTable(catalog, schema, tableName);
			if (t == null && !tableName.equals(tableName.toUpperCase())) {
				t = _getTable(catalog, schema, tableName.toUpperCase());
			}
			if (t == null && !tableName.equals(tableName.toLowerCase())) {
				t = _getTable(catalog, schema, tableName.toLowerCase());
			}
		} catch (Exception e) {
			throw ExceptionUtils.unchecked(e);
		}
		if (t == null) {
			throw new IllegalArgumentException("not found table with give name :"+tableName);
		}
		return t;
	}

	/**
	 * @param table         表
	 * @param primaryKeys   主键
	 * @param indices       索引
	 * @param uniqueIndices 唯一索引
	 * @param uniqueColumns 唯一列
	 * @return 获取列
	 */
	private List<Column> getTableColumns(Table table, List<String> primaryKeys, List<String> indices,
			Map<String, String> uniqueIndices, Map<String, List<String>> uniqueColumns) throws SQLException {
		List<Column> columns = Lists.newLinkedList();
		ResultSet rs = getConnection().getMetaData().getColumns(null, null, table.getSqlName(), null);
		while (rs.next()) {
			int sqlType = rs.getInt("DATA_TYPE");
			String sqlTypeName = rs.getString("TYPE_NAME");
			String columnName = rs.getString("COLUMN_NAME");
			String columnDefaultValue = rs.getString("COLUMN_DEF");
			String remarks = rs.getString("REMARKS");
			int size = rs.getInt("COLUMN_SIZE");
			int decimalDigits = rs.getInt("DECIMAL_DIGITS");
			boolean isPK = primaryKeys.contains(columnName);
			boolean isNullable = rs.getInt("NULLABLE") == DatabaseMetaData.columnNullable;
			boolean isIndexed = indices.contains(columnName);
			String uniqueIndex = uniqueIndices.get(columnName);
			List<String> columnInUniqueIndex = null;
			if (null != uniqueIndex) {
				columnInUniqueIndex = uniqueColumns.get(uniqueIndex);
			}
			boolean isUnique = null != columnInUniqueIndex && columnInUniqueIndex.size() == 1;
			Column column = new Column(sqlType, sqlTypeName, columnName, isPK, isNullable, isUnique, isIndexed, remarks,
					columnDefaultValue, size, decimalDigits);
			columns.add(column);
		}
		rs.close();
		return columns;
	}

	/**
	 * @param table 表
	 * @return 获取表的主键
	 */
	private List<String> getTablePrimaryKeys(Table table) throws SQLException {
		List<String> primaryKeys = Lists.newLinkedList();
		ResultSet rs = getConnection().getMetaData().getPrimaryKeys(null, null, table.getSqlName());
		while (rs.next()) {
			String columnName = rs.getString("COLUMN_NAME");
			primaryKeys.add(columnName);
		}
		rs.close();
		return primaryKeys;
	}

	/**
	 * @param sqlName 表名
	 * @return 是否忽略
	 */
	private boolean isIgnoreTable(String sqlName) {
		String tableStr = CodgenConfig.getIgnoreTables();
		String[] tables = tableStr.split(",");
		for (String table : tables) {
			if (table.equals(sqlName)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 设置列
	 *
	 * @param table 表
	 */
	private void retrievedTableColumns(Table table) throws SQLException {
		List<String> primaryKeys = getTablePrimaryKeys(table);
		if (primaryKeys.size() == 0) {
			LOGGER.warn("[Codgen Warn]:no report any primary key columns in {}", table.getSqlName());
		}
		List<String> indices = Lists.newLinkedList();
		Map<String, String> uniqueIndices = Maps.newHashMap();
		Map<String, List<String>> uniqueColumns = Maps.newHashMap();
		ResultSet indexRs = null;
		try {
			indexRs = getConnection().getMetaData().getIndexInfo(null, null, table.getSqlName(), false, true);
			while (indexRs.next()) {
				String columnName = indexRs.getString("COLUMN_NAME");
				if (null != columnName) {
					indices.add(columnName);
				}

				String indexName = indexRs.getString("INDEX_NAME");
				boolean nonUnique = indexRs.getBoolean("NON_UNIQUE");

				if (!nonUnique && null != columnName && null != indexName) {
					List<String> l = uniqueColumns.get(indexName);
					if (null == l) {
						l = Lists.newArrayList();
						uniqueColumns.put(indexName, l);
					}
					l.add(columnName);
					uniqueIndices.put(columnName, indexName);
				}
			}
		} catch (Throwable ignored) {
		} finally {
			if (null != indexRs) {
				indexRs.close();
			}
		}

		List<Column> columns = getTableColumns(table, primaryKeys, indices, uniqueIndices, uniqueColumns);

		for (Column column : columns) {
			table.addColumn(column);
		}
	}
}
