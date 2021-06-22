# Part04-实现侧边菜单-页面渲染、路由规则、状态管理、全局前置守卫

```text
vue-admin-vue
│
└─src
    ├─router
    │      index.js             # 4.2 侧边菜单 - 路由规则
    │
    ├─store
    │  └─modules
    │          menus.js         # 4.3 侧边菜单 - 状态管理
    │
    ├─utils
    │      guard.js             # 4.4 侧边菜单 - 全局前置守卫
    │
    └─views
        │
        ├─inc
        │      SideMenu.vue     # 4.1 侧边菜单 - 页面渲染
```

## 4.1 侧边菜单 - 页面渲染

- `/views/inc/SideMenu.vue` ：页面渲染

```vue
<template>
  <!-- 【NavMenu 导航菜单】：侧栏（白色） -->
  <el-menu
    :default-active="$store.state.navtab.editableTabsValue"
    class="el-menu-vertical-demo"
  >
    <!-- 导航链接："/" -->
    <router-link to="/">
      <el-menu-item
        index="Index"
        @click="selectMenu({ title: '系统概况', name: 'Index' })"
      >
        <template v-slot:title>
          <i class="el-icon-s-home"></i>
          <span>系统概况</span>
        </template>
      </el-menu-item>
    </router-link>

    <el-submenu
      v-for="(menu, index) in menuList"
      :key="index"
      :index="menu.name"
    >
      <template v-slot:title>
        <i :class="menu.icon"></i>
        <span>{{ menu.title }}</span>
      </template>

      <!-- 导航链接：:to="item.path" -->
      <router-link
        v-for="(item, index) in menu.children"
        :key="index"
        :to="item.path"
      >
        <el-menu-item :index="item.name" @click="selectMenu(item)">
          <template v-slot:title>
            <i :class="item.icon"></i>
            <span>{{ item.title }}</span>
          </template>
        </el-menu-item>
      </router-link>
    </el-submenu>
  </el-menu>
</template>

<script>
export default {
  name: 'SideMenu',

  /* 动态加载【菜单列表】：此写法【menuList: this.$store.state.menus.menuList】在使用store之前加载，从而造成无法加载该数据，故使用【计算属性computed 从store动态获取】 */
  computed: {
    menuList: {
      get() {
        return this.$store.state.menus.menuList
      },
      set(val) {
        this.$store.state.menus.menuList = val
      },
    },
  },

  methods: {
    selectMenu(item) {
      this.$store.commit('ADD_TAB', item)
    },
  },
}
</script>

<style scoped>
.el-menu-vertical-demo {
  height: 100%;
}
</style>
```

## 4.2 侧边菜单 - 路由规则

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

## 4.3 侧边菜单 - 状态管理

- `/store/modules/menus.js` ：状态管理

```javascript
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default {
  state: {
    menuList: [],
    permList: [],
    hasRoutes: false,
  },
  mutations: {
    SET_MENU_LIST: (state, menus) => {
      state.menuList = menus
    },
    SET_PER_LIST: (state, perms) => {
      state.permList = perms
    },
    SET_HAS_ROUTES: (state, hasRoutes) => {
      state.hasRoutes = hasRoutes
    },
    RESET_ROUTE_STATE: (state) => {
      state.menuList = []
      state.permList = []
      state.hasRoutes = false
    },
  },
}
```

## 4.4 侧边菜单 - 全局前置守卫

- `/utils/guard.js` ：全局前置守卫（路由规则），根据【用户权限】动态获取【菜单列表】

```javascript
// ? 内容：全局前置守卫（路由规则），根据【用户权限】动态获取【菜单列表】

import axios from '@/utils/axios'
import store from '@/store'
import router from '@/router'

// 全局前置守卫
router.beforeEach((to, from, next) => {
  let hasRoute = store.state.menus.hasRoutes
  let token = store.state.token
  if (to.path == '/login') {
    next()
  } else if (!token) {
    next({ path: '/login' })
  } else if (token && !hasRoute) {
    initMenu(router, store)
    store.commit('SET_HAS_ROUTES', true)
    next()
  }
  next()
})

// 初始【路由列表】
export const initMenu = (router, store) => {
  if (store.state.menus.menuList.length > 0) {
    return null
  }
  axios
    .get('/sys/menu/nav', {
      headers: { authorization: localStorage.getItem('token') },
    })
    .then((res) => {
      if (res) {
        // 获取【菜单列表】
        store.commit('SET_MENU_LIST', res.data.data.nav)
        // 获取【权限列表】
        store.commit('SET_PER_LIST', res.data.data.authoritys)
        // 绑定【动态路由】
        formatRoutes(res)
      }
    })
}

// 绑定【动态路由】
export const formatRoutes = (res) => {
  // 1.获取当前路由列表
  let nowRoutes = router.options.routes
  // 2.遍历【res.data.data.nav】，并依次将其加入路由列表
  res.data.data.nav.forEach((menu) => {
    if (menu.children) {
      menu.children.forEach((e) => {
        // 【处理：格式化路由】
        let route = menuToRoute(e)
        // 把【新路由】添加到【旧路由数组】中
        if (route) {
          nowRoutes[1].children.push(route)
        }
      })
    }
  })
  router.addRoutes(nowRoutes)
}

// 处理【格式化路由】
export const menuToRoute = (menu) => {
  if (menu.component) {
    let route = {
      path: menu.path,
      name: menu.name,
      component: () => import('@/views/' + menu.component + '.vue'),
      meta: {
        icon: menu.icon,
        title: menu.title,
      },
    }
    return route
  }
  return null
}
```
