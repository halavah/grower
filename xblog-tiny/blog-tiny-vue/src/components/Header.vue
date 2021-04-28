<template>
  <div style="max-width: 960px; margin: 0 auto; text-align: center;">
    <h3>欢迎来到Halavah的博客！</h3>
    <div class="block">
      <el-avatar :size="50" :src="user.avatar"></el-avatar>
      <div>{{ user.username }}</div>
    </div>
    <div style="margin: 10px 0;">
      <span>
        <el-link href="/">主页</el-link>
      </span>
      <el-divider direction="vertical"></el-divider>
      <span><el-link type="success" href="/post/add">发表博客</el-link></span>
      <el-divider direction="vertical"></el-divider>
      <span v-show="!isLogin"><el-link type="primary" href="/login">登录</el-link></span>
      <span v-show="isLogin"><el-link type="danger" @click="logout()">退出</el-link></span>
    </div>
  </div>
</template>

<script>
export default {
  name: "Header",
  data() {
    return {
      user: {
        username: '',
        avatar: 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'
      },
      isLogin: false
    }
  },
  methods: {
    logout() {
      const _this = this
      _this.$axios.get("/logout", {
        headers: {
          "authorization": this.$store.getters.GET_TOKEN
        },
      }).then(res => {
        _this.$store.commit("REMOVE_ALL")
        _this.$router.push("/login")
      })
    }
  },
  created() {
    if(this.$store.getters.GET_USERINFO.username) {
      this.user.username = this.$store.getters.GET_USERINFO.username
      this.user.avatar = this.$store.getters.GET_USERINFO.avatar
      this.isLogin = true
    }
  }
}
</script>

<style>

</style>