/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen;

/**
 * 鼹鼠控制器,用于模板中可以控制执行相关操作.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 上午8:29
 */
public class CodgenControl {

	boolean deleteGeneratedFile = false;
	private boolean isOverride = false;
	private boolean ignoreOutput = false;
	private boolean isMergeIfExists = true;
	private String mergeLocation;
	private String outRoot;
	private String outputEncoding;
	private String sourceFile;
	private String sourceDir;
	private String sourceFileName;
	private String sourceEncoding;

	public String getMergeLocation() {
		return mergeLocation;
	}

	public void setMergeLocation(String mergeLocation) {
		this.mergeLocation = mergeLocation;
	}

	public String getOutRoot() {
		return outRoot;
	}

	public void setOutRoot(String outRoot) {
		this.outRoot = outRoot;
	}

	public String getOutputEncoding() {
		return outputEncoding;
	}

	public void setOutputEncoding(String outputEncoding) {
		this.outputEncoding = outputEncoding;
	}

	public String getSourceDir() {
		return sourceDir;
	}

	public void setSourceDir(String sourceDir) {
		this.sourceDir = sourceDir;
	}

	public String getSourceEncoding() {
		return sourceEncoding;
	}

	public void setSourceEncoding(String sourceEncoding) {
		this.sourceEncoding = sourceEncoding;
	}

	public String getSourceFile() {
		return sourceFile;
	}

	public void setSourceFile(String sourceFile) {
		this.sourceFile = sourceFile;
	}

	public String getSourceFileName() {
		return sourceFileName;
	}

	public void setSourceFileName(String sourceFileName) {
		this.sourceFileName = sourceFileName;
	}

	public boolean isIgnoreOutput() {
		return ignoreOutput;
	}

	public void setIgnoreOutput(boolean ignoreOutput) {
		this.ignoreOutput = ignoreOutput;
	}

	public boolean isOverride() {
		return isOverride;
	}
}
