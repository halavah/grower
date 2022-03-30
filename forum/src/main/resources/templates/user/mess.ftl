<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "用户中心">

  <div class="layui-container fly-marginTop fly-user-main">
    <#--用户中心-左侧链接（我的主页、用户中心、基本设置、我的消息）-->
    <@centerLeft level=3></@centerLeft>

    <div class="site-tree-mobile layui-hide">
      <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

    <div class="site-tree-mobile layui-hide">
      <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

    <div class="fly-panel fly-panel-user" pad20>
      <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg"
           style="margin-top: 15px;">
<#--        <button class="layui-btn layui-btn-danger" id="LAY_delallmsg">清空全部消息</button>-->
        <div id="LAY_minemsg" style="margin-top: 10px;">
          <ul class="mine-msg">
            <#--我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表评论的评论-->
            <#list pageData.records as mess>
              <li data-id="${mess.id}">
                <blockquote class="layui-elem-quote">
                  <#if mess.type == 0>
                    系统消息：${mess.content}
                  </#if>
                  <#if mess.type == 1>
                      ${mess.fromUserName} 评论了你的文章 <${mess.postTitle}>，内容是 (${mess.commentContent})
                  </#if>
                  <#if mess.type == 2>
                      ${mess.fromUserName} 回复了你的评论 (${mess.commentContent})，文章是 <${mess.postTitle}>
                  </#if>
                </blockquote>
                <p>
                  <span>${timeAgo(mess.created)}</span>
<#--                  <a class="layui-btn layui-btn-small layui-btn-danger fly-delete"-->
<#--                     href="javascript:;">删除</a>-->
                </p>
              </li>
            </#list>
          </ul>

          <#--分页条-->
          <@paging pageData></@paging>
        </div>
      </div>
    </div>
  </div>

  <script>
    layui.cache.page = 'jie';
  </script>

</@layout>