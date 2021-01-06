# 一、搭建 Springboot 脚手架_首页内容填充

## 1. 博客页面划分
### 1.1 导航栏（header.ftl）
- 图标
- 登录/注册

### 1.2 分类（header-panel.ftl）
- 首页
- 提问、分享、讨论、建议

### 1.3 左侧md8（left.ftl）

### 1.4 右侧md4（right.ftl）

### 1.5 宏（common.ftl）
- 分页：`<@paging XXX></@paging>`
- 一条数据posting：`<@plisting XXX></@plisting>`

### 1.6 布局（layout.ftl）
- 宏：macro定义脚本，名为layout，参数为title
- 划分：header.ftl、<#nested/>、footer.ftl


## 2. MyBatis-Plus 的使用
### 2.1 代码生成器
- 项目依赖：mybatis-plus-boot-starter、mysql-connector-java、mybatis-plus-generator、druid-spring-boot-starter、spring-boot-starter-freemarker

### 2.2 分页插件

- 配置类，SpringBoot的使用方式

```java
@Configuration
@EnableTransactionManagement
@MapperScan("org.myslayers.mapper")
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

### 2.3 执行 SQL 分析打印

- 该功能依赖 p6spy 组件，其中 datasource 、freemarker、mybatis-plus的配置如下：

```yaml
spring:
  datasource:
    #    driver-class-name: com.mysql.cj.jdbc.Driver
    driver-class-name: com.p6spy.engine.spy.P6SpyDriver
    url: jdbc:p6spy:mysql://127.0.0.1:3306/xblog?useUnicode=true&useSSL=false&characterEncoding=utf8&serverTimezone=UTC
    username: root
    password: 4023615
  freemarker:
    settings:
      classic_compatible: true
      datetime_format: yyyy-MM-dd HH:mm
      number_format: 0.##

mybatis-plus:
  mapper-locations: classpath*:/mapper/**Mapper.xml
```
- p6spy 组件对应的 spy.properties 配置如下：
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

### 2.4 条件构造器

- AbstractWrapper、QueryWrapper、UpdateWrapper

```java
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements PostService {
    @Autowired
    PostMapper postMapper;

    @Override
    public IPage<PostVo> selectPosts(Page page, Long categoryId, Long userId, Integer level, Boolean recommend, String order) {
        if (level == null) level = -1;
        QueryWrapper wrapper = new QueryWrapper<Post>()
                .eq(categoryId != null, "category_id", categoryId)
                .eq(userId != null, "user_id", userId)
                .eq(level == 0, "level", 0)
                .gt(level > 0, "level", 0)
                .orderByDesc(order != null, order);
        return postMapper.selectPosts(page, wrapper);
    }

    @Override
    public PostVo selectOnePost(QueryWrapper<Post> warapper) {
        return postMapper.selectOnePost(warapper);
    }
}
```


## 3. Controller 控制层接口
### 3.1 indexController
- 渲染分类：首页index -> 分类（传入id） -> 渲染分类 -> currentCategoryId
- 接口数据：首页index -> 多条（post实体类、PostVo实体类） -> postVoDatas
- SQL语句展示：多条（post实体类、PostVo实体类）
```xml
<select id="selectPosts" resultType="org.myslayers.vo.PostVo">
    SELECT  p.id,
            p.title,
            p.content,
            p.edit_mode,
            p.category_id,
            p.user_id,
            p.vote_up,
            p.vote_down,
            p.view_count,
            p.comment_count,
            p.recommend,
            p.level,
            p.status,
            p.created,
            p.modified,

            u.id AS authorId,
            u.username AS authorName,
            u.avatar AS authorAvatar,

            c.id AS categoryId,
            c.name AS categoryName
    FROM
        m_post p
    LEFT JOIN m_user u ON p.user_id = u.id
    LEFT JOIN m_category c ON p.category_id = c.id
    ${ew.customSqlSegment}
</select>
```

### 3.2 PostController
- 渲染分类：分类category -> 分类（传入id）-> 渲染分类 -> currentCategoryId
- 解决数据：分类category -> <@details categoryId=currentCategoryId pn=pn size=2>无法传入参数pn的方法：让pn直接从req请求中获取 -> 作为传入posts方法的参数
- 接口数据：详情detail -> 一条（post实体类、PostVo实体类） -> postVoData
- 接口数据：详情detail -> 评论（comment实体类） -> commentVoDatas
- 配置类：项目启动时，会同时调用该run方法：提前加载导航栏中的“提问、分享、讨论、建议”，并将其list放入servletContext上下文对象：
```java
@Component
public class ContextStartup implements ApplicationRunner, ServletContextAware {

    @Autowired
    CategoryService categoryService;

    ServletContext servletContext;

    /**
     * 项目启动时，会同时调用该run方法：提前加载导航栏中的“提问、分享、讨论、建议”，并将其list放入servletContext上下文对象
     */
    @Override
    public void run(ApplicationArguments args) throws Exception {
        List<Category> categories = categoryService.list(new QueryWrapper<Category>()
                .eq("status", 0)
        );
        servletContext.setAttribute("categorys", categories);
    }

    /**
     * servletContext上下文对象
     */
    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}
```
- SQL语句展示：一条（post实体类、PostVo实体类）
```xml
<select id="selectOnePost" resultType="org.myslayers.vo.PostVo">
    SELECT p.id,
           p.title,
           p.content,
           p.edit_mode,
           p.category_id,
           p.user_id,
           p.vote_up,
           p.vote_down,
           p.view_count,
           p.comment_count,
           p.recommend,
           p.level,
           p.status,
           p.created,
           p.modified,

           u.id       AS authorId,
           u.username AS authorName,
           u.avatar   AS authorAvatar,

           c.id       AS categoryId,
           c.name     AS categoryName
    FROM
        m_post p
    LEFT JOIN m_user u ON p.user_id = u.id
    LEFT JOIN m_category c ON p.category_id = c.id
    ${ew.customSqlSegment}
</select>
```
- SQL语句展示：评论（comment实体类）
```xml
<select id="selectComments" resultType="org.myslayers.vo.CommentVo">
    SELECT c.id,
           c.content,
           c.parent_id,
           c.post_id,
           c.user_id,
           c.vote_up,
           c.vote_down,
           c.level,
           c.status,
           c.created,
           c.modified,

           u.id       AS authorId,
           u.username AS authorName,
           u.avatar   AS authorAvatar
    FROM m_comment c
             LEFT JOIN m_user u ON c.user_id = u.id

    ${ew.customSqlSegment}
</select>
```


## 4. 自定义 Freemaker 标签
### 4.1 实现TemplateDirectiveModel接口，重写 excute 方法
```java
public interface TemplateDirectiveModel extends TemplateModel {
  public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException;
}
```
上述方法的参数说明：
- env：系统环境变量，通常用它来输出相关内容，如 Writer out = env.getOut()。
- params：自定义标签传过来的对象，其 key = 自定义标签的参数名，value 值是 TemplateModel 类型，而 TemplateModel 是一个接口类型，通常我们都使用 TemplateScalarModel 接口来替代它获取一个 String 值，如 TemplateScalarModel.getAsString(); 当然还有其它常用的替代接口，如 TemplateNumberModel 获取 number，TemplateHashModel 等。
- loopVars 循环替代变量。
- body 用于处理自定义标签中的内容，如 <@myDirective> 将要被处理的内容；当标签是<@myDirective /> 格式时，body=null。

### 4.2 采用 mblog 项目对该 TemplateDirectiveModel 接口进行封装
- 实现 TemplateDirectiveModel 接口较为复杂，故我们可以直接使用 mblog 项目中已经封装好的类：org.myslayers.common.templates.DirectiveHandler、TemplateDirective、TemplateModelUtils；
- 其中，我们只需要重写 TemplateDirective 类中的 getName（）和 excute（DirectiveHandler handler），本次使用 `PostsTemplate`、`TimeAgoMethod` 进行开发使用；
- 最后，使用 `FreemarkerConfig` 类在 Springboot 中对 PostsTemplate、TimeAgoMethod 进行标签的声明`<timeAgo></timeAgo>`、`<details></details>`。

