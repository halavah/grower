import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'

import axios from 'axios'

import './utils/mock' /* 模拟数据（测试URL） */
import './utils/axios' /* 全局响应拦截（状态码） */
import './utils/guard' /* 全局前置守卫（路由规则） */
import './utils/perm' /* 全局权限按钮（隐藏按钮） */

Vue.config.productionTip = false
Vue.use(Element)
Vue.use(mavonEditor)
Vue.prototype.$axios = axios

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount('#app')
