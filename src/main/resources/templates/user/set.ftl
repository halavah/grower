<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "基本设置">

 <div class="layui-container fly-marginTop fly-user-main">
  <#--用户中心-左侧链接（我的主页、用户中心、基本设置、我的消息）-->
  <@centerLeft level=2></@centerLeft>

  <div class="site-tree-mobile layui-hide">
   <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>

  <div class="site-tree-mobile layui-hide">
   <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>

  <div class="fly-panel fly-panel-user" pad20>
   <div class="layui-tab layui-tab-brief" lay-filter="user">
    <ul class="layui-tab-title" id="LAY_mine">
     <li class="layui-this" lay-id="info">我的资料</li>
     <li lay-id="avatar">头像</li>
     <li lay-id="pass">密码</li>

     <@shiro.hasRole name="admin">
      <li lay-id="es">全局搜索</li>
     </@shiro.hasRole>

    </ul>
    <div class="layui-tab-content" style="padding: 20px 0;">
     <#--1.更新资料-->
     <div class="layui-form layui-form-pane layui-tab-item layui-show">
      <form method="post">
       <#--1.1 邮箱-->
       <div class="layui-form-item">
        <label for="L_email" class="layui-form-label">邮箱</label>
        <div class="layui-input-inline">
         <input type="text" id="L_email" name="email" required lay-verify="email"
                autocomplete="off" value="${user.email}" class="layui-input" readonly>
        </div>
       </div>

       <#--1.2 昵称-->
       <div class="layui-form-item">
        <label for="L_username" class="layui-form-label">昵称</label>
        <div class="layui-input-inline">
         <input type="text" id="L_username" name="username" required lay-verify="required"
                autocomplete="off" value="${user.username}" class="layui-input">
        </div>
        <div class="layui-inline">
         <div class="layui-input-inline">
          <input type="radio" name="gender" value="0" <#if user.gender =='0'>checked</#if>
                 title="男">
          <input type="radio" name="gender" value="1" <#if user.gender =='1'>checked</#if>
                 title="女">
         </div>
        </div>
       </div>

       <#--1.3 签名-->
       <div class="layui-form-item layui-form-text">
        <label for="L_sign" class="layui-form-label">签名</label>
        <div class="layui-input-block">
                                    <textarea placeholder="" id="L_sign" name="sign"
                                              autocomplete="off"
                                              class="layui-textarea"
                                              style="height: 80px;">${user.sign}</textarea>
        </div>
       </div>
       <#--1.4 确定修改-->
       <div class="layui-form-item">
        <#--通过阅读/res/mods/index.js源码可知，【lay-submit】此处默认【表单跳转】reload="true"，则会【重新加载当前页面】-->
        <button class="layui-btn" key="set-mine" lay-filter="*" lay-submit reload="true"
                alert="true">确认修改
        </button>
       </div>
      </form>
     </div>

     <#--2.更新头像-->
     <div class="layui-form layui-form-pane layui-tab-item">
      <div class="layui-form-item">
       <div class="avatar-add">
        <p>建议尺寸168*168，支持jpg、png、gif，最大不能超过2048KB</p>
        <button type="button" class="layui-btn upload-img">
         <i class="layui-icon">&#xe67c;</i>上传头像
        </button>
        <#--默认头像-->
        <img src="<@shiro.principal property="avatar" />">
        <span class="loading"></span>
       </div>
      </div>
     </div>

     <#--3.更新密码-->
     <div class="layui-form layui-form-pane layui-tab-item">
      <form action="/user/repass" method="post">
       <#--3.1 当前密码-->
       <div class="layui-form-item">
        <label for="L_nowpass" class="layui-form-label">当前密码</label>
        <div class="layui-input-inline">
         <input type="password" id="L_nowpass" name="nowpass" required lay-verify="required"
                autocomplete="off" class="layui-input">
        </div>
       </div>
       <#--3.2 新密码-->
       <div class="layui-form-item">
        <label for="L_pass" class="layui-form-label">新密码</label>
        <div class="layui-input-inline">
         <input type="password" id="L_pass" name="pass" required lay-verify="required"
                autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-mid layui-word-aux">6到16个字符</div>
       </div>
       <#--3.3 确定密码-->
       <div class="layui-form-item">
        <label for="L_repass" class="layui-form-label">确认密码</label>
        <div class="layui-input-inline">
         <input type="password" id="L_repass" name="repass" required lay-verify="required"
                autocomplete="off" class="layui-input">
        </div>
       </div>
       <#--3.4 确认修改-->
       <div class="layui-form-item">
        <#--通过阅读/res/mods/index.js源码可知，【lay-submit】此处默认【表单跳转】reload="true"，则会【重新加载当前页面】-->
        <button class="layui-btn" key="set-mine" lay-filter="*" lay-submit reload="true" alert="true">确认修改
        </button>
       </div>
      </form>
     </div>

     <#--4.同步ES数据-->
     <@shiro.hasRole name="admin">
      <div class="layui-form layui-form-pane layui-tab-item">
       <form action="/admin/initEsData" method="post">
        <button class="layui-btn" key="set-mine" lay-filter="*" lay-submit alert="true">同步数据
        </button>
       </form>
      </div>
     </@shiro.hasRole>

    </div>
   </div>
  </div>
 </div>
 </div>

 <script>
   layui.cache.page = 'jie';
 </script>

</@layout>