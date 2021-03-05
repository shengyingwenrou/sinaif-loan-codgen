/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.exception;

import com.google.common.collect.Lists;

import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;

/**
 * 鼹鼠异常.
 *
 * User: skysong(841676215@qq.com) Date: 13-11-18 Time: 上午11:47
 */
public class CodgenException extends RuntimeException {

	private List<Exception> exceptions = Lists.newArrayList();

	public CodgenException() {
		super();
	}

	public CodgenException(String message) {
		super(message);
	}

	public CodgenException(String message, Throwable cause) {
		super(message, cause);
	}

	public CodgenException(Throwable cause) {
		super(cause);
	}

	public List<Exception> getExceptions() {
		return exceptions;
	}

	public CodgenException add(Exception e) {
		exceptions.add(e);
		return this;
	}

	public CodgenException addAll(List<Exception> excetpions) {
		exceptions.addAll(excetpions);
		return this;
	}

	@Override
	public void printStackTrace() {
		printStackTrace(System.err);
	}

	@Override
	public void printStackTrace(PrintStream s) {
		s.println("CodgenException:" + getMessage());
		for (Exception e : exceptions) {
			e.printStackTrace(s);
		}
	}

	@Override
	public void printStackTrace(PrintWriter s) {
		s.println("CodgenException:" + getMessage());
		for (Exception e : exceptions) {
			e.printStackTrace(s);
		}
	}

	public void setExceptions(List<Exception> exceptions) {
		if (exceptions == null) {
			throw new NullPointerException("'exceptions' must be not null");
		}
		this.exceptions = exceptions;
	}

	public String toString() {
		StringWriter out = new StringWriter();
		for (Exception e : exceptions) {
			out.append(e.toString()).append("\n");
		}
		return out.toString();
	}
}
