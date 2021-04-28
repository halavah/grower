<#--宏layout.ftl（导航栏 + 页脚）-->
<#include "/inc/layout.ftl"/>

<#--【三、填充（导航栏 + 页脚）】-->
<@layout "用户中心">

  <div class="layui-container fly-marginTop fly-user-main">
    <#--用户中心-左侧链接（我的主页、用户中心、基本设置、我的消息）-->
    <@centerLeft level=1></@centerLeft>

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
          <li data-type="mine-jie" lay-id="index" class="layui-this">我发表的帖</li>
          <li data-type="collection" data-url="/collection/find/" lay-id="collection">我收藏的帖</li>
        </ul>

        <div class="layui-tab-content" style="padding: 20px 0;">
          <div class="layui-tab-item layui-show">

            <#-----------------------1.发布的贴----------------------->
            <#--第二步：建立视图，用于呈现渲染结果-->
            <ul class="mine-view jie-row" id="publish">
              <#--第一步，编写模版（laytpl），使用一个script标签存放模板：https://www.layui.com/doc/modules/laytpl.html-->
              <script id="tpl-publish" type="text/html">
                <li>
                  <a class="jie-title" href="/post/{{d.id}}" target="_blank">
                    {{d.title}}
                  </a>
                  <i>
                    {{layui.util.toDateString(d.created, 'yyyy-MM-dd HH:mm:ss')}}
                  </i>
                  <a class="mine-edit" href="/post/{{d.id}}">查看</a>
                  <a class="mine-edit" href="/post/edit?id={{d.id}}">编辑</a>
                  <em>
                    {{d.viewCount }}阅/{{d.commentCount}}答
                  </em>
                </li>
              </script>
            </ul>

            <div id="LAY_page"></div>
          </div>

          <div class="layui-tab-item">

            <#-----------------------2.收藏的贴----------------------->
            <#--第二步：建立视图，用于呈现渲染结果-->
            <ul class="mine-view jie-row" id="collection">
              <#--第一步，编写模版（laytpl），使用一个script标签存放模板：https://www.layui.com/doc/modules/laytpl.html-->
              <script id="tpl-collection" type="text/html">
                <li>

                  <a class="jie-title" href="/post/{{d.id}}" target="_blank">{{d.title}}</a>
                  <i>收藏于{{layui.util.timeAgo(d.created, true)}}</i>
                </li>
              </script>
            </ul>

            <div id="LAY_page1"></div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    layui.cache.page = 'jie';

    layui.use(['laytpl', 'flow', 'util'], function () {
      var $ = layui.jquery;
      var laytpl = layui.laytpl;
      var flow = layui.flow;
      var util = layui.util;

      /*流加载（flow）*/
      flow.load({
        elem: '#publish'                    //elem：指定列表容器
        , isAuto: false                     //isAuto：是否自动加载。默认 true。如果设为 false，点会在列表底部生成一个 “加载更多” 的 button，则只能点击它才会加载下一页数据。
        , done: function (page, next) {     //done：到达临界点触发加载的回调（默认滚动触发），触发下一页
          var lis = [];

          //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
          $.get('/user/publish?pn=' + page, function (res) {

            //假设你的列表返回在data集合中
            layui.each(res.data.records, function (index, item) {

              <#--第三步：渲染模版-->
              var tpl = $("#tpl-publish").html();                //获取html内容：选择tpl-publish【第一步中的模版】
              laytpl(tpl).render(item, function (html) {         //使用render进行渲染：使用【集合item】对【模板tpl】渲染为html
                $("#publish .layui-flow-more").before(html);
              });
            });

            //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
            //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
            next(lis.join(''), page < res.data.pages);
          });
        }
      });

      flow.load({
        elem: '#collection'
        , isAuto: false
        , done: function (page, next) {
          var lis = [];

          $.get('/user/collection?pn=' + page, function (res) {
            layui.each(res.data.records, function (index, item) {

              <#--第三步：渲染模版-->
              var tpl = $("#tpl-collection").html();          //获取html内容：选择tpl-collection【第一步中的模版】
              laytpl(tpl).render(item, function (html) {      //使用render进行渲染：使用【集合item】对【模板tpl】渲染为html
                $("#collection .layui-flow-more").before(html);
              });
            });

            next(lis.join(''), page < res.data.pages);
          });
        }
      });

    });
  </script>

</@layout>