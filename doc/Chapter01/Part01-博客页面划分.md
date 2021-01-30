## 1. 博客页面划分
### 1.1 导航栏（header.ftl）
- 图标
- 登录/注册

### 1.2 分类（header-panel.ftl）
- 首页
- 提问、分享、讨论、建议

### 1.3 左侧md8（left.ftl）

### 1.4 右侧md4（right.ftl）

### 1.5 宏（common.ftl）
- 分页：`<@paging XXX></@paging>`
- 一条数据posting：`<@plisting XXX></@plisting>`

### 1.6 布局（layout.ftl）
- 宏：macro定义脚本，名为layout，参数为title
- 划分：header.ftl、<#nested/>、footer.ftl