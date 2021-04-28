<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl" />

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "添加或编辑文章">

  <div class="layui-container fly-marginTop">
    <div class="fly-panel" pad20 style="padding-top: 5px;">
      <!--<div class="fly-none">没有权限</div>-->
      <div class="layui-form layui-form-pane">
        <div class="layui-tab layui-tab-brief" lay-filter="user">

          <#--1.类型：发表文章/编辑文章-->
          <ul class="layui-tab-title">
            <li class="layui-this">
              <#--通过post是否为null，来判断该页面是【发表文章 还是 编辑文章】-->
              <#if post == null>
                发表文章<#else>编辑文章
              </#if>
            </li>
          </ul>

          <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
            <div class="layui-tab-item layui-show">
              <#--2.表单-->
              <form action="/post/submit" method="post">
                <div class="layui-row layui-col-space15 layui-form-item">
                  <#--2.1 所在专栏-->
                  <div class="layui-col-md3">
                    <label class="layui-form-label">所在专栏</label>
                    <div class="layui-input-block">
                      <select lay-verify="required" name="categoryId" lay-filter="column">
                        <option></option>
                        <#--下拉列表：分类信息-->
                        <#list categories as category>
                          <option value="${category.id}" <#if category.id == post.categoryId>selected</#if> >${category.name}</option>
                        </#list>
                      </select>
                    </div>
                  </div>

                  <#--2.2 文章标题-->
                  <div class="layui-col-md9">
                    <label for="L_title" class="layui-form-label">标题</label>
                    <div class="layui-input-block">
                      <input type="text" id="L_title" name="title" required lay-verify="required" value="${post.title}"
                             autocomplete="off" class="layui-input">
                      <input type="hidden" name="id" value="${post.id}">
                    </div>
                  </div>
                </div>

                <#--2.3 文章内容-->
                <div class="layui-form-item layui-form-text">
                  <div class="layui-input-block">
                    <textarea id="L_content" name="content" required lay-verify="required"
                              placeholder="详细描述" class="layui-textarea fly-editor" style="height: 260px;">${post.content}</textarea>
                  </div>
                </div>

                <#--2.4 提交表单-->
                <div class="layui-form-item">
                  <button class="layui-btn" lay-filter="*" lay-submit alert="true" >立即发布</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script>
    layui.cache.page = 'jie';
  </script>

</@layout>