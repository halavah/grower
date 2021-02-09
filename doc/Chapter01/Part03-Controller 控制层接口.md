## 3. Controller 控制层接口
### 3.1 indexController
- 渲染分类：首页 index -> 分类（传入 id） -> 渲染分类 -> currentCategoryId
- 接口数据：首页 index -> 多条（post 实体类、PostVo 实体类） -> postVoDatas
- SQL 语句展示：多条（post 实体类、PostVo 实体类）
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
- 渲染分类：分类 category -> 分类（传入 id）-> 渲染分类 -> currentCategoryId
- 解决数据：分类 category -> <@details categoryId=currentCategoryId pn=pn size=2>无法传入参数 pn 的方法：让 pn 直接从 req 请求中获取 -> 作为传入 posts 方法的参数
- 接口数据：详情 detail -> 一条（post 实体类、PostVo 实体类） -> postVoData
- 接口数据：详情 detail -> 评论（comment 实体类） -> commentVoDatas
- 配置类：项目启动时，会同时调用该 run 方法：提前加载导航栏中的“提问、分享、讨论、建议”，并将其 list 放入 servletContext 上下文对象：
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
- SQL 语句展示：一条（post 实体类、PostVo 实体类）
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
- SQL 语句展示：评论（comment 实体类）
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