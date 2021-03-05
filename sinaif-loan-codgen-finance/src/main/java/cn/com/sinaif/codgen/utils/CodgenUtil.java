/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.utils;

import com.google.common.collect.Lists;

import freemarker.cache.FileTemplateLoader;
import freemarker.cache.MultiTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import java.util.Map;

import cn.com.sinaif.codgen.CodgenControl;

/**
 * 鼹鼠工具.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 下午3:00
 */
public final class CodgenUtil {
	private static final Logger LOGGER = LoggerFactory.getLogger(CodgenUtil.class);

	/**
	 * @param source     源字符串
	 * @param prefix     前缀
	 * @param ignoreCase 是否忽略大小写
	 * @return 移除前缀
	 */
	public static String removePrefix(String source, String prefix, boolean ignoreCase) {
		if (null == source) {
			return null;
		}
		if (null == prefix) {
			return source;
		}
		if (ignoreCase) {
			if (source.toLowerCase().startsWith(prefix.toLowerCase())) {
				return source.substring(prefix.length());
			}
		} else {
			if (source.startsWith(prefix)) {
				return source.substring(prefix.length());
			}
		}
		return source;
	}

	/**
	 * @param sourceName 原名
	 * @return 转换为帕斯卡拼写
	 */
	public static String makePascalCase(String sourceName) {
		String name = toUnderscoreName(sourceName);
		String[] strs = name.toLowerCase().split("_");
		String result = "";
		String preStr = "";
		for (String str : strs) {
			if (preStr.length() == 1) {
				result += str;
			} else {
				result += StringUtils.capitalize(str);
			}
			preStr = str;
		}
		return result;
	}

	/**
	 * @param sourceName 原名
	 * @return 小写并用下划线分隔单词
	 */
	public static String toUnderscoreName(String sourceName) {
		if (null == sourceName) {
			return null;
		}

		String filteredName = sourceName;
		if (filteredName.contains("_") && filteredName.equals(filteredName.toUpperCase())) {
			filteredName = filteredName.toLowerCase();
		}
		if (!filteredName.contains("_") && filteredName.equals(filteredName.toUpperCase())) {
			filteredName = filteredName.toLowerCase();
		}

		StringBuilder result = new StringBuilder();
		if (filteredName.length() > 0) {
			result.append(filteredName.substring(0, 1).toLowerCase());
			for (int i = 1; i < filteredName.length(); i++) {
				String preChart = filteredName.substring(i - 1, i);
				String c = filteredName.substring(i, i + 1);
				if (c.equals("_")) {
					result.append("_");
					continue;
				}
				if (preChart.equals("_")) {
					result.append(c.toLowerCase());
					continue;
				}
				if (c.matches("\\d")) {
					result.append(c);
				} else if (c.equals(c.toUpperCase())) {
					result.append("_");
					result.append(c.toLowerCase());
				} else {
					result.append(c);
				}
			}
		}
		return result.toString();
	}

	/**
	 * Count the occurrences of the substring in string s.
	 *
	 * @param str string to search in. Return 0 if this is null.
	 * @param sub string to search for. Return 0 if this is null.
	 */
	public static int countOccurrencesOf(String str, String sub) {
		if (str == null || sub == null || str.length() == 0 || sub.length() == 0) {
			return 0;
		}
		int count = 0;
		int pos = 0;
		int idx;
		while ((idx = str.indexOf(sub, pos)) != -1) {
			++count;
			pos = idx + sub.length();
		}
		return count;
	}

	/**
	 * @param srcFile      源文件
	 * @param templateFile 模版文件
	 * @param includes     处理目录
	 * @param excludes     不处理目录
	 * @return 是否忽略模版处理
	 */
	public static boolean isIgnoreTemplateProcess(File srcFile, String templateFile, String includes, String excludes) {
		if (srcFile.isDirectory() || srcFile.isHidden()) {
			return true;
		}
		if (templateFile.trim().equals("")) {
			return true;
		}
		if (srcFile.getName().toLowerCase().endsWith(".include")) {
			LOGGER.info("[skip]\tendsWith '.include' template: {}", templateFile);
			return true;
		}
		templateFile = templateFile.replace('\\', '/');
		String[] excludeArray = StringUtils.split(excludes, ',');
		if (null != excludeArray) {
			for (String exclude : excludeArray) {
				if (new AntPathMatcher().match(exclude.replace('\\', '/'), templateFile)) {
					return true;
				}
			}
		}
		if (null == includes) {
			return false;
		}
		for (String include : StringUtils.split(includes, ',')) {
			if (new AntPathMatcher().match(include.replace('\\', '/'), templateFile)) {
				return false;
			}
		}
		return true;
	}

	public static Configuration newFreemarkerConfiguration(List<File> templateRootDirs, String defaultEncoding,
			String templateName) throws IOException {
		Configuration conf = new Configuration();

		FileTemplateLoader[] templateLoaders = new FileTemplateLoader[templateRootDirs.size()];
		for (int i = 0, n = templateRootDirs.size(); i < n; i++) {
			templateLoaders[i] = new FileTemplateLoader(templateRootDirs.get(i));
		}
		MultiTemplateLoader multiTemplateLoader = new MultiTemplateLoader(templateLoaders);
		conf.setTemplateLoader(multiTemplateLoader);
		conf.setNumberFormat("###############");
		conf.setBooleanFormat("true,false");
		conf.setDefaultEncoding(defaultEncoding);
		List<String> autoIncludes = getParentPaths(templateName, "macro.include");
		List<String> availableAutoInclude = FreemarkerUtil.getAvailableAutoInclude(conf, autoIncludes);
		conf.setAutoIncludes(availableAutoInclude);
		//        log.debugf("set Freemarker.autoIncludes:%s for templateName:%s autoIncludes:%s", availableAutoInclude,
		//                templateName, autoIncludes);
		return conf;
	}

	public static boolean isFoundInsertLocation(CodgenControl cc, Template template, Map<String, Object> templateModel,
			File outputFile, StringWriter newFileContent) throws IOException, TemplateException {
		LineNumberReader reader = new LineNumberReader(new FileReader(outputFile));
		String line;
		boolean isFoundInsertLocation = false;

		PrintWriter writer = new PrintWriter(newFileContent);
		while ((line = reader.readLine()) != null) {
			writer.println(line);
			if (!isFoundInsertLocation && line.contains(cc.getMergeLocation())) {
				template.process(templateModel, writer);
				writer.println();
				isFoundInsertLocation = true;
			}
		}

		writer.close();
		reader.close();
		return isFoundInsertLocation;
	}

	public static String getJavaClassSimpleName(String clazz) {
		if (clazz == null) {
			return null;
		}
		if (clazz.lastIndexOf(".") >= 0) {
			return clazz.substring(clazz.lastIndexOf(".") + 1);
		}
		return clazz;
	}

	private static List<String> getParentPaths(String templateName, String suffix) {
		String array[] = StringUtils.split(templateName, "\\/");
		List<String> list = Lists.newArrayList();
		list.add(suffix);
		list.add(File.separator + suffix);
		String path = "";
		for (String a : array) {
			path = path + File.separator + a;
			list.add(path + File.separator + suffix);
		}
		return list;
	}

	private CodgenUtil() {
	}
}
