<template>
  <div>
    <strong>权限管理系统</strong>

    <div class="header-avatar">
      <!-- 【Dropdown 下拉菜单：基础用法】 -->
      <el-dropdown size="medium">
        <span class="el-dropdown-link">
          {{ userInfo.username }}
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu>
          <!-- 导航链接："/user/center" -->
          <router-link :to="{ name: 'userCenter' }">
            <el-dropdown-item @click.native="selectMenu({ title: '个人中心', name: 'userCenter' })">
              个人中心
            </el-dropdown-item>
          </router-link>
          <!--@click.native 是给组件绑定原生事件，只能用在组件上，不可以用在原生元素上-->
          <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <!-- 【Avatar 头像：展示类型（图片）】 -->
      <el-avatar :src="userInfo.avatar"></el-avatar>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NavBar',

  computed: {
    userInfo: {
      get() {
        return this.$store.state.userInfo
      },
      set(val) {
        this.$store.state.userInfo = val
      },
    },
  },

  methods: {
    logout() {
      this.$axios.post('/logout').then(() => {
        this.$store.commit('REMOVE_ALL')
        this.$store.commit('RESET_ROUTE_STATE')
        this.$store.commit('RESET_TAB_STATE')
        this.$router.push('/login')
      })
    },
    selectMenu(item) {
      this.$store.commit('ADD_TAB', item)
    },
  },
}
</script>

<style scoped>
.header-avatar {
  float: right;
  width: 125px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.el-dropdown-link {
  cursor: pointer;
  color: #000;
}

.el-icon-arrow-down {
  font-size: 12px;
}
</style>
