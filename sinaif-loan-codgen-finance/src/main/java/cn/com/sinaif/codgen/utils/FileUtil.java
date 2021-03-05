/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.utils;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.DefaultResourceLoader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Set;

import cn.com.sinaif.framework.core.utils.ExceptionUtils;

/**
 * 文件操作辅助类.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 下午3:48
 */
public final class FileUtil {

	private static List<String> ignoreList = Lists.newArrayList();
	private static Set<String> binaryExtensionsList = Sets.newHashSet();

	/**
	 * @param baseDir 基本目录
	 * @param file    查找文件
	 * @return 获取相对路径
	 */
	public static String getRelativePath(File baseDir, File file) {
		if (baseDir.equals(file)) {
			return "";
		}
		String fileAbsolutePath = file.getAbsolutePath();
		String result;
		if (baseDir.getParentFile() == null) {
			result = fileAbsolutePath.substring(baseDir.getAbsolutePath().length());
			return result;
		}
		result = fileAbsolutePath.substring(baseDir.getAbsolutePath().length() + 1);
		return result;
	}

	/**
	 * 创建新文件,父目录不存在,也一并创建
	 *
	 * @param f 文件对象
	 * @return false 如果文件已存在, true 创建成功
	 */
	public static boolean createNewFile(File f) throws IOException {
		if (null == f || f.exists()) {
			return false;
		}
		makeDir(f.getParentFile());
		return f.createNewFile();
	}

	/**
	 * 创建新文件,父目录不存在,也一并创建
	 *
	 * @param dir 目录对象
	 * @return false 如果文件已存在, true 创建成功
	 */
	public static boolean makeDir(File dir) {
		return !(null == dir || dir.exists()) && dir.mkdirs();
	}

	public static File makeDir(String dir, String file) {
		if (null == dir) {
			throw new IllegalArgumentException("dir must be not null");
		}
		File result = new File(dir, file);
		if (null != result.getParentFile()) {
			result.getParentFile().mkdirs();
		}
		return result;
	}

	public static List<File> searchAllNotIgnoreFile(File dir) throws IOException {
		List<File> arrayList = Lists.newArrayList();
		searchAllNotIgnoreFile(dir, arrayList);
		Collections.sort(arrayList, new Comparator<File>() {
			public int compare(File o1, File o2) {
				return o1.getAbsolutePath().compareTo(o2.getAbsolutePath());
			}
		});
		return arrayList;
	}

	public static void searchAllNotIgnoreFile(File dir, List<File> collector) throws IOException {
		collector.add(dir);
		if ((!dir.isHidden() && dir.isDirectory()) && !isIgnoreFile(dir)) {
			File[] subFiles = dir.listFiles();
			if (null == subFiles || subFiles.length <= 0) {
				return;
			}
			for (File subFile : subFiles) {
				searchAllNotIgnoreFile(subFile, collector);
			}
		}
	}

	/**
	 * 检查文件是否是二进制文件
	 *
	 * @param file 文件
	 * @return boolean
	 */
	public static boolean isBinaryFile(File file) {
		return !file.isDirectory() && isBinaryFile(file.getName());
	}

	public static void saveFile(File file, String content, String encoding) {
		saveFile(file, content, encoding, false);
	}

	private static void saveFile(File file, String content, String encoding, boolean append) {
		try {
			FileOutputStream output = new FileOutputStream(file, append);
			Writer writer = StringUtils.isBlank(encoding) ? new OutputStreamWriter(output) :
					new OutputStreamWriter(output, encoding);
			writer.write(content);
			writer.close();
		} catch (IOException e) {
			throw ExceptionUtils.unchecked(e);
		}
	}

	static {
		ignoreList.add(".svn");
		ignoreList.add("CVS");
		ignoreList.add(".cvsignore");
		ignoreList.add(".copyarea.db"); //ClearCase
		ignoreList.add("SCCS");
		ignoreList.add("vssver.scc");
		ignoreList.add(".DS_Store");
		ignoreList.add(".git");
		ignoreList.add(".gitignore");
	}

	static {
		loadBinaryExtensionsList("binary_file_list.txt");
		//        loadBinaryExtensionsList("com/kxai/mole/util/binary_file_list.txt");
	}

	private static boolean isBinaryFile(String name) {
		return StringUtils.isNotBlank(FilenameUtils.getExtension(name)) &&
				binaryExtensionsList.contains(FilenameUtils.getExtension(name).toLowerCase());
	}

	private static void loadBinaryExtensionsList(String resourceName) {
		try {
			InputStream input = new DefaultResourceLoader().getResource(resourceName).getInputStream();
			//            InputStream input = FileUtil.class.getClassLoader().getResourceAsStream(resourceName);
			binaryExtensionsList.addAll(IOUtils.readLines(new InputStreamReader(input)));
			input.close();
		} catch (Exception e) {
			//            e.printStackTrace();
		}
	}

	/**
	 * @param file 文件
	 * @return 是否忽略
	 */
	private static boolean isIgnoreFile(File file) {
		for (String anIgnoreList : ignoreList) {
			if (file.getName().equals(anIgnoreList)) {
				return true;
			}
		}
		return false;
	}

	public static void copyAndClose(InputStream in, OutputStream out) throws IOException {
		try {
			copy(in, out);
		} finally {
			close(in, out);
		}
	}

	private static void copy(InputStream in, OutputStream out) throws IOException {
		byte[] buf = new byte[8192];
		int n;
		while ((n = in.read(buf)) != -1) {
			out.write(buf, 0, n);
		}
	}

	private static void close(InputStream in, OutputStream out) {
		try {
			if (in != null) {
				in.close();
			}
		} catch (Exception ignored) {
		}
		try {
			if (out != null) {
				out.close();
			}
		} catch (Exception ignored) {
		}
	}

	private FileUtil() {
	}
}
