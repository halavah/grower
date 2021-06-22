<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App',

  // watch监听$route，只在父子关系路由中生效，处理【F5刷新，NarBar标签页重置为"{title: '系统概况',name: 'Index',}"，但浏览器地址栏仍为"刷新前打开的网址，如http://localhost:8080/sys/roles"】
  watch: {
    $route(to, from) {
      console.log('from: ', from)
      console.log('to: ', to)
      if (to.path != '/login') {
        let obj = {
          name: to.name,
          title: to.meta.title,
        }
        this.$store.commit('ADD_TAB', obj)
      }
    },
  },
}
</script>

<style>
/* 初始化浏览器尺寸 */
html,
body,
#app {
  height: 100%;
  padding: 0;
  margin: 0;
  font-size: 15px;
}

/* 取消超链接下划线 */
a {
  text-decoration: none;
}
</style>
