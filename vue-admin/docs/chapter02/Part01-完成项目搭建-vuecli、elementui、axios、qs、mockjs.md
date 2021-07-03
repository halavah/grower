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
b.配置
    cd src/views/Login.vue
    ------------------------------------------------------------
    import qs from 'qs'

    // ruleLoginForm：json 数据
    ruleLoginForm: {
      username: 'admin',
      password: '123456',
      code: '',
      token: '',
    },

    submitForm(ruleLoginForm) {
      this.$refs[ruleLoginForm].validate((valid) => {
        if (valid) {
          // 1.Post请求：获取jwt并存放到vuex
          this.$axios.post('/login?' + qs.stringify(this.ruleLoginForm)).then((res) => { // qs：将 json 数据转化为 form 数据
            // const jwt = res.headers['authorization']
            const jwt = res.data.data.token
            console.log('jwt: ', jwt)
            this.$store.commit('SET_TOKEN', jwt)

            // 2.Get请求：获取userInfo并存放到vuex
            this.$axios.get('/sys/userInfo').then((res) => {
              this.$store.commit('SET_USERINFO', res.data.data)
            })

            // 3.跳转主页
            this.$router.push('/')
          })
        } else {
          return false
        }
      })
    }
 c.说明
    // 原因：Captcha 过滤器，需要从 request 中获取 key、code，因此必须将 json 数据转化为 form 数据
    String key = req.getParameter("key");
    String code = req.getParameter("code");
    if (StringUtils.isBlank(code) || StringUtils.isBlank(key)) {
      throw new CaptchaException("验证码错误！");
    }
    if (!code.equals(redisUtil.hget(Const.CAPTCHA_KEY, key))) {
      throw new CaptchaException("验证码错误！");
    }
    // Redis：【Const.CAPTCHA_KEY】对应的键值对【key】-【code】
    redisUtil.hdel(Const.CAPTCHA_KEY, key);
```

## 1.5 使用 mockjs 完成项目搭建

- mockjs：模拟数据

```text
a.安装
    yarn add mockjs
b.配置
    cd src/utils/mock.js
```
