```
1.更改resource下codgen.properties

非必须
base_package=cn.com.sinaif.loan(实际开发项目前缀包级)
project_name=core (实际开发项目正式包级)

必须配置
output_root=f:/codgen-output (本地输出映射文件目录 本地盘新建codgen-output目录) 
必须配置
template_dir=F://git_project/sinaif-loan-codgen/mybatis-codgen/templates （映射模板路径:git clone项目后 后更改成本地的地址）

必须配置（本地数据库信息）  
#jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/sky_dev?useSSL=false&amp;useUnicode=true&amp;characterEncoding=UTF-8
jdbc.username=root
jdbc.password=123456
jdbc.driver=com.mysql.jdbc.Driver


必须配置(自研发包暂不开源)
2.把resource下sinaif-fw-core-1.3.2.jar 包安装到本地私服无私服放进本地maven仓库 
路径目录、版本号如下 
       <dependency>
            <groupId>cn.com.sinaif</groupId>
            <artifactId>sinaif-fw-core</artifactId>
            <version>1.3.2</version>
        </dependency>
        
3.在CodgenMain类中如下位置 替换本地库中的表名ex:oss_user

   codgen.generateByTable(CodgenConfig.getProperty("template_dir",null),
				"oss_user");

4.	启动CodgenMain入口方法按模板生成生产文件	
				
```

