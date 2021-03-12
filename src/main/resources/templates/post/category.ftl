<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "博客分类">

    <#--【二、分类】-->
    <#include "/inc/header-panel.ftl"/>

    <#--【三、左侧md8 + 右侧md8】-->
    <div class="layui-container">
        <div class="layui-row layui-col-space15">

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
    </div>

    <script>
        layui.cache.page = 'jie';
    </script>
</@layout>





