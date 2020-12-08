<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>
<#--宏common.ftl（分页、一条数据posting）-->
<#include "/inc/common.ftl"/>

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "博客详情">

<#--【二、分类】-->
    <#include "/inc/header-panel.ftl"/>

<#--【三、左侧md8 + 右侧md8】-->
    <div class="layui-container">
        <div class="layui-row layui-col-space15">

            <#--1.左侧md8-->
            <div class="layui-col-md8 content detail">
                <#--1.1文章-->
                <div class="fly-panel detail-box">
                    <#--1.1.1 文章标题-->
                    <h1>${postVoData.title}</h1>
                    <#--1.1.2 文章标签-->
                    <div class="fly-detail-info">
                        <span class="layui-badge layui-bg-green fly-detail-column">${postVoData.categoryName}</span>
                        <#if postVoData.level gt 0><span class="layui-badge layui-bg-black">置顶</span></#if>
                        <#if postVoData.recommend gt 0><span class="layui-badge layui-bg-red">精帖</span></#if>
                        <div class="fly-admin-box" data-id="123">
                            <span class="layui-btn layui-btn-xs jie-admin" type="del">删除</span>
                        </div>
                        <span class="fly-list-nums">
                            <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i>${postVoData.commentCount}</a>
                            <i class="iconfont" title="人气">&#xe60b;</i>${postVoData.viewCount}
                          </span>
                    </div>
                    <#--1.1.3 文章作者信息-->
                    <div class="detail-about">
                        <a class="fly-avatar" href="../user/${postVoData.authorId}">
                            <img src="${postVoData.authorAvatar}" alt="${postVoData.authorName}">
                        </a>
                        <div class="fly-detail-user">
                            <a href="/user/${postVoData.authorId}" class="fly-link">
                                <cite>${postVoData.authorName}</cite>
                            </a>
                            <span>${timeAgo(postVoData.created)}</span>
                        </div>
                        <div class="detail-hits" id="LAY_jieAdmin" data-id="${post.id}">
                            <span class="layui-btn layui-btn-xs jie-admin" type="edit">
                                <a href="add.html">编辑此贴</a>
                            </span>
                        </div>
                    </div>
                    <#--1.1.4 文章内容-->
                    <div class="detail-body photos">
                        ${postVoData.content}
                    </div>
                </div>

                <#--1.2 评论-->
                <div class="fly-panel detail-box" id="flyReply">
                    <#--1.2.1 回帖线-->
                    <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
                        <legend>回帖</legend>
                    </fieldset>

                    <#--1.2.2 评论区-->
                    <ul class="jieda" id="jieda">
                        <#list commentVoDatas.records as comment>
                            <div data-id="${comment.id}" class="jieda-daan">
                                <a name="item-${comment.id}"></a>
                                <div class="detail-about detail-about-reply">
                                    <a class="fly-avatar" href="/user/${comment.authorId}">
                                        <img src="${comment.authorAvatar}" alt="${comment.authorName}">
                                    </a>
                                    <a href="/user/${comment.authorId}">
                                        <cite>${comment.authorName}</cite>
                                    </a>
                                    <div class="fly-detail-user">
                                        <a href="/user/${comment.authorId}" class="fly-link">
                                            <cite>${comment.authorName}</cite>
                                        </a>
                                        <#--注意-->
                                        <#if comment.user_id == postVoData.user_id>
                                            <span>(楼主)</span>
                                        </#if>
                                    </div>
                                    <div class="detail-hits">
                                        <span>${timeAgo(comment.created)}</span>
                                    </div>
                                </div>
                                <div class="detail-body jieda-body photos">
                                    ${comment.content}
                                </div>
                                <div class="jieda-reply">
                                    <span class="jieda-zan zanok" type="zan">
                                        <i class="iconfont icon-zan"></i>
                                        <em>${comment.voteUp}</em>
                                    </span>
                                    <span type="reply">
                                        <i class="iconfont icon-svgmoban53"></i>
                                        回复
                                    </span>
                                    <div class="jieda-admin">
                                        <span type="del">删除</span>
                                    </div>
                                </div>
                            </div>
                            <div>

                            </div>
                        </#list>
                    </ul>

                    <#--1.2.3 评论分页-->
                    <@paging commentVoDatas></@paging>

                    <#--1.2.4 回复区-->
                    <div class="layui-form layui-form-pane">
                        <form action="/post/reply/" method="post">
                            <div class="layui-form-item layui-form-text">
                                <#--注意-->
                                <a name="comment"></a>
                                <div class="layui-input-block">
                                    <textarea id="L_content" name="content" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <input type="hidden" name="jid" value="${postVoData.id}">
                                <button class="layui-btn" lay-filter="*" lay-submit>提交回复</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <#--2.右侧md4-->
            <#include "/inc/right.ftl"/>
        </div>
    </div>

</@layout>