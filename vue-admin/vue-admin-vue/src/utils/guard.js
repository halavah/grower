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
