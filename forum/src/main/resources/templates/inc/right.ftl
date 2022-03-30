<#--【三（2）、右侧md4】-->
<div class="layui-col-md4">

  <dl class="fly-panel fly-list-one">
    <dt class="layui-btn layui-bg-green">近期热议</dt>
      <@hots>
          <#list results as post>
            <dd>
              <a href="/post/${post.id}">${post.title}</a>
              <span><i class="iconfont icon-pinglun1"></i> ${post.commentCount}</span>
            </dd>
          </#list>
      </@hots>
  </dl>

  <div class="fly-panel fly-link">
    <h3 class="layui-btn layui-bg-green">友情链接</h3>
    <dl class="fly-panel-main">
      <a href="https://www.youtube.com/" target="_blank">YouTube</a><br>
      <a href="https://www.facebook.com/" target="_blank">Facebook</a><br>
      <a href="https://www.twitter.com/" target="_blank">Twitter</a><br>
      <a href="https://www.instagram.com/" target="_blank">Instagram</a>
      <br>
    </dl>
  </div>

  <div class="fly-panel">
    <h3 class="layui-btn layui-bg-green">我的博客</h3>
    <dl class="fly-panel-main">
      <dd>
        <a href="https://halavah.tk/" target="_blank">Halavah's Blog</a>
      <dd>
    </dl>
  </div>
</div>