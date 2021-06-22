// ? 内容：全局权限按钮（隐藏按钮），根据【用户权限】是否隐藏【增删改查】

import Vue from 'vue'

/* mixin作用：多个组件可以共享数据和方法，在已有的组件数据和方法进行了扩充 */
Vue.mixin({
  methods: {
    hasAuth(perm) {
      let authority = this.$store.state.menus.menuList
      return authority.indexOf(perm) > -1
    },
  },
})

// 示例：sys/User.vue 中调用【mixin】中的方法，如，v-if="hasAuth('sys:user:save')"
/*
<el-button type="primary" size="mini" v-if="hasAuth('sys:user:save')" @click="addOneUser"
  >新增一行</el-button
>
*/
