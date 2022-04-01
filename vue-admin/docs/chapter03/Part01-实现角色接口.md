# Part03-实现用户登录-页面渲染、路由规则、状态管理、全局响应拦截

```text
vue-admin-vue
│
└─src
    ├─router
    │      index.js             # 3.2 用户登录 - 路由规则
    │
    ├─store
    │      index.js             # 3.3 用户登录 - 状态管理
    │
    ├─utils
    │      axios.js             # 3.4 用户登录 - 全局响应拦截
    │
    └─views
        │  Login.vue            # 3.1 用户登录 - 页面渲染
```

## 3.1 用户登录 - 页面渲染

- `/views/Login.vue` ：页面渲染

```vue
<template>
  <div>
    <!-- 【Form 表单：自定义校验规则】 -->
    <el-form
      ref="ruleLoginForm"
      :rules="ruleLogin"
      :model="ruleLoginForm"
      class="loginContainer"
    >
      <h3 class="loginTitle">用户登录</h3>

      <el-form-item prop="username">
        <el-input
          v-model="ruleLoginForm.username"
          size="normal"
          type="text"
          auto-complete="off"
          placeholder="请输入用户名"
        ></el-input>
      </el-form-item>

      <el-form-item prop="password">
        <el-input
          v-model="ruleLoginForm.password"
          size="normal"
          type="password"
          auto-complete="off"
          placeholder="请输入密码"
        ></el-input>
      </el-form-item>

      <el-form-item prop="code">
        <el-input
          v-model="ruleLoginForm.code"
          maxlength="5"
          style="width: 262px; float: left"
        ></el-input>
        <el-image
          :src="captchaImg"
          class="captchaImg"
          @click="getCaptcha"
        ></el-image>
      </el-form-item>

      <!-- 【Checkbox 多选框：基础用法】 -->
      <el-checkbox v-model="checked" size="normal" class="loginRemember"
        >点击记住我</el-checkbox
      >

      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleLoginForm')"
          >登录</el-button
        >
        <el-button @click="resetForm('ruleLoginForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: 'Login',

  data() {
    return {
      ruleLoginForm: {
        username: 'admin',
        password: '123456',
        code: '11111',
        token: '',
      },
      ruleLogin: {
        username: [
          {
            required: true,
            message: '请输入用户名',
            trigger: 'blur',
          },
        ],
        password: [
          {
            required: true,
            message: '请输入密码',
            trigger: 'blur',
          },
        ],
        code: [
          {
            required: true,
            message: '请输入验证码',
            trigger: 'blur',
          },
          {
            min: 5,
            max: 5,
            message: '长度为 5 个字符',
            trigger: 'blur',
          },
        ],
      },
      checked: true,
      captchaImg: null,
    }
  },

  created() {
    this.getCaptcha()
  },

  methods: {
    submitForm(ruleLoginForm) {
      this.$refs[ruleLoginForm].validate((valid) => {
        if (valid) {
          // 1.Post请求：获取jwt并存放到vuex
          this.$axios.post('/login', this.ruleLoginForm).then((res) => {
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
    },

    resetForm(ruleLoginForm) {
      this.$refs[ruleLoginForm].resetFields()
    },

    getCaptcha() {
      this.$axios.get('/captcha').then((res) => {
        this.ruleLoginForm.token = res.data.data.token
        this.captchaImg = res.data.data.captchaImg
        this.ruleLoginForm.code = ''
      })
    },
  },
}
</script>

<style>
.loginContainer {
  border-radius: 15px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 15px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}

.loginTitle {
  margin: 15px auto 20px auto;
  text-align: center;
}

.loginRemember {
  text-align: left;
  margin: 0px 0px 15px 0px;
}

.captchaImg {
  width: 80px;
  float: left;
  margin-left: 8px;
  border-radius: 4px;
}
</style>
```

## 3.2 用户登录 - 路由规则

- `/router/index.js` ：路由规则

```vue
import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '@/views/Login'
import Index from '@/views/Index'

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login,
  }
]

const router = new VueRouter({
  /* 采用history模式，利用了HTML5 History Interface 解决URL没有 “#” 号的问题 */
  mode: 'history',
  routes,
})

export default router
```

## 3.3 用户登录 - 状态管理

- `/store/index.js` ：状态管理，【将用户登录信息存储到 VUEX 中，以供全部组件进行使用】

```javascript
import Vue from 'vue'
import Vuex from 'vuex'
import menus from '@/store/modules/menus'
import navtab from '@/store/modules/navtab.js'

Vue.use(Vuex)

export default new Vuex.Store({
  // attr属性
  state: {
    token: localStorage.getItem('token'),
    userInfo: JSON.parse(localStorage.getItem('userInfo')),
  },

  // set方法
  mutations: {
    SET_TOKEN: (state, token) => {
      state.token = token
      localStorage.setItem('token', token)
    },
    SET_USERINFO: (state, userInfo) => {
      state.userInfo = userInfo
      localStorage.setItem('userInfo', JSON.stringify(userInfo))
    },
    REMOVE_ALL: (state) => {
      state.token = ''
      state.userInfo = {}
      localStorage.setItem('token', '')
      localStorage.setItem('userInfo', JSON.stringify(''))
    },
  },

  // get方法
  getters: {
    GET_TOKEN: (state) => {
      return state.token
    },
    GET_USERINFO: (state) => {
      return state.userInfo
    },
  },

  // 自定义modules模块
  modules: {
    menus,
    navtab,
  },
})
```

## 3.4 用户登录 - 全局响应拦截

- `/utils/axios.js` ：全局响应拦截（状态码），根据【不同 URL】处理【不同的动作】

```javascript
// ? 内容：全局响应拦截（状态码），根据【不同URL】处理【不同的动作】

import axios from 'axios'
import Element from 'element-ui'
import router from '../router'
import store from '../store'

// 开启baseURL，即使Mock数据为8080端口也会进行拦截，因此测试Mcok数据时关闭此baseURL
// axios.defaults.baseURL = "http://localhost:8080"

// 创建统一的 axios 对象
const handle = axios.create({
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json; charset=utf-8',
  },
})

// 前置拦截
handle.interceptors.request.use((succ) => {
  succ.headers['authorization'] = localStorage.getItem('token')
  return succ
})

// 后置拦截
handle.interceptors.response.use(
  // 状态码错误
  (succ) => {
    // 状态码，200
    if (succ.data.code === 200) {
      return succ
    }

    // 状态码，非200
    if (succ.data.code !== 200) {
      let mess = succ.data.msg
      Element.Message.error(mess, { duration: 3 * 1000 }) // 消息弹窗
      return Promise.reject(mess)
    }
  },

  // 程序运行错误
  (error) => {
    // 处理Assert的异常，比如：Assert.notNull(user, "用户不存在!");
    if (error.response.data) {
      let mess = error.response.data.msg
      Element.Message.error(mess, { duration: 3 * 1000 }) // 消息弹窗
      return Promise.reject(mess)
    }

    // 处理Shiro的异常，比如：用户权限、用户登录
    if (error.response.status === 401) {
      store.commit('REMOVE_ALL')
      router.push('/login')
    }
  },
)

export default handle
```
