<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>
<#--宏common.ftl（分页）-->
<#include "/inc/common.ftl"/>

<@layout "首页">

    <#include "/inc/header-panel.ftl"/>

    <div class="layui-container">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md8">
                <div class="fly-panel" style="margin-bottom: 0;">
                    <#--1.消息列表-->
                    <div class="fly-list">
                        <#--pageData.records：获取Ipage接口中的records方法-->
                        <#list pageData.records as post>
                            <li>
                                <div>
                                    <a href="/user/${post.authorId}" class="fly-avatar">
                                        <img src="${post.authorAvatar}" alt="${post.authorName}">
                                    </a>
                                </div>
                                <div>
                                    <div class="layui-badge">${post.categoryName}</div>
                                    <a href="jie/detail.html">${post.title}</a>
                                </div>
                                <div class="fly-list-info">
                                    <a href="/user/${post.authorId}">
                                        <cite>${post.authorName}</cite>
                                    </a>
                                    <span>
                                        ${post.created?string('yyyy-MM-dd')}
                                    </span>
                                    <span class="fly-list-nums">
                                        <i class="iconfont icon-pinglun1" title="回答"></i>${post.commentCount}
                                    </span>
                                </div>
                            </li>
                        </#list>
                    </div>
                    <#--2.分页条-->
                    <@paging pageData></@paging>
                </div>
            </div>

            <#include "/inc/right.ftl"/>
        </div>
    </div>

</@layout>



