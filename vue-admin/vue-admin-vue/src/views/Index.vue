<template>
  <!-- Container 布局容器 -->
  <el-container>
    <el-aside width="200px">
      <SideMenu></SideMenu>
    </el-aside>
    <el-container>
      <el-header>
        <NavBar></NavBar>
      </el-header>
      <el-main>
        <NavTab></NavTab>
        <!--嵌套路由：根据【router路由规则】，先加载子路由，再加载父路由。加载顺序：children路由 -> index路由 -> app路由-->
        <router-view style="margin: 0 15px" />
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import SideMenu from '@/views/inc/SideMenu'
import NavBar from '@/views/inc/NavBar'
import NavTab from '@/views/inc/NavTab'

export default {
  name: 'Index',
  components: { SideMenu, NavBar, NavTab },
}
</script>

<style scoped>
.el-header {
  background-color: #409eff;
  color: #fff;
  text-align: center;
  line-height: 60px;
}

.el-main {
  padding: 0;
}
</style>
