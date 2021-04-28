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