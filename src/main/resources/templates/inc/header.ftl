<#--【一、导航栏】-->
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <#--1.图标-->
        <a class="fly-logo" href="/">
            <img src="/res/images/logo.png" alt="layui">
        </a>

        <#--2.登录/注册-->
        <ul class="layui-nav fly-nav-user">
            <li class="layui-nav-item">
                <a class="iconfont icon-touxiang layui-hide-xs" href="user/login.html"></a>
            </li>
            <li class="layui-nav-item">
                <a href="user/login.html">登入</a>
            </li>
            <li class="layui-nav-item">
                <a href="user/reg.html">注册</a>
            </li>
            <li class="layui-nav-item layui-hide-xs">
                <a href="/app/qq/" onclick="layer.msg('正在通过QQ登入', {icon:16, shade: 0.1, time:0})" title="QQ登入"
                   class="iconfont icon-qq"></a>
            </li>
            <li class="layui-nav-item layui-hide-xs">
                <a href="/app/weibo/" onclick="layer.msg('正在通过微博登入', {icon:16, shade: 0.1, time:0})" title="微博登入"
                   class="iconfont icon-weibo"></a>
            </li>
        </ul>
    </div>
</div>
