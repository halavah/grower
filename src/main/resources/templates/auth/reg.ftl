<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>

<@layout "注册">

    <div class="layui-container fly-marginTop">
        <div class="fly-panel fly-panel-user" pad20>
            <div class="layui-tab layui-tab-brief" lay-filter="user">

                <#--超链接：登入、注册-->
                <ul class="layui-tab-title">
                    <li><a href="/login">登入</a></li>
                    <li class="layui-this">注册</li>
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
                                        <input type="text" id="L_email" name="email" required lay-verify="email"
                                               autocomplete="off" class="layui-input"
                                               value="halavah@126.com">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">将会成为您唯一的登入名</div>
                                </div>

                                <#--2.昵称-->
                                <div class="layui-form-item">
                                    <label for="L_username" class="layui-form-label">昵称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="L_username" name="username" required
                                               lay-verify="required" autocomplete="off" class="layui-input"
                                               value="halavah">
                                    </div>
                                </div>

                                <#--3.密码-->
                                <div class="layui-form-item">
                                    <label for="L_pass" class="layui-form-label">密码</label>
                                    <div class="layui-input-inline">
                                        <input type="password" id="L_pass" name="password" required
                                               lay-verify="required" autocomplete="off" class="layui-input"
                                               value="123456">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">6到16个字符</div>
                                </div>

                                <#--4.确认密码-->
                                <div class="layui-form-item">
                                    <label for="L_repass" class="layui-form-label">确认密码</label>
                                    <div class="layui-input-inline">
                                        <input type="password" id="L_repass" name="repass" required
                                               lay-verify="required" autocomplete="off" class="layui-input"
                                               value="123456">
                                    </div>
                                </div>

                                <#--5.图片验证码-->
                                <div class="layui-form-item">
                                    <label for="L_vercode" class="layui-form-label">验证码</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="L_vercode" name="vercode" required lay-verify="required"
                                               placeholder="请回答后面的问题" autocomplete="off" class="layui-input">
                                    </div>
                                    <#--图片验证码-->
                                    <div class="">
                                        <img id="capthca" src="/capthca.jpg">
                                    </div>
                                </div>

                                <#--6.注册-->
                                <div class="layui-form-item">
                                    <#--通过阅读/res/mods/index.js源码可知，【lay-submit】此处默认【表单提交】对应的链接为”文件名“，即【/register】-->
                                    <#--通过阅读/res/mods/index.js源码可知，【lay-submit】此处默认【表单跳转】alert="true"，则会跳转【action属性中的值】-->
                                    <button class="layui-btn" lay-filter="*" lay-submit alert="true">立即注册</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        layui.cache.page = 'user';

        // 刷新验证码：重新对数据接口进行请求（本次未使用【时间戳】）
        $("#capthca").click(function () {
            this.src = "/capthca.jpg";
        });

    </script>

</@layout>