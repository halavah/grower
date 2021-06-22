# Part01-完成项目搭建-vuecli、elementui、axios、qs、mockjs

```text
vue-admin-vue
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

## 1.1 使用 vue-cli 完成项目搭建

```text
a.安装
    yarn global add @vue/cli && yarn global add webpack && yarn global add webpack-cli
b.查看
    vue -V && webpack -v
```

## 1.2 使用 element-ui 完成项目搭建

- element-ui：组件库

```text
a.安装
    yarn add element-ui
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

- axios：一个基于 promise 的 HTTP 库

```text
a.安装
    yarn add axios
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
    Vue.prototype.$axios = axios;                   # 添加该行

    new Vue({
      router,
      store,
      render: h => h(App)
    }).$mount('#app');
```

## 1.4 使用 qs 完成项目搭建

- qs：查询参数序列化和解析库

```text
a.安装
    yarn add qs
```

## 1.5 使用 mockjs 完成项目搭建

- mockjs：模拟数据

```text
a.安装
    yarn add mockjs
b.配置
    cd src/utils/mock.js
```
