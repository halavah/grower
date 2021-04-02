# 3. Controller 控制层接口

```text
blog
├─src
│  └─main
│      ├─java
│      │  └─org
│      │      └─myslayers
│      │          ├─config
│      │          │      ContextStartup.java
│      │          │      
│      │          ├─controller
│      │          │      BaseController.java
│      │          │      IndexController.java 
│      │          │      PostController.java 
│      │          │ 
│      │          ├─service
│      │          │  │  postService.java
│      │          │  │  
│      │          │  └─impl
│      │          │         postServiceImpl.java
│      │          
│      └─resources
│          ├─templates
│          │  │  index.ftl
│          │  │
│          │  ├─inc
│          │  │     header-panel.ftl
│          │  │ 
│          │  └─post
│          │        category.ftl
│          │        detail.ftl
```

### 3.1 首页

* `IndexController.java` ：控制层

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
        IPage<PostVo> results = postService.selectPosts(getPage(), null, null, null, null, "created");
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

* `index.ftl` ：模板引擎

  \`\`\`injectedfreemarker

  &lt;\#--宏layout.ftl（导航栏 + 页脚）--&gt;

  &lt;\#include "/inc/layout.ftl"/&gt;

&lt;\#--【三、填充（导航栏 + 页脚）】--&gt; &lt;@layout "首页"&gt;

&lt;\#--【二、分类】--&gt; &lt;\#include "/inc/header-panel.ftl"/&gt;

&lt;\#--【三、左侧md8 + 右侧md8】--&gt;  

```text
  <#--1.左侧md8-->
  <div class="layui-col-md8">

    <#--1.1 fly-panel-->
    <div class="fly-panel">
      <#--1.1.1 fly-panel-title-->
      <div class="fly-panel-title fly-filter">
        <a>置顶</a>
      </div>
      <#--1.1.2 消息列表-->
      <ul class="fly-list">
          <@details size=2 level=1>
          <#--1.1.2.1 消息列表-->
              <#list results.records as post>
                  <@plisting post></@plisting>
              </#list>
          </@details>
      </ul>
    </div>

    <#--1.2 fly-panel-->
    <div class="fly-panel" style="margin-bottom: 0;">
      <#--1.2.1 fly-panel-title-->
      <div class="fly-panel-title fly-filter">
        <a href="" class="layui-this">综合</a>
        <span class="fly-mid"></span>
        <a href="">未结</a>
        <span class="fly-mid"></span>
        <a href="">已结</a>
        <span class="fly-mid"></span>
        <a href="">精华</a>
        <span class="fly-filter-right layui-hide-xs">
          <a href="" class="layui-this">按最新</a>
          <span class="fly-mid"></span>
          <a href="">按热议</a>
        </span>
      </div>

      <#--1.2.2 消息列表-->
      <div class="fly-list">
          <#list postVoDatas.records as post>
              <@plisting post></@plisting>
          </#list>
      </div>

      <#--1.2.3 分页条-->
      <@paging postVoDatas></@paging>
    </div>
  </div>

    <#--2.右侧md4-->
    <#include "/inc/right.ftl"/>
</div>
```

&lt;/div&gt; [/@layout](mailto:/@layout)

```text
### 3.2 导航栏、文章分类
- `ContextStartup.java` ：配置类，【向 `header-panel.ftl` 传入 `categorys`】
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

* `PostController.java` ：控制类，【向 `header-panel.ftl` 传入 `currentCategoryId`】

  ```java
  @Controller
  public class PostController extends BaseController {
    /**
     * 分类category
     */
    @GetMapping("/category/{id:\\d*}")
    public String category(@PathVariable(name = "id") long id) {
        /**
         * 分类（传入id）-> 渲染分类
         */
        //req：根据传入category表中当前页的id -> 【渲染】分类
        req.setAttribute("currentCategoryId", id);

        //req：解决使用<@details categoryId=currentCategoryId pn=pn size=2>时，无法传入参数pn的方法：让pn直接从req请求中获取 -> 作为传入posts方法的参数
        req.setAttribute("pn", ServletRequestUtils.getIntParameter(req, "pn", 1));

        return "post/category";
    }
  }
  ```

* `header-panel.ftl` ：模板引擎

  ```text
  <#--【二、分类】-->
  <div class="fly-panel fly-column">
  <div class="layui-container">
    <ul class="layui-clear">
      <!-- 首页 -->
      <li class="${(0 == currentCategoryId)?string('layui-hide-xs layui-this', '')}"><a href="/">首页</a></li>
        <#--提问、分享、讨论、建议-->
        <#list categorys as item>
          <li class="${(item.id == currentCategoryId)?string('layui-hide-xs layui-this', '')}">
            <a href="/category/${item.id}">${item.name}</a>
          </li>
        </#list>
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li>
      <!-- 用户登入后显示 -->
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="/user/index#index">我发表的贴</a></li>
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="/user/index#collection">我收藏的贴</a></li>
    </ul>

    <div class="fly-column-right layui-hide-xs">
      <span class="fly-search"><i class="layui-icon"></i></span>
      <a href="post/edit" class="layui-btn">发表新帖</a>
    </div>
    <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;">
      <a href="post/edit" class="layui-btn">发表新帖</a>
    </div>
  </div>
  </div>
  ```

* `category.ftl` ：模板引擎

  \`\`\`injectedfreemarker

  &lt;\#--宏layout.ftl（导航栏 + 页脚）--&gt;

  &lt;\#include "/inc/layout.ftl"/&gt;

&lt;\#--【三、填充（导航栏 + 页脚）】--&gt; &lt;@layout "博客分类"&gt;

&lt;\#--【二、分类】--&gt; &lt;\#include "/inc/header-panel.ftl"/&gt;

&lt;\#--【三、左侧md8 + 右侧md8】--&gt;  

```text
  <#--1.左侧md8-->
  <div class="layui-col-md8">
    <#--1.2 fly-panel-->
    <div class="fly-panel" style="margin-bottom: 0;">
      <#--1.2.1 fly-panel-title-->
      <div class="fly-panel-title fly-filter">
        <a href="" class="layui-this">综合</a>
        <span class="fly-mid"></span>
        <a href="">未结</a>
        <span class="fly-mid"></span>
        <a href="">已结</a>
        <span class="fly-mid"></span>
        <a href="">精华</a>
        <span class="fly-filter-right layui-hide-xs">
          <a href="" class="layui-this">按最新</a>
          <span class="fly-mid"></span>
          <a href="">按热议</a>
        </span>
      </div>
        <#--1.2.2 消息列表-->
        <@details categoryId=currentCategoryId pn=pn size=2>
          <ul class="fly-list">
            <#list results.records as post>
              <@plisting post></@plisting>
            </#list>
          </ul>
            <#--1.2.3 分页条-->
            <@paging results></@paging>
        </@details>
    </div>
  </div>

  <#--2.右侧md4-->
  <#include "/inc/right.ftl"/>
</div>
```

&lt;/div&gt;

  
    layui.cache.page = 'jie';  
   \`\`\` \#\#\# 3.3 文章详情 - \`PostController.java\` ：控制层，【查看】文章、【查看】评论 \`\`\`java @Controller public class PostController extends BaseController { /\*\* \* 详情detail：【查看】文章、【查看】评论 \*/ @GetMapping\("/post/{id:\\d\*}"\) public String detail\(@PathVariable\(name = "id"\) long id\) { /\*\* \* 一条（post实体类、PostVo实体类） \*/ //一条：selectOnePost（表 文章id = 传 文章id），因为Mapper中select信息中，id过多引起歧义，故采用p.id PostVo postVo = postService.selectOnePost\(new QueryWrapper\(\).eq\("p.id", id\)\); //req：PostVo实体类 -&gt; CategoryId属性 req.setAttribute\("currentCategoryId", postVo.getCategoryId\(\)\); //req：PostVo实体类（回调） req.setAttribute\("post", postVo\); /\*\* \* 评论（comment实体类） \*/ //评论：page\(分页信息、文章id、用户id、排序\) IPage results = commentService.selectComments\(getPage\(\), postVo.getId\(\), null, "created"\); //req：CommentVo分页集合 req.setAttribute\("pageData", results\); /\*\* \* 文章阅读【缓存实现访问量】：减少访问数据库的次数，存在一个BUG，只与点击链接的次数相关，没有与用户的id进行绑定 \*/ postService.putViewCount\(postVo\); return "post/detail"; } } \`\`\` - \`detail.ftl\` ：模板引擎 \`\`\`injectedfreemarker

## ${post.title}

 ${post.categoryName}置顶精帖 删除 删除置顶取消置顶加精取消加精 [${post.commentCount}](part03controller-kong-zhi-ceng-jie-kou.md#comment) ${post.viewCount} [![${post.authorName}](https://github.com/halavah/blog/tree/e187ac293ef858ecb2d8989e77683cc96527d0c5/doc/Chapter01/$%7Bpost.authorAvatar%7D)](https://github.com/halavah/blog/tree/e187ac293ef858ecb2d8989e77683cc96527d0c5/user/$%7Bpost.authorId%7D) [${post.authorName}](https://github.com/halavah/blog/tree/e187ac293ef858ecb2d8989e77683cc96527d0c5/user/$%7Bpost.authorId%7D) ${timeAgo\(post.created\)} [编辑此贴](https://github.com/halavah/blog/tree/e187ac293ef858ecb2d8989e77683cc96527d0c5/post/edit?id=$%7Bpost.id%7D) ${post.content}回帖

*  [![${comment.authorName}](https://github.com/halavah/blog/tree/e187ac293ef858ecb2d8989e77683cc96527d0c5/doc/Chapter01/$%7Bcomment.authorAvatar%7D)](https://github.com/halavah/blog/tree/e187ac293ef858ecb2d8989e77683cc96527d0c5/user/$%7Bpost.authorId%7D) [${comment.authorName}](https://github.com/halavah/blog/tree/e187ac293ef858ecb2d8989e77683cc96527d0c5/user/$%7Bcomment.authorId%7D) \(楼主\) ${timeAgo\(comment.created\)} ${comment.content} _${comment.voteUp}_ 回复 删除

  提交回复  
    layui.cache.page = 'jie';  
  

[/@layout](mailto:/@layout) \`\`\`

