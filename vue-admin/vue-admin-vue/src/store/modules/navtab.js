import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default {
  state: {
    editableTabsValue: 'Index',
    editableTabs: [
      {
        title: '系统概况',
        name: 'Index',
      },
    ],
  },
  mutations: {
    ADD_TAB: (state, tab) => {
      // index：通过判断tab.name与e.name是否一致，解决标签重复引发的报错
      let index = state.editableTabs.findIndex((e) => e.name === tab.name)
      if (index === -1) {
        state.editableTabs.push({
          title: tab.title,
          name: tab.name,
        })
      }
      state.editableTabsValue = tab.name
    },
    RESET_TAB_STATE: (state) => {
      state.editableTabsValue = 'Index'
      state.editableTabs = [
        {
          title: '系统概况',
          name: 'Index',
        },
      ]
    },
  },
}
