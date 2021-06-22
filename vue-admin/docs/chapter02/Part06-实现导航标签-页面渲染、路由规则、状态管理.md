# Part06-实现导航标签-页面渲染、路由规则、状态管理

```text
vue-admin-vue
│
└─src
    │  App.vue                  # 6.4 导航标签 - 刷新标签页
    │
    ├─router
    │      index.js             # 6.2 导航标签 - 路由规则
    │
    ├─store
    │  └─modules
    │          navtab.js        # 6.3 导航标签 - 状态管理
    │
    └─views
        │
        ├─inc
        │      NavBar.vue       # 6.1 导航标签 - 页面渲染
```

## 6.1 导航标签 - 页面渲染

- `/views/inc/NavTab.vue` ：页面渲染

```vue
<template>
  <!-- 【Tabs 标签页：自定义增加标签页触发器】 -->
  <el-tabs
    v-model="editableTabsValue"
    type="card"
    closable
    @tab-remove="removeTab"
    @tab-click="clickTab"
  >
    <el-tab-pane
      v-for="item in editableTabs"
      :key="item.name"
      :label="item.title"
      :name="item.name"
    ></el-tab-pane>
  </el-tabs>
</template>

<script>
export default {
  name: 'Tabs',
  computed: {
    editableTabsValue: {
      get() {
        return this.$store.state.navtab.editableTabsValue
      },
      set(val) {
        this.$store.state.navtab.editableTabsValue = val
      },
    },
    editableTabs: {
      get() {
        return this.$store.state.navtab.editableTabs
      },
      set(val) {
        this.$store.state.navtab.editableTabs = val
      },
    },
  },

  methods: {
    removeTab(targetName) {
      let tabs = this.editableTabs
      let activeName = this.editableTabsValue
      // 如果当前页【activeName】为操作页【targetName】，进行删除，并重新对标签页进行排列
      if (activeName === targetName) {
        tabs.forEach((tab, index) => {
          if (tab.name === targetName) {
            let nextTab = tabs[index + 1] || tabs[index - 1]
            if (nextTab) {
              activeName = nextTab.name
            }
          }
        })
      }
      // 如果当前页【activeName】为Index，不进行删除，保留【首页】
      if (targetName === 'Index') {
        return
      }
      this.editableTabsValue = activeName
      this.editableTabs = tabs.filter((tab) => tab.name !== targetName)
      // 解决删除标签页后，仍然停在【删除页的内容】
      this.$router.push({ name: activeName })
    },
    clickTab(targetName) {
      // NavTab.vue切换【el-main】通过指定”router中的name“来进行切换；而SideMenu.vue切换【el-main】：通过"嵌套路由"来进行切换
      this.$router.push({ name: targetName.name })
    },
  },
}
</script>
```

## 6.2 导航标签 - 路由规则

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

## 6.3 导航标签 - 状态管理

- `/store/modules/navtab.js` ：状态管理

```javascript
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default {
  state: {
    editableTabsValue: 'Index',
    editableTabs: [
      {
        title: '系统概况',
        name: 'Index',
      },
    ],
  },
  mutations: {
    ADD_TAB: (state, tab) => {
      // index：通过判断tab.name与e.name是否一致，解决标签重复引发的报错
      let index = state.editableTabs.findIndex((e) => e.name === tab.name)
      if (index === -1) {
        state.editableTabs.push({
          title: tab.title,
          name: tab.name,
        })
      }
      state.editableTabsValue = tab.name
    },
    RESET_TAB_STATE: (state) => {
      state.editableTabsValue = 'Index'
      state.editableTabs = [
        {
          title: '系统概况',
          name: 'Index',
        },
      ]
    },
  },
}
```

## 6.4 导航标签 - 刷新标签页

- `App.vue`：解决 F5 刷新，NarBar 标签页重置为"{title: '系统概况',name: 'Index',}"，但浏览器地址栏仍为"刷新前打开的网址，如<http://localhost:8080/sys/roles>"

```vue
<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App',

  // watch监听$route，只在父子关系路由中生效，处理【F5刷新，NarBar标签页重置为"{title: '系统概况',name: 'Index',}"，但浏览器地址栏仍为"刷新前打开的网址，如http://localhost:8080/sys/roles"】
  watch: {
    $route(to, from) {
      console.log('from: ', from)
      console.log('to: ', to)
      if (to.path != '/login') {
        let obj = {
          name: to.name,
          title: to.meta.title,
        }
        this.$store.commit('ADD_TAB', obj)
      }
    },
  },
}
</script>

<style>
/* 初始化浏览器尺寸 */
html,
body,
#app {
  height: 100%;
  padding: 0;
  margin: 0;
  font-size: 15px;
}

/* 取消超链接下划线 */
a {
  text-decoration: none;
}
</style>

```
