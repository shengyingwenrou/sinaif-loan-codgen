package cn.com.sinaif.codgen;

import freemarker.template.Configuration;
import freemarker.template.Template;

import org.apache.commons.io.output.FileWriterWithEncoding;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import cn.com.sinaif.codgen.config.CodgenConfig;

public class CodgenTransCodeUtil {

    private static Logger log= LoggerFactory.getLogger(CodgenTransCodeUtil.class);


    public static void main(String[] args) throws IOException{
        util();
    }

    public static void util() throws IOException{

        Map data=new HashMap<>();
        data.putAll(CodgenConfig.getCodgen());

        //加载framemarker配置
        Configuration cfg = new Configuration();

        //设置framemarker加载的根路径
       // cfg.setClassForTemplateLoading(CodgenTransCodeUtil.class,(String)data.get("extra_template_dir"));//ftl的基本路径

        cfg.setDirectoryForTemplateLoading(new File("classpath:/config"));

       // cfg.setClassForTemplateLoading(CodgenTransCodeUtil.class,"/config");

        //设置编码
        cfg.setEncoding(Locale.getDefault(), "UTF-8");

        //生成文件的路径
        File f = new File((String)data.get("extra_out_template_dir"));
        Writer out = null;
        try {

            //获取模板
            Template t = cfg.getTemplate("req.java.ftl");

            //构建缓存字符输出流，并指定编码格式
            out = new BufferedWriter(new FileWriterWithEncoding(f,"UTF-8"));

            //赋值
            t.process(data, out);

        } catch (Exception e) {
            // TODO Auto-generated catch block
            log.error("execute framemarker error");
            e.printStackTrace();

            //释放资源
        }finally{
            if(out != null){
                try {
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }


}
