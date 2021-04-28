import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Element from 'element-ui'
import "element-ui/lib/theme-chalk/index.css"
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
import axios from 'axios'

import "./axios" /*axios全局拦截：前置拦截、后置拦截*/
import "./permission" /*权限拦截*/

Vue.config.productionTip = false;

Vue.use(Element);
Vue.prototype.$axios = axios;
Vue.use(mavonEditor);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
