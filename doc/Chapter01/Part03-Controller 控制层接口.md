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