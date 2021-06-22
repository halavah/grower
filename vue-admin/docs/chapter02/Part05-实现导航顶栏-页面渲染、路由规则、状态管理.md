# Part05-实现导航顶栏-页面渲染、路由规则、状态管理

```text
vue-admin-vue
│
└─src
    ├─router
    │      index.js             # 5.2 导航顶栏 - 路由规则
    │
    ├─store
    │      index.js             # 5.3 导航顶栏 - 状态管理
    │
    └─views
        │
        ├─inc
        │      NavBar.vue       # 5.1 导航顶栏 - 页面渲染
```

## 5.1 导航顶栏 - 页面渲染

- `/views/inc/NavBar.vue` ：页面渲染

```vue
<template>
  <div>
    <strong>权限管理系统</strong>

    <div class="header-avatar">
      <!-- 【Dropdown 下拉菜单：基础用法】 -->
      <el-dropdown size="medium">
        <span class="el-dropdown-link">
          {{ userInfo.username }}
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu>
          <!-- 导航链接："/user/center" -->
          <router-link :to="{ name: 'userCenter' }">
            <el-dropdown-item @click.native="selectMenu({ title: '个人中心', name: 'userCenter' })">
              个人中心
            </el-dropdown-item>
          </router-link>
          <!--@click.native 是给组件绑定原生事件，只能用在组件上，不可以用在原生元素上-->
          <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <!-- 【Avatar 头像：展示类型（图片）】 -->
      <el-avatar :src="userInfo.avatar"></el-avatar>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NavBar',

  computed: {
    userInfo: {
      get() {
        return this.$store.state.userInfo
      },
      set(val) {
        this.$store.state.userInfo = val
      },
    },
  },

  methods: {
    logout() {
      this.$axios.post('/logout').then(() => {
        this.$store.commit('REMOVE_ALL')
        this.$store.commit('RESET_ROUTE_STATE')
        this.$store.commit('RESET_TAB_STATE')
        this.$router.push('/login')
      })
    },
    selectMenu(item) {
      this.$store.commit('ADD_TAB', item)
    },
  },
}
</script>

<style scoped>
.header-avatar {
  float: right;
  width: 125px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.el-dropdown-link {
  cursor: pointer;
  color: #000;
}

.el-icon-arrow-down {
  font-size: 12px;
}
</style>
```

## 5.2 导航顶栏 - 路由规则

- `/router/index.js` ：路由规则

```javascript
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
  },
  {
    path: '/',
    name: 'Index',
    component: Index,
    children: [
      {
        path: '/user/center',
        name: 'userCenter',
        component: () => import('@/views/user/Center'),
      },
      // {
      //   path: '/sys/users',
      //   name: 'SysUser',
      //   component: () => import("@/views/sys/User")
      // },
      // {
      //   path: '/sys/roles',
      //   name: 'SysRole',
      //   component: () => import("@/views/sys/Role")
      // },
      // {
      //   path: '/sys/menus',
      //   name: 'SysMenu',
      //   component: () => import("@/views/sys/Menu")
      // }
    ],
  },
]

const router = new VueRouter({
  /* 采用history模式，利用了HTML5 History Interface 解决URL没有 “#” 号的问题 */
  mode: 'history',
  routes,
})

export default router
```

## 5.3 导航顶栏 - 状态管理

- `/store/index.js` ：状态管理

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
