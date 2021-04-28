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