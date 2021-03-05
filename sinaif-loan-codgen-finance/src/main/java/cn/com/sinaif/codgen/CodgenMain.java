/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen;

import java.io.File;

import cn.com.sinaif.codgen.config.CodgenConfig;

/**
 * 鼹鼠启动.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 上午9:10
 */
public class CodgenMain {

	public static void main(String[] args) throws Exception {

		CodgenFacade codgen = new CodgenFacade();

		// 打印数据库中的表名
		codgen.printAllTableNames();

		// 删除输出目录
		 codgen.deleteOutputRootDir();

		// 通过数据库表生成文件,template为模板的根目录(单表生成)
		// codgen.generateByTable("D:\\Workspace\\svn\\magicwifi-codgen\\templates", "oss_user", "oss_role");

		codgen.generateByTable(CodgenConfig.getProperty("template_dir",null),
				"xyfq");

		// 自动搜索数据库中的所有表并生成文件,template为模板的根目录
//		codgen.generateByAllTable("D:\\Workspace\\svn\\magicwifi-codgen\\templates");
		// 删除生成的文件
//		        codgen.deleteByTable("t_device", "E:\\WorkSpace\\svn\\magicwifi-codgen\\templates");

		String outputDir = CodgenConfig.getOutputRootDir();
		if (new File(outputDir).exists()) {
			// 打开文件夹
			Runtime.getRuntime().exec("cmd.exe /c start " + CodgenConfig.getProperty("output_root", outputDir));
		}
	}
}
