# Part01-完成项目搭建-vuecli、elementui、axios

```text
blog-tiny-vue
│  .gitignore
│  babel.config.js
│  blog-tiny-vue.iml
│  package-lock.json
│  package.json
│  README.md
│
├─node_modules
│
├─public
│      favicon.ico
│      index.html
│
└─src
    │  App.vue
    │  main.js
    │
    ├─assets
    │      logo.png
    │
    ├─components
    │      HelloWorld.vue
    │
    ├─router
    │      index.js
    │
    ├─store
    │      index.js
    │
    └─views
            About.vue
            Home.vue
```

## 1.1 使用 vuecli 完成项目搭建

- 初始化项目，命令如下：

```text
a.安装
    npm install -g @vue/cli && npm install -g webpack && npm install -g webpack-cli
b.版本
    vue -V && webpack -v
    @vue/cli 4.5.12、webpack 5.30.0、webpack-cli 4.6.0
c.创建
    cd D:\software_ware\workspace_idea\blog-tiny && vue ui
d.相关配置
    项目名称：blog-tiny-vue
    包管理器：npm
    Git版本控制：关闭
    手动配置项目：Choose vue version（勾选）、Babel（勾选）、Router（勾选）、Vuex（勾选）、Linter/ Formatter（取消勾选）
    功能及配置：Vue.js使用2.x（默认）、是否使用旧的路由模式（是）
    保存为新预设：暂不设置
```

## 1.2 使用 elementui 完成项目搭建

- 初始化项目，命令如下：

```text
a.安装
    cd D:\software_ware\workspace_idea\blog-tiny\blog-tiny-vue
    cnpm install element-ui --save                  # 安装 ElementUi
    yarn add element-ui                             # 安装 ElementUi
b.配置
    cd src/mian.js
    ------------------------------------------------------------
    import Vue from 'vue'
    import App from './App.vue'
    import router from './router'
    import store from './store'
    import Element from 'element-ui'                # 添加该行
    import "element-ui/lib/theme-chalk/index.css"   # 添加该行

    Vue.config.productionTip = false;

    Vue.use(Element);                               # 添加该行

    new Vue({
      router,
      store,
      render: h => h(App)
    }).$mount('#app');
```

## 1.3 使用 axios 完成项目搭建

- 初始化项目，命令如下：

```text
a.安装
    cd D:\software_ware\workspace_idea\blog-tiny\blog-tiny-vue
    cnpm install axios --save                       # 安装 Axios
    yarn add axios                                  # 安装 Axios
b.配置
    cd src/mian.js
    ------------------------------------------------------------
    import Vue from 'vue'
    import App from './App.vue'
    import router from './router'
    import store from './store'
    import Element from 'element-ui'
    import "element-ui/lib/theme-chalk/index.css"
    import axios from 'axios'                       # 添加该行

    Vue.config.productionTip = false;

    Vue.use(Element);
    Vue.prototype.$axios = axios                    # 添加该行

    new Vue({
      router,
      store,
      render: h => h(App)
    }).$mount('#app');
```
