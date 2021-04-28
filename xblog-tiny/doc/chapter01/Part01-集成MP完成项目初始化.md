# 1. 集成 MP 完成项目初始化

```text
blog-tiny
│  pom.xml
│      
└─src
    └─main
        ├─java
        │  └─org
        │      └─org.myslayers
        │          │  Application.java
        │          │  CodeGenerator.java
        │          │  
        │          ├─common
        │          │  └─lang
        │          │          Result.java
        │          │          
        │          ├─config
        │          │      MyBatisPlusConfig.java
        │          │      
        │          ├─controller
        │          │      BaseController.java
        │          │      PostController.java
        │          │      UserController.java
        │          │      
        │          ├─entity
        │          │      BaseEntity.java
        │          │      Post.java
        │          │      User.java
        │          │      
        │          ├─mapper
        │          │      PostMapper.java
        │          │      UserMapper.java
        │          │      
        │          └─service
        │              │  PostService.java
        │              │  UserService.java
        │              │  
        │              └─impl
        │                      PostServiceImpl.java
        │                      UserServiceImpl.java
        │                      
        └─resources
            │  application-win.yml
            │  application.yml
            │  spy.properties
            │  
            ├─mapper
            │      PostMapper.xml
            │      UserMapper.xml
            │      
            ├─static
            └─templates
```

## 1.1 MP 环境

- `pom.xml` ：项目依赖，【】

```xml
<dependencies>
  <!--mp、druid、mysql、mp-generator（MyBatis-Plus 从 3.0.3后移除了代码生成器与模板引擎的默认依赖）、MP支持的SQL分析器、MP代码生成使用 freemarker 模板引擎-->
  <dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.2.0</version>
  </dependency>
  <!--        <dependency>-->
  <!--            <groupId>com.alibaba</groupId>-->
  <!--            <artifactId>druid-spring-boot-starter</artifactId>-->
  <!--            <version>1.1.10</version>-->
  <!--        </dependency>-->
  <dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <scope>runtime</scope>
  </dependency>
  <dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-generator</artifactId>
    <version>3.2.0</version>
  </dependency>
  <dependency>
    <groupId>p6spy</groupId>
    <artifactId>p6spy</artifactId>
    <version>3.8.6</version>
  </dependency>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-freemarker</artifactId>
  </dependency>
</dependencies>
```

- `application.yml` ：配置文件，【识别 Mapper 层】

```yaml
spring:
  datasource:
    #    driver-class-name: com.mysql.cj.jdbc.Driver
    #    url: jdbc:mysql://127.0.0.1:3306/xblog_tiny?useUnicode=true&useSSL=false&characterEncoding=utf8&serverTimezone=UTC
    driver-class-name: com.p6spy.engine.spy.P6SpyDriver
    url: jdbc:p6spy:mysql://127.0.0.1:3306/xblog_tiny?useUnicode=true&useSSL=false&characterEncoding=utf8&serverTimezone=UTC
    username: root
    password: 123456

server:
  port: 8080

mybatis-plus:
  mapper-locations: classpath*:/mapper/**Mapper.xml
```

- `spy.properties` ：配置文件，【p6spy 组件对应的 spy.properties 配置】

```properties
#3.2.1以下使用或者不配置
module.log=com.p6spy.engine.logging.P6LogFactory,com.p6spy.engine.outage.P6OutageFactory
# 自定义日志打印
logMessageFormat=com.baomidou.mybatisplus.extension.p6spy.P6SpyLogger
#日志输出到控制台
appender=com.baomidou.mybatisplus.extension.p6spy.StdoutLogger
# 使用日志系统记录 sql
#appender=com.p6spy.engine.spy.appender.Slf4JLogger
# 设置 p6spy driver 代理
deregisterdrivers=true
# 取消JDBC URL前缀
useprefix=true
# 配置记录 Log 例外,可去掉的结果集有error,info,batch,debug,statement,commit,rollback,result,resultset.
excludecategories=info,debug,result,batch,resultset
# 日期格式
dateformat=yyyy-MM-dd HH:mm:ss
# 实际驱动可多个
#driverlist=org.h2.Driver
# 是否开启慢SQL记录
outagedetection=true
# 慢SQL记录标准 2 秒
outagedetectioninterval=2
```

## 1.2 MP 代码生成器

- CodeGenerator.java：代码生成器，【配置 MySQL 相关信息，比如表名、用户名、密码】

```java
// 演示例子，执行 main 方法控制台输入模块表名回车自动生成对应项目目录中
public class CodeGenerator {

    /**
     * <p>
     * 读取控制台内容
     * </p>
     */
    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder help = new StringBuilder();
        help.append("请输入" + tip + "：");
        System.out.println(help.toString());
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            if (StringUtils.isNotEmpty(ipt)) {
                return ipt;
            }
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }

    public static void main(String[] args) {
        // 代码生成器
        AutoGenerator mpg = new AutoGenerator();

        // 全局配置
        GlobalConfig gc = new GlobalConfig();
        final String projectPath = System.getProperty("user.dir");
        gc.setOutputDir(projectPath + "/src/main/java");
        gc.setAuthor("org/myslayers");
        gc.setOpen(false);
        // gc.setSwagger2(true); 实体属性 Swagger2 注解
        gc.setServiceName("%sService");
        mpg.setGlobalConfig(gc);

        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setUrl(
            "jdbc:mysql://localhost:3306/xblog_tiny?useUnicode=true&useSSL=false&characterEncoding=utf8&serverTimezone=UTC");
        // dsc.setSchemaName("public");
        dsc.setDriverName("com.mysql.cj.jdbc.Driver");
        dsc.setUsername("root");
        dsc.setPassword("123456");
        mpg.setDataSource(dsc);

        // 包配置
        PackageConfig pc = new PackageConfig();
        pc.setModuleName(null);
        pc.setParent("org.org.myslayers");
        mpg.setPackageInfo(pc);

        // 自定义配置
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {
                // to do nothing
            }
        };

        // 如果模板引擎是 freemarker
        String templatePath = "/templates/mapper.xml.ftl";
        // 如果模板引擎是 velocity
        // String templatePath = "/templates/mapper.xml.vm";

        // 自定义输出配置
        List<FileOutConfig> focList = new ArrayList<>();
        // 自定义配置会被优先输出
        focList.add(new FileOutConfig(templatePath) {
            @Override
            public String outputFile(TableInfo tableInfo) {
                // 自定义输出文件名 ， 如果你 Entity 设置了前后缀、此处注意 xml 的名称会跟着发生变化！！
                return projectPath + "/src/main/resources/mapper/"
                    + "/" + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
            }
        });

        cfg.setFileOutConfigList(focList);
        mpg.setCfg(cfg);

        // 配置模板
        TemplateConfig templateConfig = new TemplateConfig();

        // 配置自定义输出模板
        //指定自定义模板路径，注意不要带上.ftl/.vm, 会根据使用的模板引擎自动识别
        // templateConfig.setEntity("templates/entity2.java");
        // templateConfig.setService();
        // templateConfig.setController();

        templateConfig.setXml(null);
        mpg.setTemplate(templateConfig);

        // 策略配置
        StrategyConfig strategy = new StrategyConfig();
        strategy.setNaming(NamingStrategy.underline_to_camel);
        strategy.setColumnNaming(NamingStrategy.underline_to_camel);
        // 你自己的父类实体,没有就不用设置!
        strategy.setSuperEntityClass("org.org.myslayers.entity.BaseEntity");
        strategy.setEntityLombokModel(true);
        strategy.setRestControllerStyle(true);
        // 你自己的父类控制器,没有就不用设置!
        strategy.setSuperControllerClass("org.org.myslayers.controller.BaseController");
        strategy.setInclude(scanner("表名，多个英文逗号分割").split(","));
        strategy.setSuperEntityColumns("id", "created", "modified");
        strategy.setControllerMappingHyphenStyle(true);
        strategy.setTablePrefix("m_");
        mpg.setStrategy(strategy);
        mpg.setTemplateEngine(new FreemarkerTemplateEngine());
        mpg.execute();
    }
}
```

## 1.3 MP 分页

- `MyBatisPlusConfig.java` ：配置类

```java
/**
 * MP配置类
 */
@Configuration
@EnableTransactionManagement
@MapperScan("org.org.myslayers.mapper")
public class MyBatisPlusConfig {

    /**
     * 分页插件
     */
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
        return paginationInterceptor;
    }
}
```

## 1.4 前后端分离，统一封装返回结果

- `Result.java` ：实体类，【前后端分离，统一封装返回结果】

```java
/**
 * 统一封装返回结果
 */
@Data
public class Result implements Serializable {

    // 操作状态：200代表成功，非200为失败/异常
    private int code;

    // 携带msg
    private String msg;

    // 携带data
    private Object data;

    public static Result success(int code, String msg, Object data) {
        Result result = new Result();
        result.code = code;
        result.msg = msg;
        result.data = data;
        return result;
    }

    public static Result success(String msg) {
        return Result.success(200, msg, null);
    }

    public static Result success(String msg, Object data) {
        return Result.success(200, msg, data);
    }

    public static Result fail(int code, String msg, Object data) {
        Result result = new Result();
        result.code = code;
        result.msg = msg;
        result.data = data;
        return result;
    }

    public static Result fail(String msg) {
        return fail(500, msg, null);
    }

    public static Result fail(String msg, Object data) {
        return fail(500, msg, data);
    }
}
```
