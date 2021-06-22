<template>
  <!-- 【NavMenu 导航菜单】：侧栏（白色） -->
  <el-menu :default-active="$store.state.navtab.editableTabsValue" class="el-menu-vertical-demo">
    <!-- 导航链接："/" -->
    <router-link to="/">
      <el-menu-item index="Index" @click="selectMenu({ title: '系统概况', name: 'Index' })">
        <template v-slot:title>
          <i class="el-icon-s-home"></i>
          <span>系统概况</span>
        </template>
      </el-menu-item>
    </router-link>

    <el-submenu v-for="(menu, index) in menuList" :key="index" :index="menu.name">
      <template v-slot:title>
        <i :class="menu.icon"></i>
        <span>{{ menu.title }}</span>
      </template>

      <!-- 导航链接：:to="item.path" -->
      <router-link v-for="(item, index) in menu.children" :key="index" :to="item.path">
        <el-menu-item :index="item.name" @click="selectMenu(item)">
          <template v-slot:title>
            <i :class="item.icon"></i>
            <span>{{ item.title }}</span>
          </template>
        </el-menu-item>
      </router-link>
    </el-submenu>
  </el-menu>
</template>

<script>
export default {
  name: 'SideMenu',

  /* 动态加载【菜单列表】：此写法【menuList: this.$store.state.menus.menuList】在使用store之前加载，从而造成无法加载该数据，故使用【计算属性computed 从store动态获取】 */
  computed: {
    menuList: {
      get() {
        return this.$store.state.menus.menuList
      },
      set(val) {
        this.$store.state.menus.menuList = val
      },
    },
  },

  methods: {
    selectMenu(item) {
      this.$store.commit('ADD_TAB', item)
    },
  },
}
</script>

<style scoped>
.el-menu-vertical-demo {
  height: 100%;
}
</style>
