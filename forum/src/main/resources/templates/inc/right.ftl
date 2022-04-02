<#--【三（2）、右侧md4】-->
<div class="layui-col-md4">

  <dl class="fly-panel fly-list-one">
    <dt class="fly-panel-title">本周热议</dt>
      <@hots>
          <#list results as post>
            <dd>
              <a href="/post/${post.id}">${post.title}</a>
              <span><i class="iconfont icon-pinglun1"></i> ${post.commentCount}</span>
            </dd>
          </#list>
      </@hots>
  </dl>

  <div class="fly-panel">
    <div class="fly-panel-title">
      站点信息
    </div>
    <div class="fly-panel-main">
      <a href="https://github.com/" target="_blank" class="fly-zanzhu"
         time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">Don't let joy take
        you down !</a>
    </div>
  </div>

  <div class="fly-panel fly-link">
    <h3 class="fly-panel-title">友情链接</h3>
    <dl class="fly-panel-main">
      <dd>
        <a href="https://www.youtube.com/" target="_blank">YouTube</a>
      <dd>
      <dd>
        <a href="https://www.facebook.com/" target="_blank">Facebook</a>
      <dd>
      <dd>
        <a href="https://www.twitter.com/" target="_blank">Twitter</a>
      <dd>
      <dd>
        <a href="https://www.instagram.com/" target="_blank">Instagram</a>
      <dd>
          <#--
          <dd>
              <a href="mailto:xianxin@layui-inc.com?subject=%E7%94%B3%E8%AF%B7Fly%E7%A4%BE%E5%8C%BA%E5%8F%8B%E9%93%BE" class="fly-link">申请友链</a>
          <dd>
          -->
    </dl>
  </div>

</div>