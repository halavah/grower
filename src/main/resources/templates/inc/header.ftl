<#--【一、导航栏】-->
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <#--1.图标-->
        <a class="fly-logo" href="/">
            <img src="/res/images/logo.png" alt="layui">
        </a>

        <#--2.登录/注册-->
        <ul class="layui-nav fly-nav-user">

            <#--未登录的状态-->
            <#--【shiro.guest】：验证当前用户是否为 “访客”，即未认证（包含未记住）的用户-->
            <@shiro.guest>
                <li class="layui-nav-item">
                    <a class="iconfont icon-touxiang layui-hide-xs" href="user/login.html"></a>
                </li>
                <li class="layui-nav-item">
                    <a href="/login">登入</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/register">注册</a>
                </li>
            </@shiro.guest>

            <#--登录后的状态-->
            <#--【shiro.user】：认证通过或已记住的用户-->
            <@shiro.user>
                <li class="layui-nav-item">
                    <a class="fly-nav-avatar" href="javascript:;">
                        <#--当前用户【username】-->
                        <cite class="layui-hide-xs">
                            <@shiro.principal property="username"/>
                        </cite>
                        <i class="iconfont icon-renzheng layui-hide-xs" title="认证信息：layui 作者"></i>
                        <i class="layui-badge fly-badge-vip layui-hide-xs">SVIP</i>
                        <#--当前用户【avatar】-->
                        <img src="<@shiro.principal property="avatar" />">
                    </a>
                    <dl class="layui-nav-child">
                        <#--基本设置-->
                        <dd>
                            <a href="user/set.html">
                                <i class="layui-icon">&#xe620;</i>基本设置
                            </a>
                        </dd>
                        <#--我的消息-->
                        <dd>
                            <a href="user/message.html">
                                <i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息
                            </a>
                        </dd>
                        <#--我的主页-->
                        <dd>
                            <a href="user/home.html">
                                <i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页
                            </a>
                        </dd>
                        <hr style="margin: 5px 0;">
                        <#--退出登录-->
                        <dd>
                            <a href="/user/logout/" style="text-align: center;">
                                退出
                            </a>
                        </dd>
                    </dl>
                </li>
            </@shiro.user>

        </ul>
    </div>
</div>
