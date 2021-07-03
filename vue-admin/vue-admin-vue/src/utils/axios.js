// ? 内容：全局响应拦截（状态码），根据【不同URL】处理【不同的动作】

import axios from 'axios'
import Element from 'element-ui'
import router from '../router'
import store from '../store'

// 开启baseURL，即使Mock数据为8080端口也会进行拦截，因此测试Mcok数据时关闭此baseURL
axios.defaults.baseURL = 'http://localhost:8765'

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
