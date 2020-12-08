<#--宏：1.macro定义脚本，名为layout，参数为title-->
<#macro layout title>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <title>${title}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta name="keywords" content="fly,layui,前端社区">
        <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
        <link rel="stylesheet" href="/res/layui/css/layui.css">
        <link rel="stylesheet" href="/res/css/global.css">
    </head>
    <body>

    <#--【一、导航栏】-->
    <#include "/inc/header.ftl"/>

    <#--【三、所有引用该“带有宏的标签layout.ftl”都会执行该操作：<@layout "首页"></@layout>中的数据 -> 填充到<#nested/>标签中】-->
    <#nested>

    <#--【四、页脚】-->
    <#include "/inc/footer.ftl"/>

    </body>
    </html>
</#macro>

