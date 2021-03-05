/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen;

import com.google.common.collect.Lists;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.NullWriter;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.util.List;
import java.util.Map;

import cn.com.sinaif.codgen.exception.CodgenException;
import cn.com.sinaif.codgen.utils.CodgenUtil;
import cn.com.sinaif.codgen.utils.FileUtil;
import cn.com.sinaif.codgen.utils.FreemarkerUtil;

/**
 * 鼹鼠核心引擎.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 下午5:14
 */
public class Codgen {
	private static final Logger LOGGER = LoggerFactory.getLogger(Codgen.class);

	private static final String GENERATOR_INSERT_LOCATION = "generator-insert-location";
	private String outputRootDir;
	private List<File> templateRootDirs = Lists.newArrayList();
	private boolean ignoreTemplateGenerateException = true;
	private String removeExtensions = ".ftl";
	private boolean isCopyBinaryFile = true;
	// 需要处理的模板,使用逗号分隔符,示例值:src/**,test/**
	private String includes;
	// 不需要处理的模板,使用逗号分隔符,示例值:src/**,test/**
	private String excludes;
	private String sourceEncoding = "UTF-8";
	private String outputEncoding = "UTF-8";

	public String getExcludes() {
		return excludes;
	}

	public void setExcludes(String excludes) {
		this.excludes = excludes;
	}

	public String getIncludes() {
		return includes;
	}

	public void setIncludes(String includes) {
		this.includes = includes;
	}

	public String getOutputEncoding() {
		return outputEncoding;
	}

	public void setOutputEncoding(String outputEncoding) {
		if (outputEncoding == null) {
			throw new IllegalArgumentException("outputEncoding must be not null");
		}
		this.outputEncoding = outputEncoding;
	}

	public String getOutputRootDir() {
		return outputRootDir;
	}

	public void setOutputRootDir(String outputRootDir) {
		if (null == outputRootDir) {
			throw new IllegalArgumentException("outputRootDir must be not null");
		}
		this.outputRootDir = outputRootDir;
	}

	public String getSourceEncoding() {
		return sourceEncoding;
	}

	public void setSourceEncoding(String sourceEncoding) {
		if (sourceEncoding == null) {
			throw new IllegalArgumentException("sourceEncoding must be not null");
		}
		this.sourceEncoding = sourceEncoding;
	}

	public List<File> getTemplateRootDirs() {
		return templateRootDirs;
	}

	public boolean isIgnoreTemplateGenerateException() {
		return ignoreTemplateGenerateException;
	}

	public void setIgnoreTemplateGenerateException(boolean ignoreTemplateGenerateException) {
		this.ignoreTemplateGenerateException = ignoreTemplateGenerateException;
	}

	public void setRemoveExtensions(String removeExtensions) {
		this.removeExtensions = removeExtensions;
	}

	/**
	 * 删除生成的文件
	 *
	 * @param templateModel 生成器模板可以引用的变量
	 * @param filePathModel 文件路径可以引用的变量
	 * @return Generator
	 * @throws Exception 异常
	 */
	public Codgen deleteBy(Map<String, Object> templateModel, Map<String, Object> filePathModel) throws Exception {
		processTemplateRootDirs(templateModel, filePathModel, true);
		return this;
	}

	/**
	 * 删除输出目录
	 */
	public void deleteOutputRootDir() throws IOException {
		if (StringUtils.isBlank(getOutputRootDir())) {
			throw new IllegalArgumentException("outputRootDir must be not null");
		}
		LOGGER.info("[delete dir]:{} ", getOutputRootDir());
		FileUtils.deleteDirectory(new File(getOutputRootDir()));
	}

	/**
	 * 生成文件
	 *
	 * @param templateModel 生成器模板可以引用的变量
	 * @param filePathModel 文件路径可以引用的变量
	 * @return Codgen
	 * @throws Exception 异常
	 */
	public Codgen generateBy(Map<String, Object> templateModel, Map<String, Object> filePathModel) throws Exception {
		processTemplateRootDirs(templateModel, filePathModel, false);
		return this;
	}

	public boolean isCopyBinaryFile() {
		return isCopyBinaryFile;
	}

	public void setCopyBinaryFile(boolean copyBinaryFile) {
		isCopyBinaryFile = copyBinaryFile;
	}

	public void setTemplateRootDirs(File... templateRootDirs) {
		this.templateRootDirs = Lists.newArrayList(templateRootDirs);
	}

	public void addTemplateRootDir(File file) {
		templateRootDirs.add(file);
	}

	/**
	 * 处理模版目录
	 */
	private void processTemplateRootDirs(Map<String, Object> templateModel, Map filePathModel, boolean isDelete)
			throws Exception {
		if (StringUtils.isBlank(getOutputRootDir())) {
			throw new IllegalStateException("'output_root' 属性不能为空.");
		}
		if (templateRootDirs.size() == 0) {
			throw new IllegalStateException("'templateRootDirs' 不能为空");
		}
		CodgenException me = new CodgenException("codgen occer error, codgen bean info:" + BeanUtils.describe(this));
		for (File templateRootDir : this.templateRootDirs) {
			List<Exception> exceptions =
					scanTemplatesAndProcess(templateRootDir, templateModel, filePathModel, isDelete);
			me.addAll(exceptions);
		}
		if (!me.getExceptions().isEmpty()) {
			throw me;
		}
	}

	/**
	 * 扫描模版并处理
	 */
	private List<Exception> scanTemplatesAndProcess(File templateRootDir, Map<String, Object> templateModel,
			Map filePathModel, boolean delete) throws Exception {
		if (null == templateRootDir) {
			throw new IllegalStateException("'templateRootDir' 不能为空");
		}
		LOGGER.info("=>load template from templateRootDir = '{}', outputRootDir: '{}'", templateRootDir.getAbsolutePath(),
				new File(outputRootDir).getAbsolutePath());

		List<File> srcFiles = FileUtil.searchAllNotIgnoreFile(templateRootDir);
		List<Exception> exceptions = Lists.newArrayList();
		for (File srcFile : srcFiles) {
			try {
				if (delete) {
					new TemplateProcessor().executeDelete(templateRootDir, templateModel, filePathModel, srcFile);
				} else {
					new TemplateProcessor().executeGenerate(templateRootDir, templateModel, filePathModel, srcFile);
				}
			} catch (Exception e) {
				if (ignoreTemplateGenerateException) {
					LOGGER.warn("ignore generate error, template is: {} cause: {}", srcFile, e);
					exceptions.add(e);
				} else {
					throw e;
				}
			}
		}
		return exceptions;
	}

	private class TemplateProcessor {
		private CodgenControl mc = new CodgenControl();

		public void executeGenerate(File templateRootDir, Map<String, Object> templateModel, Map filePathModel,
				File srcFile) throws IOException {
			String templateFile = FileUtil.getRelativePath(templateRootDir, srcFile);
			if (CodgenUtil.isIgnoreTemplateProcess(srcFile, templateFile, includes, excludes)) {
				return;
			}

			if (isCopyBinaryFile && FileUtil.isBinaryFile(srcFile)) {
				String outputFilePath = processForOutputFilePath(filePathModel, templateFile);
				File outputFile = new File(getOutputRootDir(), outputFilePath);
				FileUtil.createNewFile(outputFile);
				LOGGER.info("copy binary file by extension from : {} => {}", srcFile, outputFile);
				IOUtils.copy(new FileInputStream(srcFile), new FileOutputStream(outputFile));
				return;
			}

			String outputFilePath = null;
			try {
				outputFilePath = processForOutputFilePath(filePathModel, templateFile);
				initCodgenControlProperties(srcFile);
				processTemplateForCodgenControl(templateModel, templateFile);

				if (mc.isIgnoreOutput()) {
					LOGGER.info("not generate by cc.isIgnoreOutput() = true on template : {}", templateFile);
					return;
				}

				if (null != outputFilePath) {
					generateNewFileOrInsertIntoFile(templateFile, outputFilePath, templateModel);
				}
			} catch (Exception e) {
				throw new IllegalArgumentException("generate oucur error,templateFile is : {} => %s cause : {}");
			}
		}

		private void generateNewFileOrInsertIntoFile(String templateFile, String outputFilePath,
				Map<String, Object> templateModel) throws IOException, TemplateException {
			Template template = getFreemarkerTemplate(templateFile);
			template.setOutputEncoding(mc.getOutputEncoding());

			File absoluteOutputFilePath = FileUtil.makeDir(mc.getOutRoot(), outputFilePath);
			if (absoluteOutputFilePath.exists()) {
				StringWriter newFileContentCollector = new StringWriter();
				if (CodgenUtil.isFoundInsertLocation(mc, template, templateModel, absoluteOutputFilePath,
						newFileContentCollector)) {
					LOGGER.info("[insert]\tgenerate content info : {}", outputFilePath);
					FileUtil.saveFile(absoluteOutputFilePath, newFileContentCollector.toString(),
							mc.getOutputEncoding());
					return;
				}
			}

			if (absoluteOutputFilePath.exists() && !mc.isOverride()) {
				LOGGER.info("[not generate]\tby cc.isOverride() = false and outputFile exist : {}", outputFilePath);
				return;
			}

			LOGGER.info("[generate]\ttemplate : {} => {}", templateFile, outputFilePath);
			FreemarkerUtil.processTemplate(template, templateModel, absoluteOutputFilePath, mc.getOutputEncoding());
		}

		public void executeDelete(File templateRootDir, Map<String, Object> templateModel, Map filePathModel,
				File srcFile) throws IOException, TemplateException {
			String templateFile = FileUtil.getRelativePath(templateRootDir, srcFile);
			if (CodgenUtil.isIgnoreTemplateProcess(srcFile, templateFile, includes, excludes)) {
				return;
			}
			initCodgenControlProperties(srcFile);
			mc.deleteGeneratedFile = true;
			processTemplateForCodgenControl(templateModel, templateFile);
			String outputFilePath = processForOutputFilePath(filePathModel, templateFile);
			LOGGER.info("[delete file]\tfile : {}", new File(mc.getOutRoot(), outputFilePath).getAbsolutePath());
			new File(mc.getOutRoot(), outputFilePath).delete();
		}

		/**
		 * 处理文件路径的变量变成输出路径
		 *
		 * @param filePathModel 文件路径可以引用的变量
		 * @param templateFile  模板文件
		 * @return String
		 * @throws IOException IO异常
		 */
		private String processForOutputFilePath(Map filePathModel, String templateFile) throws IOException {
			String outputFilePath = templateFile;
			// 删除兼容性的@testExpression
			int testExpressionIndex;
			if ((testExpressionIndex = templateFile.indexOf('@')) != -1) {
				outputFilePath = templateFile.substring(0, testExpressionIndex);
				String testExpressionKey = templateFile.substring(testExpressionIndex + 1);
				Object expressionValue = filePathModel.get(testExpressionKey);
				if (expressionValue == null) {
					LOGGER.error("test expression is null by key : [{}] on template : [{}]", testExpressionKey, templateFile);
					return null;
				}
				if (!"true".equals(String.valueOf(expressionValue))) {
					LOGGER.info("test expression '@{}' is false,template : {}", testExpressionKey, templateFile);
					return null;
				}
			}

			for (String removeExtension : removeExtensions.split(",")) {
				if (outputFilePath.endsWith(removeExtension)) {
					outputFilePath = outputFilePath.substring(0, outputFilePath.length() - removeExtension.length());
					break;
				}
			}

			Configuration configuration =
					CodgenUtil.newFreemarkerConfiguration(templateRootDirs, sourceEncoding, "/filepath/processor/");
			return FreemarkerUtil.processTemplateString(outputFilePath, filePathModel, configuration);
		}

		private void processTemplateForCodgenControl(Map<String, Object> templateModel, String templateFile)
				throws IOException, TemplateException {
			templateModel.put("mc", mc);
			Template template = getFreemarkerTemplate(templateFile);
			template.process(templateModel, new NullWriter());
		}

		private Template getFreemarkerTemplate(String templateFile) throws IOException {
			return CodgenUtil.newFreemarkerConfiguration(templateRootDirs, sourceEncoding, templateFile)
					.getTemplate(templateFile);
		}

		private void initCodgenControlProperties(File srcFile) {
			mc.setSourceFile(srcFile.getAbsolutePath());
			mc.setSourceFileName(srcFile.getName());
			mc.setSourceDir(srcFile.getParent());
			mc.setOutRoot(getOutputRootDir());
			mc.setOutputEncoding(outputEncoding);
			mc.setSourceEncoding(sourceEncoding);
			mc.setMergeLocation(GENERATOR_INSERT_LOCATION);
		}
	}

	public static class GeneratorModel {
		private Map<String, Object> filePathModel;
		private Map<String, Object> templateModel;

		public GeneratorModel(Map<String, Object> templateModel, Map<String, Object> filePathModel) {
			this.templateModel = templateModel;
			this.filePathModel = filePathModel;
		}

		public Map<String, Object> getFilePathModel() {
			return filePathModel;
		}

		public void setFilePathModel(Map<String, Object> filePathModel) {
			this.filePathModel = filePathModel;
		}

		public Map<String, Object> getTemplateModel() {
			return templateModel;
		}

		public void setTemplateModel(Map<String, Object> templateModel) {
			this.templateModel = templateModel;
		}
	}
}
