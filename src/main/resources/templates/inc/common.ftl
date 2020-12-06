<#--宏：分页-->
<#macro paging pageData>

    <div style="text-align: center">
        <#--待渲染的div块（laypage-main）-->
        <div id="laypage-main"></div>

        <#--Script渲染div块-->
        <script src="/res/layui/layui.js"></script>
        <script>
            layui.use('laypage', function () {
                var laypage = layui.laypage;

                //执行一个laypage实例
                laypage.render({
                    elem: 'laypage-main'
                    , count: ${pageData.total}
                    , curr: ${pageData.current}
                    , limit: ${pageData.size}
                    , jump: function (obj, first) {
                        //首次不执行
                        if (!first) {
                            location.href = "?pn=" + obj.curr;
                        }
                    }
                });
            });
        </script>
    </div>
</#macro>

<#--宏：posting-->
<#macro plisting post>
    <li>
        <div>
            <a href="/user/${post.authorId}" class="fly-avatar">
                <img src="${post.authorAvatar}" alt="${post.authorName}">
            </a>
        </div>
        <div>
            <div class="layui-badge">${post.categoryName}</div>
            <a href="jie/detail.html">${post.title}</a>
        </div>
        <div class="fly-list-info">
            <a href="/user/${post.authorId}">
                <cite>${post.authorName}</cite>
            </a>
            <span>${timeAgo(post.created)}</span>
            <span class="fly-list-nums">
                <i class="iconfont icon-pinglun1" title="回答"></i>${post.commentCount}
            </span>
        </div>
    </li>
</#macro>

