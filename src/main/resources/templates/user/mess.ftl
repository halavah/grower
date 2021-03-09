<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>
<#--宏common.ftl（个人账户-左侧链接（我的主页、用户中心、基本设置、我的消息））-->
<#include "/inc/common.ftl"/>

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
            <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
                <button class="layui-btn layui-btn-danger" id="LAY_delallmsg">清空全部消息</button>
                <div id="LAY_minemsg" style="margin-top: 10px;">
                    <!--<div class="fly-none">您暂时没有最新消息</div>-->
                    <ul class="mine-msg">
                        <li data-id="123">
                            <blockquote class="layui-elem-quote">
                                <a href="/jump?username=Absolutely" target="_blank"><cite>Absolutely</cite></a>回答了您的求解<a
                                        target="_blank"
                                        href="/jie/8153.html/page/0/#item-1489505778669"><cite>layui后台框架</cite></a>
                            </blockquote>
                            <p><span>1小时前</span><a href="javascript:;"
                                                   class="layui-btn layui-btn-small layui-btn-danger fly-delete">删除</a>
                            </p>
                        </li>
                        <li data-id="123">
                            <blockquote class="layui-elem-quote">
                                系统消息：欢迎使用 layui
                            </blockquote>
                            <p><span>1小时前</span><a href="javascript:;"
                                                   class="layui-btn layui-btn-small layui-btn-danger fly-delete">删除</a>
                            </p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

    </div>

    <script>
        layui.cache.page = 'user';
    </script>

</@layout>