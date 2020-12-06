<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>
<#--宏common.ftl（分页）-->
<#include "/inc/common.ftl"/>

<@layout "首页">

    <#include "/inc/header-panel.ftl"/>

    <div class="layui-container">
        <div class="layui-row layui-col-space15">

            <#--1.md8-->
            <div class="layui-col-md8">
                <#--1.1 fly-panel-->
                <div class="fly-panel">
                    <#--1.1.1 fly-panel-title-->
                    <div class="fly-panel-title fly-filter">
                        <a>置顶</a>
                        <a href="#signin" class="layui-hide-sm layui-show-xs-block fly-right" id="LAY_goSignin"
                           style="color: #FF5722;">去签到</a>
                    </div>
                    <#--1.1.2 消息列表-->
                    <ul class="fly-list">
                        <@posts size=3 level=1>
                            <#list results.records as post>
                                <@plisting post></@plisting>
                            </#list>
                        </@posts>
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
                        <#list pageData.records as post>
                            <@plisting post></@plisting>
                        </#list>
                    </div>
                    <#--1.2.3 分页条-->
                    <@paging pageData></@paging>
                </div>
            </div>

            <#--2.md4-->
            <#include "/inc/right.ftl"/>
        </div>
    </div>

</@layout>



