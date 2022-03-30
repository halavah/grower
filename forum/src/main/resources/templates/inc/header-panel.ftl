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
    </ul>

    <div class="fly-column-right layui-hide-xs">
      <a href="/user/index#index" class="layui-btn layui-btn-primary">已发表的提问</a>
      <a href="/user/index#index" class="layui-btn layui-btn-primary">已收藏的提问</a>
      <a href="post/edit" class="layui-btn">新建一个提问</a>
    </div>

<#--    <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;">-->
<#--      <a href="post/edit" class="layui-btn">发表新帖</a>-->
<#--    </div>-->
  </div>
</div>