import Vue from 'vue'
import Vuex from 'vuex'
import menus from '@/store/modules/menus'
import navtab from '@/store/modules/navtab.js'

Vue.use(Vuex)

export default new Vuex.Store({
  // attr属性
  state: {
    token: localStorage.getItem('token'),
    userInfo: JSON.parse(localStorage.getItem('userInfo')),
  },

  // set方法
  mutations: {
    SET_TOKEN: (state, token) => {
      state.token = token
      localStorage.setItem('token', token)
    },
    SET_USERINFO: (state, userInfo) => {
      state.userInfo = userInfo
      localStorage.setItem('userInfo', JSON.stringify(userInfo))
    },
    REMOVE_ALL: (state) => {
      state.token = ''
      state.userInfo = {}
      localStorage.setItem('token', '')
      localStorage.setItem('userInfo', JSON.stringify(''))
    },
  },

  // get方法
  getters: {
    GET_TOKEN: (state) => {
      return state.token
    },
    GET_USERINFO: (state) => {
      return state.userInfo
    },
  },

  // 自定义modules模块
  modules: {
    menus,
    navtab,
  },
})
