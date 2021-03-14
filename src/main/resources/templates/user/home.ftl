<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "我的主页">

  <#--1.用户基本信息-->
  <div class="fly-home fly-panel">
    <#--头像-->
    <img src="${user.avatar}" alt="贤心">
    <i class="iconfont icon-renzheng" title="Fly社区认证"></i>

    <#--作者信息-->
    <h1>
        ${user.username}
      <i class="iconfont icon-nan"></i>
      <i class="layui-badge fly-badge-vip">SVIP</i>
    </h1>

    <#--创建时间-->
    <p class="fly-home-info">
      <i class="iconfont icon-kiss" title="飞吻"></i><span style="color: #FF7200;">66666 飞吻</span>
      <i class="iconfont icon-shijian"></i><span>${timeAgo(user.created)} 加入</span>
    </p>

    <#--个性签名-->
    <p class="fly-home-sign">
        ${user.sign!'这个人好懒，什么都没留下！'}
    </p>
  </div>

  <#--2.最近的提问 + 最近的回答-->
  <div class="layui-container">
    <div class="layui-row layui-col-space15">
      <#--用户近期【30天】的文章-->
      <div class="layui-col-md6 fly-home-jie">
        <div class="fly-panel">
          <h3 class="fly-panel-title">${user.username} 最近的提问</h3>
          <ul class="jie-row">
              <#list posts as post>
                <li>
                  <#if post.recommend>
                    <span class="fly-jing">精</span>
                  </#if>
                  <a href="/post/${post.id}" class="jie-title">
                      ${post.title}
                  </a>
                  <i>${timeAgo(post.created)}</i>
                  <em class="layui-hide-xs">
                      ${post.viewCount}阅/${post.commentCount}答
                  </em>
                </li>
              </#list>home.ftlhome.ftl
              <#if !posts>
                <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;">
                  <i style="font-size:14px;">没有发表任何求解</i>
                </div>
              </#if>
          </ul>
        </div>
      </div>
      <#--最近的回答-->
      <div class="layui-col-md6 fly-home-da">
        <div class="fly-panel">
          <h3 class="fly-panel-title">${user.username} 最近的回答</h3>
          <ul class="home-jieda">
            <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何问题</span>
            </div>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <script>
    layui.cache.page = 'jie';
  </script>
</@layout>