# 2. 路由规则-权限拦截-用户登录-状态管理-全局拦截-公共组件

```text
blog-tiny-vue
│      
└─src
    │  App.vue
    │  axios.js                   #                      2.5 编写【全局拦截】
    │  main.js                    # 2.2 使用【权限拦截】    2.5 使用【全局拦截】      
    │  permission.js              # 2.2 编写【权限拦截】
    │
    ├─router
    │      index.js               # 2.1 路由规则
    │      
    ├─store
    │      index.js               # 2.4 状态管理，【用途一：将 token、userInfo 存储到 vuex 中供其他组件调用；用途二：将其存储到 localStorage 中供下次打开浏览器使用】
    │      
    └─views
            Login.vue             # 2.3 用户登录
            PostDetail.vue
            PostEdit.vue
            PostList.vue
```

## 2.1 路由规则

- `/router/index.js` ：路由规则

```javascript
import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "@/views/Login";
import PostList from "@/views/PostList";
import PostDetail from "@/views/PostDetail";
import PostEdit from "@/views/PostEdit";

Vue.use(VueRouter);

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/',
    name: 'Index',
    redirect: {name: "PostList"}   /*重定向至 Blogs 组件*/
  },
  {
    path: '/post/list',
    name: 'PostList',
    component: PostList           /*主页【查看全部文章】*/
  },
  {
    path: '/post/add',
    name: 'PostAdd',
    component: PostEdit,          /*发表【新建一篇文章】*/
    meta: {
      requireAuth: true           /*对应【权限拦截】自定义规则*/
    }
  },
  {
    path: '/post/:postId',
    name: 'PostDetail',
    component: PostDetail         /*详情【查看某篇文章】*/
  },
  {
    path: '/post/:postId/edit',
    name: 'PostEdit',
    component: PostEdit,          /*编辑【编辑某篇文章】*/
    meta: {
      requireAuth: true           /*对应【权限拦截】自定义规则*/
    }
  }
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
```

## 2.2 权限拦截

- `permission.js` ：编写【权限拦截】，【对应 `/router/index.js` 路由规则】

```javascript
import router from "./router";

//权限拦截：根据【/router/index.js】中的路由规则，是否需要进行【权限验证：登录】
router.beforeEach((to, from, next) => {

  //判断该路由是否需要登录权限
  if (to.matched.some(record => record.meta.requireAuth)) {
    const token = localStorage.getItem("token")
    console.log(token)
    //判断当前的token是否存在
    if (token) {
      if (to.path === '/login') {

      } else {
        next()
      }
    } else {
      next({
        path: '/login'
      })
    }
  } else {
    next()
  }
})
```

- `main.js` ：使用【权限拦截】，【直接将编写好的 permission.js 导入 main.js】

```javascript
import "./permission" /*权限拦截*/
```

## 2.3 用户登录

- `/views/Login.vue` ：用户登录

```vue
<template>
  <div>
    <el-container>
      <el-header>
        <img class="logo" src="https://www.markerhub.com/dist/images/logo/markerhub-logo.png">
      </el-header>
      <el-main>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="ruleForm.username"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input type="password" v-model="ruleForm.password"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
            <el-button @click="resetForm('ruleForm')">重置</el-button>
          </el-form-item>
        </el-form>
      </el-main>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "Login",

  data() {
    return {
      ruleForm: {
        username: 'admin',
        password: '123456',
      },
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 3, max: 15, message: '长度在 3 到 15 个字符', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'change'},
        ],
      }
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          const _this = this

          // axios.js 中 axios.defaults.baseURL + /login 等同于 http://localhost:8765/login
          this.$axios.post('/login', this.ruleForm).then(res => {
            //请求后的数据
            console.log(res.data)
            console.log(res.headers)

            const token = res.headers['authorization']
            const userInfo = res.data.data

            //调用vuex中的set方法
            _this.$store.commit("SET_TOKEN", token);
            _this.$store.commit("SET_USERINFO", userInfo);

            //获取vuex中的get方法
            console.log(_this.$store.getters.GET_TOKEN);
            console.log(_this.$store.getters.GET_USERINFO);
            console.log(_this.$store.getters.GET_USERINFO.avatar);
            console.log(_this.$store.getters.GET_USERINFO.username);

            //跳转页面
            _this.$router.push("/");
          })

        } else {
          console.log('登录失败！！！');
          return false;
        }
      });
    },

    resetForm(formName) {
      this.$refs[formName].resetFields();
    }

  }
}
</script>

<style>
.el-header, .el-footer {
  background-color: #B3C0D1;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.el-aside {
  background-color: #D3DCE6;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  color: #333;
  text-align: center;
  line-height: 160px;
}

body > .el-container {
  margin-bottom: 40px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
  line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
  line-height: 320px;
}

/*----------------自定义样式----------------*/
.logo {
  height: 60%;
  margin-top: 10px;
}

.demo-ruleForm {
  max-width: 500px;
  margin: 0 auto;
}

</style>
```

## 2.4 状态管理

- `/store/index.js` ：状态管理，【用途一：将 token、userInfo 存储到 vuex 中供其他组件调用；用途二：将其存储到 localStorage 中供下次打开浏览器使用】

```javascript
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  //attr属性
  state: {
    token: localStorage.getItem("token"),
    userInfo: JSON.parse(localStorage.getItem("userInfo"))
  },

  //set方法
  mutations: {
    SET_TOKEN: (state, token) => {
      state.token = token;
      localStorage.setItem("token", token)
    },
    SET_USERINFO: (state, userInfo) => {
      state.userInfo = userInfo;
      localStorage.setItem("userInfo", JSON.stringify(userInfo))
    },
    REMOVE_ALL: (state) => {
      state.token = ''
      state.userInfo = {}
      localStorage.setItem("token", '')
      localStorage.setItem("userInfo", JSON.stringify(''))
    },
  },

  //get方法
  getters: {
    GET_TOKEN: state => {
      return state.token;
    },
    GET_USERINFO: state => {
      return state.userInfo;
    }
  },

  actions: {},
  modules: {}
})
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  //attr属性
  state: {
    token: localStorage.getItem("token"),
    userInfo: JSON.parse(localStorage.getItem("userInfo"))
  },

  //set方法
  mutations: {
    SET_TOKEN: (state, token) => {
      state.token = token;
      localStorage.setItem("token", token)
    },
    SET_USERINFO: (state, userInfo) => {
      state.userInfo = userInfo;
      localStorage.setItem("userInfo", JSON.stringify(userInfo))
    },
    REMOVE_ALL: (state) => {
      state.token = ''
      state.userInfo = {}
      localStorage.setItem("token", '')
      localStorage.setItem("userInfo", JSON.stringify(''))
    },
  },

  //get方法
  getters: {
    GET_TOKEN: state => {
      return state.token;
    },
    GET_USERINFO: state => {
      return state.userInfo;
    }
  },

  actions: {},
  modules: {}
})
```

## 2.5 全局拦截

- `axios.js` ：编写【全局拦截】，【对应 `GlobalExceptionHandler.java` 全局异常】

```javascript
import axios from 'axios'
import Element from 'element-ui'

axios.defaults.baseURL = "http://localhost:8765"

/**
 * 前置拦截
 */
axios.interceptors.request.use(request => {
  return request
})

/**
 * 后置拦截
 */
axios.interceptors.response.use(
    //状态码错误
    succ => {
      //状态码，200
      if (succ.data.code === 200) {
        return succ
      }

      //状态码，非200
      if (succ.data.code !== 200) {
        var mess = succ.data.msg;
        Element.Message.error(mess, {duration: 3 * 1000}) //消息弹窗
        return Promise.reject(mess)
      }
    },

    //程序运行错误
    error => {
      //处理Assert的异常，比如：Assert.notNull(user, "用户不存在!");
      if (error.response.data) {
        var mess = error.response.data.msg;
        Element.Message.error(mess, {duration: 3 * 1000})  //消息弹窗
        return Promise.reject(mess)
      }

      //处理Shiro的异常，比如：用户权限、用户登录
      if (error.response.status === 401) {
        this.$store.commit("REMOVE_ALL")
        this.$router.push("/login")
      }
    }
)
```

- `main.js` ：使用【全局拦截】，【直接将编写好的 axios.js 导入 main.js】

```javascript
import "./axios" /*axios全局拦截：前置拦截、后置拦截*/
```
