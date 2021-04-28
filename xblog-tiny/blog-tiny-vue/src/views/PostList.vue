<template>
  <div>
    <Header></Header>
    <div>
      <div class="block">
        <!--时间线-->
        <el-timeline>
          <el-timeline-item :timestamp="post.created" placement="top" v-for="(post, index) in posts" :key="index">
            <el-card>
              <h4>
                <!--使用router-link来跳转到某个组件，例如跳转到【BlogDetail组件】，需要传递参数【blogId: post.id】-->
                <router-link :to="{name: 'PostDetail', params: {postId: post.id}}">{{ post.title }}</router-link>
              </h4>
              <p>{{ post.description }}</p>
            </el-card>
          </el-timeline-item>
        </el-timeline>
        <!--分页-->
        <el-pagination style="margin: 0 auto; text-align: center" background layout="prev, pager, next" :current-page="currentPage" :page-size="pageSize" :total="total" @current-change=handleCurrentChange></el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
import Header from "@/components/Header";

export default {
  name: "PostList",
  components: {Header},
  data() {
    return {
      posts: {},
      currentPage: 1,
      total: 0,
      pageSize: 5
    }
  },
  methods: {
    handleCurrentChange(currentPage) {
      const _this = this
      _this.$axios.get("/post/list?currentPage=" + currentPage).then(res => {
        console.log(res)
        _this.posts = res.data.data.records
        _this.currentPage = res.data.data.current
        _this.total = res.data.data.total
        _this.pageSize = res.data.data.size
      })
    }
  },

  //页面一开始渲染时，调用mounted()方法（回写操作）
  mounted() {
    this.handleCurrentChange(1)
  }
}
</script>

<style>

</style>