<template>
  <!-- 【Tabs 标签页：自定义增加标签页触发器】 -->
  <el-tabs
    v-model="editableTabsValue"
    type="card"
    closable
    @tab-remove="removeTab"
    @tab-click="clickTab"
  >
    <el-tab-pane
      v-for="item in editableTabs"
      :key="item.name"
      :label="item.title"
      :name="item.name"
    ></el-tab-pane>
  </el-tabs>
</template>

<script>
export default {
  name: 'Tabs',
  computed: {
    editableTabsValue: {
      get() {
        return this.$store.state.navtab.editableTabsValue
      },
      set(val) {
        this.$store.state.navtab.editableTabsValue = val
      },
    },
    editableTabs: {
      get() {
        return this.$store.state.navtab.editableTabs
      },
      set(val) {
        this.$store.state.navtab.editableTabs = val
      },
    },
  },

  methods: {
    removeTab(targetName) {
      let tabs = this.editableTabs
      let activeName = this.editableTabsValue
      // 如果当前页【activeName】为操作页【targetName】，进行删除，并重新对标签页进行排列
      if (activeName === targetName) {
        tabs.forEach((tab, index) => {
          if (tab.name === targetName) {
            let nextTab = tabs[index + 1] || tabs[index - 1]
            if (nextTab) {
              activeName = nextTab.name
            }
          }
        })
      }
      // 如果当前页【activeName】为Index，不进行删除，保留【首页】
      if (targetName === 'Index') {
        return
      }
      this.editableTabsValue = activeName
      this.editableTabs = tabs.filter((tab) => tab.name !== targetName)
      // 解决删除标签页后，仍然停在【删除页的内容】
      this.$router.push({ name: activeName })
    },
    clickTab(targetName) {
      // NavTab.vue切换【el-main】通过指定”router中的name“来进行切换；而SideMenu.vue切换【el-main】：通过"嵌套路由"来进行切换
      this.$router.push({ name: targetName.name })
    },
  },
}
</script>
