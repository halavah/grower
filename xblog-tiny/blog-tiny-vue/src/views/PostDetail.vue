<template>
  <div>
    <Header></Header>
    <div style="box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); width: 100%; min-height: 700px; padding: 20px 15px;">
      <h2> {{ post.title }} </h2>

      <!--编辑按钮-->
      <el-link icon="el-icon-edit" v-if="editButton">
        <!--使用router-link来跳转到某个组件，例如跳转到【BlogDetail组件】，需要传递参数【blogId: post.id】-->
        <router-link :to="{name: 'PostEdit', params: {postId: post.id}}">编辑</router-link>
      </el-link>

      <!--分割线-->
      <el-divider></el-divider>

      <!--使用【解析md样式、解析md文档】-->
      <div class="markdown-body" v-html="post.content"></div>
    </div>
  </div>
</template>

<script>
/*配置【解析md样式】*/
import 'github-markdown-css'
import Header from "@/components/Header";

export default {
  name: "PostDetail",
  components: {Header},
  data() {
    return {
      post: {
        id: "",
        title: "",
        content: ""
      },
      editButton: false
    }
  },

  //页面一开始渲染时，调用mounted()方法（回写操作）
  mounted() {
    /*根据 /router/index.js 路由规则：【path: '/post/:postId/edit'】中包含参数postId*/
    const postId = this.$route.params.postId
    console.log(postId)
    const _this = this
    this.$axios.get('/post/' + postId).then(res => {
      const post = res.data.data
      _this.post.id = post.id
      _this.post.title = post.title

      /*解析md文档*/
      var MardownIt = require("markdown-it")
      var md = new MardownIt()
      var result = md.render(post.content)
      _this.post.content = result

      _this.editButton = (post.userId === _this.$store.getters.GET_USERINFO.id)
    })
  }
}
</script>

<style>

</style>