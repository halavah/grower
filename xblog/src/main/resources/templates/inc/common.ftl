<#--宏：分页-->
<#macro paging pageData>

 <div style="text-align: center">
  <#--待渲染的div块（laypage-main）-->
  <div id="laypage-main"></div>

  <#--Script渲染div块-->
  <script src="/res/layui/layui.js"></script>
  <script>
    layui.use('laypage', function () {
      var laypage = layui.laypage;

      //执行一个laypage实例
      laypage.render({
        elem: 'laypage-main'
        , count: ${pageData.total}
        , curr: ${pageData.current}
        , limit: ${pageData.size}
        , jump: function (obj, first) {
          //首次不执行，之后【跳转curr页面】
          if (!first) {
            location.href = "?pn=" + obj.curr;
          }
        }
      });
    });
  </script>
 </div>
</#macro>

<#--宏：一条数据posting-->
<#macro plisting post>
 <li>
  <div>
   <a href="/user/${post.authorId}" class="fly-avatar">
    <img src="${post.authorAvatar}" alt="${post.authorName}">
   </a>
  </div>
  <div>
   <div class="layui-badge">${post.categoryName}</div>
   <a href="/post/${post.id}">${post.title}</a>
  </div>
  <div class="fly-list-info">
   <a href="/user/${post.authorId}"><cite>${post.authorName}</cite></a>
   <span>${timeAgo(post.created)}</span>
   <span class="fly-list-nums">
        <i class="iconfont icon-pinglun1" title="回答"></i>${post.commentCount}
      </span>
  </div>
  <div class="fly-list-badge">
      <#if post.level gt 0><span class="layui-badge layui-bg-black">置顶</span></#if>
      <#if post.recommend><span class="layui-badge layui-bg-red">精帖</span></#if>
  </div>
 </li>
</#macro>

<#--宏：个人账户-左侧链接（我的主页、用户中心、基本设置、我的消息）-->
<#macro centerLeft level>
 <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
  <li class="layui-nav-item <#if level == 0> layui-this</#if>">
   <a href="/user/home"><i class="layui-icon">&#xe609;</i>我的主页</a>
  </li>
  <li class="layui-nav-item <#if level == 1> layui-this</#if>">
   <a href="/user/index"><i class="layui-icon">&#xe612;</i>用户中心</a>
  </li>
  <li class="layui-nav-item <#if level == 2> layui-this</#if>">
   <a href="/user/set"><i class="layui-icon">&#xe620;</i>基本设置</a>
  </li>
  <li class="layui-nav-item <#if level == 3> layui-this</#if>">
   <a href="/user/mess"><i class="layui-icon">&#xe611;</i>我的消息</a>
  </li>
 </ul>
</#macro>