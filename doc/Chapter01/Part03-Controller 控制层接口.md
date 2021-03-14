## 3. Controller 控制层接口
### 3.1 首页
- `IndexController.java` ：控制层
```java
@Controller
public class IndexController extends BaseController {

    /**
     * 首页index
     */
    @GetMapping({"", "/", "/index", "/index.html"})
    public String index() {
        /**
         * 多条（post实体类、PostVo实体类）：分页集合results
         */
        //多条：selectPosts(分页信息、分类id、用户id、置顶、精选、排序)
        IPage<PostVo> results = postService
            .selectPosts(getPage(), null, null, null, null, "created");
        req.setAttribute("postVoDatas", results);

        /**
         * 分类（传入id） -> 渲染分类
         */
        //req：根据传入category表中当前页的id -> 【渲染】分类
        req.setAttribute("currentCategoryId", 0);

        return "index";
    }
}
```
- `PostMapper.xml` ：数据层实现，【多条（post 实体类、PostVo 实体类）】
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

### 3.2 导航栏
- `ContextStartup.java` ：配置类
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
- `PostMapper.xml` ：数据层实现，【一条（post 实体类、PostVo 实体类）】
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
- `CommentMapper.xml` ：数据层实现，【评论（comment 实体类）】
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