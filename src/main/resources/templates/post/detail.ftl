<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl" />

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "博客详情">

  <#--【二、分类】-->
  <#include "/inc/header-panel.ftl" />

  <#--【三、左侧md8 + 右侧md8】-->
  <div class="layui-container">
    <div class="layui-row layui-col-space15">

      <#--1.左侧md8-->
      <div class="layui-col-md8 content detail">
        <#--1.1文章-->
        <div class="fly-panel detail-box">
          <#--1.1.1 文章标题-->
          <h1>${post.title}</h1>

          <#--1.1.2 文章标签-->
          <div class="fly-detail-info">
            <span class="layui-badge layui-bg-green fly-detail-column">${post.categoryName}</span>

            <#if post.level gt 0><span class="layui-badge layui-bg-black">置顶</span></#if>
            <#if post.recommend><span class="layui-badge layui-bg-red">精帖</span></#if>

            <div class="fly-admin-box" data-id="${post.id}">
                <#--发布者删除-->
                <#if post.userId == profile.id  &&  profile.id != 1>
                  <span class="layui-btn layui-btn-xs jie-admin" type="del">删除</span>
                </#if>

                <#--管理员操作-->
                <@shiro.hasRole name="admin">
                  <span class="layui-btn layui-btn-xs jie-admin" type="set" field="delete" rank="1" reload="true" >删除</span>
                    <#if post.level == 0><span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1">置顶</span></#if>
                    <#if post.level gt 0><span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span></#if>
                    <#if !post.recommend><span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1">加精</span></#if>
                    <#if post.recommend><span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span></#if>
                </@shiro.hasRole>
            </div>

            <span class="fly-list-nums">
              <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i>${post.commentCount}</a>
              <i class="iconfont" title="人气">&#xe60b;</i>${post.viewCount}
            </span>
          </div>

          <#--1.1.3 文章作者信息-->
          <div class="detail-about">
            <a class="fly-avatar" href="/user/${post.authorId}">
              <img src="${post.authorAvatar}" alt="${post.authorName}">
            </a>
            <div class="fly-detail-user">
              <a href="/user/${post.authorId}" class="fly-link">
                <cite>${post.authorName}</cite>
              </a>
              <span>${timeAgo(post.created)}</span>
            </div>

            <div class="detail-hits" id="LAY_jieAdmin" data-id="${post.id}">
              <#--登录状态下，用户id = 作者id，才能进行【编辑文章】-->
              <#if profile.id == post.userId>
                <span class="layui-btn layui-btn-xs jie-admin" type="edit">
                  <a href="/post/edit?id=${post.id}">编辑此贴</a>
                </span>
              </#if>
              <#--未登录状态下，【缺少span块引起的显示问题】，作用：空占位，美化样式-->
              <span class="jie-admin" type=""></span>
            </div>
          </div>

          <#--1.1.4 文章内容-->
          <div class="detail-body photos">
              ${post.content}
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
            <#list pageData.records as comment>
              <li data-id="${comment.id}" class="jieda-daan">
                <a name="item-${comment.id}"></a>
                <div class="detail-about detail-about-reply">
                  <a class="fly-avatar" href="/user/${post.authorId}">
                    <img src="${comment.authorAvatar}" alt="${comment.authorName}">
                  </a>
                  <div class="fly-detail-user">
                    <a href="/user/${comment.authorId}" class="fly-link">
                      <cite>${comment.authorName}</cite>
                    </a>
                    <#if comment.user_id == post.user_id>
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
              </li>
            </#list>
          </ul>

          <#--1.2.3 评论分页-->
          <@paging pageData></@paging>

          <#--1.2.4 回复区-->
          <div class="layui-form layui-form-pane">
            <form action="/post/reply/" method="post">
              <div class="layui-form-item layui-form-text">
                <a name="comment"></a>
                <div class="layui-input-block">
                  <textarea id="L_content" name="content" required lay-verify="required"
                            placeholder="请输入内容" class="layui-textarea fly-editor"
                            style="height: 150px;"></textarea>
                </div>
              </div>
              <div class="layui-form-item">
                <input type="hidden" name="jid" value="${post.id}">
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
  <script>
    layui.cache.page = 'jie';

    //如果你是采用模版自带的编辑器，你需要开启以下语句来解析
    $(function () {
      layui.use(['fly', 'face'], function() {
        var fly = layui.fly;
        $('.detail-body').each(function(){
          var othis = $(this), html = othis.html();
          othis.html(fly.content(html));
        });
      });
    });

  </script>

</@layout>