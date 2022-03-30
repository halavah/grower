<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl" />

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "错误页面">

  <#--【二、分类】-->
  <#include "/inc/header-panel.ftl" />

  <div class="layui-container fly-marginTop">
    <div class="fly-panel">
      <div class="fly-none">
        <h2><i class="iconfont icon-tishilian"></i></h2>
        <p>${message}</p>
      </div>
    </div>
  </div>

  <script>
    layui.cache.page = '';
  </script>

</@layout>