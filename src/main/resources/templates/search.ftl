<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl" />

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "搜索 - ${q}">

  <#--【二、分类】-->
  <#include "/inc/header-panel.ftl" />

  <div class="layui-container">
    <div class="layui-row layui-col-space15">

      <#--1.左侧md8-->
      <div class="layui-col-md8">
        <div class="fly-panel">

          <#--1.2.1 共有X条记录-->
          <div class="fly-panel-title fly-filter">
            <a>您正在搜索关键字”${q}“，共有 <strong>${pageData.total}</strong> 条记录</a>
            <a href="#signin" class="layui-hide-sm layui-show-xs-block fly-right" id="LAY_goSignin" style="color: #FF5722;">去签到</a>
          </div>

          <#--1.2.2 消息列表-->
          <ul class="fly-list">
            <#list pageData.records as post>
              <@plisting post></@plisting>
            </#list>
          </ul>

          <#--1.2.3 分页条-->
          <@paging pageData></@paging>
        </div>
      </div>

      <#--2.右侧md4-->
      <#include "/inc/right.ftl" />
    </div>
  </div>
</@layout>