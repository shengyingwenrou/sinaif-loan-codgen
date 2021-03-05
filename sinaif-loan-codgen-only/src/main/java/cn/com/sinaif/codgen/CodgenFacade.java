/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.com.sinaif.codgen.config.CodgenConfig;
import cn.com.sinaif.codgen.exception.CodgenException;
import cn.com.sinaif.codgen.meta.Table;
import cn.com.sinaif.codgen.meta.TableFactory;

/**
 * 鼹鼠外观类,用于组装内部功能.
 * <p>
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 下午2:00
 */
public class CodgenFacade {
	private static final Logger LOGGER = LoggerFactory.getLogger(CodgenFacade.class);

	private Codgen codgen = new Codgen();

	public CodgenFacade() {
		codgen.setOutputRootDir(CodgenConfig.getOutputRootDir());
		codgen.setExcludes(CodgenConfig.getTemplateExcludes());
	}

	public void deleteByAllTable(String templateRootDir) throws Exception {
		new Paw().processByAllTable(templateRootDir, true);
	}

	public void deleteByTable(String tableName, String templateRootDir) throws Exception {
		new Paw().processByTable(tableName, templateRootDir, true);
	}

	/**
	 * 删除输出目录
	 */
	public void deleteOutputRootDir() throws IOException {
		codgen.deleteOutputRootDir();
	}

	/**
	 * 根据表生成代码
	 *
	 * @param templateRootDir 模版根目录
	 */
	public void generateByAllTable(String templateRootDir) throws Exception {
		new Paw().processByAllTable(templateRootDir, false);
	}

	/**
	 * 根据表生成代码
	 *
	 * @param tableName       表名
	 * @param templateRootDir 模版根目录
	 */
	public void generateByOneTable(String templateRootDir, String tableName) throws Exception {
		new Paw().processByTable(tableName, templateRootDir, false);
	}

	/**
	 * 根据表生成代码
	 *
	 * @param tableNames      表名数组
	 * @param templateRootDir 模版根目录
	 */
	public void generateByTable(String templateRootDir, String... tableNames) throws Exception {
		if (null == tableNames || tableNames.length <= 0) {
			return;
		}
		for (String tableName : tableNames) {
			generateByOneTable(templateRootDir, tableName);
		}
	}

	/**
	 * 打印所有表名
	 */
	public void printAllTableNames() {
		Mouth.printAllTableNames();
	}

	public Codgen getCodgen() {
		return codgen;
	}

	/**
	 * @param templateRootDir 模版根目录
	 * @return 鼹鼠
	 */
	private Codgen getCodgen(String templateRootDir) {
		codgen.setTemplateRootDirs(new File(templateRootDir).getAbsoluteFile());
		return codgen;
	}

	private class Paw {
		/**
		 * 根据数据库表处理
		 *
		 * @param tableName       表名
		 * @param templateRootDir 模版根目录
		 * @param isDelete        是否删除
		 */
		public void processByTable(String tableName, String templateRootDir, boolean isDelete) throws Exception {
			if ("*".equals(tableName)) {
				if (isDelete) {
					deleteByAllTable(templateRootDir);
				} else {
					generateByAllTable(templateRootDir);
				}
				return;
			}
			Codgen m = getCodgen(templateRootDir);
			Table table = TableFactory.getInstance().getTable(tableName);
			try {
				processByTable(m, table, isDelete);
			} catch (CodgenException e) {
				Mouth.printExceptionsSummary(e.getMessage(), getCodgen(templateRootDir).getOutputRootDir(), e.getExceptions());
			}
		}

		/**
		 * 根据数据库表处理
		 *
		 * @param templateRootDir 模版根目录
		 * @param isDelete        是否删除
		 */
		public void processByAllTable(String templateRootDir, boolean isDelete) throws Exception {
			List<Table> tables = TableFactory.getInstance().getAllTables();
			List<Exception> exceptions = Lists.newArrayList();
			for (Table table : tables) {
				try {
					processByTable(getCodgen(templateRootDir), table, isDelete);
				} catch (CodgenException e) {
					exceptions.addAll(e.getExceptions());
				}
			}
			Mouth.printExceptionsSummary("", getCodgen(templateRootDir).getOutputRootDir(), exceptions);
		}

		/**
		 * @param codgen   鼹鼠
		 * @param table    表信息
		 * @param isDelete 是否删除
		 */
		private void processByTable(Codgen codgen, Table table, boolean isDelete) throws Exception {
			Codgen.GeneratorModel model = GeneratorModelUtil.newFromTable(table);
			Mouth.printBeginProcess(table.getSqlName() + " => " + table.getClassName(), isDelete);
			if (isDelete) {
				codgen.deleteBy(model.getTemplateModel(), model.getFilePathModel());
			} else {
				codgen.generateBy(model.getTemplateModel(), model.getFilePathModel());
			}
		}
	}

	private static class GeneratorModelUtil {
		@SuppressWarnings({"unchecked"})
		private static Codgen.GeneratorModel newFromTable(Table table)
				throws InvocationTargetException, NoSuchMethodException, IllegalAccessException {
			Map<String, Object> templateModel = Maps.newHashMap();
			templateModel.put("table", table);
			setShareVars(templateModel);

			Map<String, Object> filePathModel = Maps.newHashMap();
			setShareVars(filePathModel);
			filePathModel.putAll(BeanUtils.describe(table));
			return new Codgen.GeneratorModel(templateModel, filePathModel);
		}

		/**
		 * 设置通用变量
		 */
		@SuppressWarnings({"unchecked"})
		public static void setShareVars(Map templateModel) {
			templateModel.putAll(CodgenConfig.getCodgen());
			templateModel.putAll(System.getProperties());
			templateModel.put("env", System.getenv());
			templateModel.put("now", new Date());
			templateModel.put("databaseName", CodgenConfig.getDatabaseName());
		}
	}

	private static class Mouth {
		/**
		 * 打印所有表名
		 */
		private static void printAllTableNames() {
			LOGGER.info("----All TableNames Begin----");
			List<Table> tables = TableFactory.getInstance().getAllTables();
			for (Table table : tables) {
				LOGGER.info("codgen.generateTable(\"%s\");", table.getSqlName());
			}
			LOGGER.info("----All TableNames End----");
		}

		private static void printExceptionsSummary(String msg, String outRoot, List<Exception> exceptions)
				throws FileNotFoundException {
			File errorFile = new File(outRoot, "codgen_error.log");
			if (null != exceptions && exceptions.size() > 0) {
				System.err.println("[codgen error summary] : " + msg);
				PrintStream output = new PrintStream(new FileOutputStream(errorFile));
				Exception e;
				for (int i = 0, n = exceptions.size(); i < n; i++) {
					e = exceptions.get(i);
					System.err.println("[codgen error]:" + e);
					if (i == 0) {
						e.printStackTrace();
					}
					e.printStackTrace(output);
				}
				output.close();
				LOGGER.error("***************************************************************");
				LOGGER.error("* " + outRoot + "* 输出目录已经生成codgen_error.log用于查看错误 ");
				LOGGER.error("***************************************************************");
			}
		}

		private static void printBeginProcess(String displayText, boolean isDatele) {
			LOGGER.info("***************************************************************");
			LOGGER.info("* begin " + (isDatele ? " delete by " : " generate by ") + displayText);
			LOGGER.info("***************************************************************");
		}
	}
}
