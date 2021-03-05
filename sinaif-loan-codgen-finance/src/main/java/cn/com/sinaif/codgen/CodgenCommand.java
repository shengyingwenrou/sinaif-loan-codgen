package cn.com.sinaif.codgen;

import freemarker.log.Logger;

import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.util.Scanner;

import cn.com.sinaif.codgen.config.CodgenConfig;

/**
 * 命令行工具类,可以直接运行
 *
 * Created by skysong(841676215@qq.com) on 2017/1/5.
 */
public class CodgenCommand {

	public static void main(String[] args) throws Exception {
		// 禁用 freemarker 日志
		Logger.selectLoggerLibrary(Logger.LIBRARY_NONE);

		startProcess();
	}

	private static void startProcess() throws Exception {
		Scanner sc = new Scanner(System.in);
		System.out.println("templateRootDir:" + new File(getTemplateRootDir()).getAbsolutePath());
		printUsages();
		while (sc.hasNextLine()) {
			try {
				processLine(sc);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				Thread.sleep(700);
				printUsages();
			}
		}
	}

	private static void processLine(Scanner sc) throws Exception {
		CodgenFacade facade = new CodgenFacade();
		String cmd = sc.next();
		if ("gen".equals(cmd)) {
			String[] args = nextArguments(sc);
			if (args.length == 0) {
				return;
			}
			facade.getCodgen().setIncludes(getIncludes(args, 1));
			facade.getCodgen().addTemplateRootDir(new File(getTemplateRootDir()));
			facade.generateByTable(args[0]);
			if (isWindowsOS()) {
				Runtime.getRuntime().exec("cmd.exe /c start " + CodgenConfig.getProperty("output_root", CodgenConfig.getOutputRootDir()));
			}
		} else if ("del".equals(cmd)) {
			String[] args = nextArguments(sc);
			if (args.length == 0) return;
			facade.getCodgen().setIncludes(getIncludes(args, 1));
			facade.getCodgen().addTemplateRootDir(new File(getTemplateRootDir()));
			facade.deleteByTable(args[0], getTemplateRootDir());
		} else if ("quit".equals(cmd)) {
			System.exit(0);
		} else {
			System.err.println(" [ERROR] unknown command:" + cmd);
		}
	}

	private static boolean isWindowsOS() {
		return System.getProperty("os.name").toLowerCase().contains("windows");
	}

	private static String getIncludes(String[] args, int indexOf) {
		String includes = null;
		if (args.length - 1 >= indexOf) {
			includes = args[indexOf];
		}
		if (includes == null) {
			return null;
		}
		return includes.contains("*") || includes.contains(",") ? includes : includes + "/**";
	}

	private static String[] nextArguments(Scanner sc) {
		return StringUtils.split(sc.nextLine(), " ");
	}

	private static String getTemplateRootDir() {
		return System.getProperty("templateRootDir", "template");
	}

	private static void printUsages() {
		System.out.println("使用说明:");
		System.out.println("\tgen table_name [include_path]: 根据表名生成文件");
		System.out.println("\tdel table_name [include_path]: 根据表名删除文件");
		System.out.println("\tgen * [include_path]: 检查数据库所有表并生成文件");
		System.out.println("\tdel * [include_path]: 检查数据库所有表并删除文件");
		System.out.println("\tquit : 退出");
		System.out.println("\t[include_path] subdir of templateRootDir,example: 1. dao  2. dao/**,service/**");
		System.out.print("请输入命令:");
	}
}
