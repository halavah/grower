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
