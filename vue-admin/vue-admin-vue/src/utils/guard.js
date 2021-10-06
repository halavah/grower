// ? 内容：全局前置守卫（路由规则），根据【用户权限】动态获取【菜单列表】

import axios from '@/utils/axios'
import store from '@/store'
import router from '@/router'

// 全局前置守卫
router.beforeEach((to, from, next) => {
  let hasRoute = store.state.menus.hasRoutes
  let token = store.state.token

  // 访问/login，直接访问
  if (to.path == '/login') {
    next()
  } else {
    // 未登录状态，返回
    if (typeof token === 'undefined' || token === null || token === '') {
      next({ path: '/login' })
    }

    // 刷新页面时，hasRoute 变量恢复为 false，即不调用 initMenu；点击某个连接时，hasRoute 变量仍为 true，即调用 initMenu
    if (token && !hasRoute) {
      initMenu(router, store)
      store.commit('SET_HAS_ROUTES', true)
      next()
    }

    // 访问 非/login，且 拥有 token，直接访问
    if (token && to.path != '/login') {
      next()
    }
  }
})

// 初始【路由列表】
const initMenu = (router, store) => {
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
const formatRoutes = (res) => {
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
const menuToRoute = (menu) => {
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

export default router
