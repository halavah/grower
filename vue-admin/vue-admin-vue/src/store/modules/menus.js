import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default {
  state: {
    menuList: [],
    permList: [],
    hasRoutes: false,
  },
  mutations: {
    SET_MENU_LIST: (state, menus) => {
      state.menuList = menus
    },
    SET_PER_LIST: (state, perms) => {
      state.permList = perms
    },
    SET_HAS_ROUTES: (state, hasRoutes) => {
      state.hasRoutes = hasRoutes
    },
    RESET_ROUTE_STATE: (state) => {
      state.menuList = []
      state.permList = []
      state.hasRoutes = false
    },
  },
}
