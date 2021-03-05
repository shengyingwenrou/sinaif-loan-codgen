/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.codgen.utils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.util.*;

/**
 * Freemarker工具类.
 * User: skysong(841676215@qq.com)
 * Date: 13-11-18
 * Time: 上午9:45
 */
public final class FreemarkerUtil {

    public static List<String> getAvailableAutoInclude(Configuration configuration, List<String> autoIncludes) {
        List<String> results = new ArrayList<>();
        for (String autoInclude : autoIncludes) {
            try {
                Template t = new Template("__auto_include_test__", new StringReader("1"), configuration);
                configuration.setAutoIncludes(Collections.singletonList(autoInclude));
                t.process(new HashMap(), new StringWriter());
                results.add(autoInclude);
            } catch (Exception ignored) {
            }
        }
        return results;
    }

    public static void processTemplate(Template template, Map model, File outputFile, String encoding)
            throws IOException, TemplateException {
        Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outputFile), encoding));
        template.process(model, out);
        out.close();
    }

    public static String processTemplateString(String templateString, Map model, Configuration configuration) {
        StringWriter out = new StringWriter();
        try {
            Template template = new Template("templateString...", new StringReader(templateString), configuration);
            template.process(model, out);
            return out.toString();
        } catch (Exception e) {
            throw new IllegalStateException("cannot process templateString:" + templateString + " cause:" + e, e);
        }
    }

    private FreemarkerUtil() {
    }
}
