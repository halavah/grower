<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>

<@layout "登录">

 <div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
   <div class="layui-tab layui-tab-brief" lay-filter="user">

    <#--超链接：登入、注册-->
    <ul class="layui-tab-title">
     <li class="layui-this">登入</li>
     <li><a href="/register">注册</a></li>
    </ul>

    <#--填写表单-->
    <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
     <div class="layui-tab-item layui-show">
      <div class="layui-form layui-form-pane">
        <#--post请求方式-->
       <form method="post">
        <#--1.邮箱-->
        <div class="layui-form-item">
         <label for="L_email" class="layui-form-label">邮箱</label>
         <div class="layui-input-inline">
          <input type="text" id="L_email" name="email" required
                 lay-verify="required"
                 autocomplete="off"
                 class="layui-input"
                 value="11111@qq.com">
         </div>
        </div>

        <#--2.密码-->
        <div class="layui-form-item">
         <label for="L_pass" class="layui-form-label">密码</label>
         <div class="layui-input-inline">
          <input type="password" id="L_pass" name="password" required
                 lay-verify="required"
                 autocomplete="off" class="layui-input"
                 value="123456">
         </div>
        </div>

        <#--3.立即登录、忘记密码-->
        <div class="layui-form-item">
         <button class="layui-btn" lay-filter="*" lay-submit>立即登录</button>
<#--         <span style="padding-left:20px;"><a href="">忘记密码？</a></span>-->
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