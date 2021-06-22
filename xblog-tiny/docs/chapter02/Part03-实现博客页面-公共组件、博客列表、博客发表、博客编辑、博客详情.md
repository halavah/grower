# Part03-实现博客页面-公共组件、博客列表、博客发表、博客编辑、博客详情

```text
blog-tiny-vue
│
└─src
    ├─components
    │      Header.vue             # 2.1 公共组件
    │
    └─views
            Login.vue
            PostDetail.vue        # 2.4 博客详情
            PostEdit.vue          # 2.3 博客发表 / 博客编辑
            PostList.vue          # 2.2 博客列表
```

## 3.1 博客页面 - 公共组件

- `/components/Header.vue` ：编写【公共组件】

```vue
<template>
  <div style="max-width: 960px; margin: 0 auto; text-align: center;">
    <h3>欢迎来到Halavah的博客！</h3>

    <div class="block">
      <el-avatar :size="50" :src="user.avatar"></el-avatar>
      <div>{{ user.username }}</div>
    </div>

    <div style="margin: 10px 0;">
      <span>
        <el-link href="/blogs">主页</el-link>
      </span>
      <el-divider direction="vertical"></el-divider>
      <span><el-link type="success" href="/blog/add">发表博客</el-link></span>
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
```

- `/views/PostList.vue` ：使用【公共组件】

```vue
<template>
  <div>
    <Header></Header>
  </div>
</template>

<script>
import Header from "@/components/Header";

export default {
  name: "PostList",
  components: {Header},
}
</script>

<style>

</style>
```

## 3.2 博客页面 - 博客列表

- `/views/PostList.vue` ：博客列表

```vue
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

  //页面一开始渲染时，调用mounted()方法
  mounted() {
    this.handleCurrentChange(1)
  }
}
</script>

<style>

</style>
```

## 3.3 博客页面 - 博客发表 / 博客编辑

- 基于 Vue 的 markdown 编辑器（编写）：mavon-editor

```text
a.安装
    cd D:\software_ware\workspace_idea\blog-tiny\blog-tiny-vue
    cnpm install mavon-editor --save                # 用于编写md文档
    yarn add mavon-editor                           # 用于编写md文档
b.配置
    cd src/mian.js
    ------------------------------------------------------------
    import Vue from 'vue'
    import App from './App.vue'
    import router from './router'
    import store from './store'
    import Element from 'element-ui'
    import "element-ui/lib/theme-chalk/index.css"
    import mavonEditor from 'mavon-editor'          # 添加该行
    import 'mavon-editor/dist/css/index.css'        # 添加该行
    import axios from 'axios'

    import "./axios" /*axios全局拦截：前置拦截、后置拦截*/

    Vue.config.productionTip = false;

    Vue.use(Element);
    Vue.prototype.$axios = axios;
    Vue.use(mavonEditor);                           # 添加该行

    new Vue({
      router,
      store,
      render: h => h(App)
    }).$mount('#app');
c.使用
    /views/PostEdit.vue
    ------------------------------------------------------------
    <el-form-item label="内容" prop="content">
      <mavon-editor v-model="ruleForm.content"></mavon-editor>
    </el-form-item>
```

- `/views/PostEdit.vue` ：博客发表 / 博客编辑

```vue
<template>
  <div>
    <Header></Header>
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="max-width: 80%;">
      <el-form-item label="标题" prop="title">
        <el-input v-model="ruleForm.title"></el-input>
      </el-form-item>
      <el-form-item label="摘要" prop="description">
        <el-input type="textarea" v-model="ruleForm.description"></el-input>
      </el-form-item>
      <el-form-item label="内容" prop="content">
        <mavon-editor v-model="ruleForm.content"></mavon-editor>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')">发布</el-button>
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import Header from "@/components/Header";

export default {
  name: "PostEdit",
  components: {Header},
  data() {
    return {
      ruleForm: {
        id: '',
        title: '',
        description: '',
        content: ''
      },
      rules: {
        title: [
          {required: true, message: '请输入标题', trigger: 'blur'},
          {min: 3, max: 25, message: '长度在 3 到 25 个字符', trigger: 'blur'}
        ],
        description: [
          {required: true, message: '请输入摘要', trigger: 'blur'}
        ],
        content: [
          {required: true, message: '请输入内容', trigger: 'blur'}
        ]
      }
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          const _this = this
          this.$axios.post('/post/edit', this.ruleForm, {headers: {"authorization": localStorage.getItem("token")}})
          .then(res => {
            console.log(res)
            _this.$alert('操作成功', '提示', {      /*MessageBox 弹框*/
              confirmButtonText: '确定',
              callback: action => {
                _this.$router.push("/post/list")
              }
            });
          })
        } else {
          console.log('操作失败！！！');
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },

  //页面一开始渲染时，调用mounted()方法（回写操作）
  mounted() {
    /*根据 /router/index.js 路由规则：【path: '/post/:postId/edit'】中包含参数postId*/
    const postId = this.$route.params.postId
    console.log(postId)
    const _this = this
    if (postId) {
      this.$axios.get('/post/' + postId).then(res => {
        const post = res.data.data
        _this.ruleForm.id = post.id
        _this.ruleForm.title = post.title
        _this.ruleForm.description = post.description
        _this.ruleForm.content = post.content
      })
    }
  }
}
</script>

<style>

</style>
```

## 3.4 博客页面 - 博客详情

- 基于 Vue 的 markdown 编辑器（解析）：markdown-it、github-markdown-css

```text
a.安装
    cd D:\software_ware\workspace_idea\blog-tiny\blog-tiny-vue
    cnpm install markdown-it --save                # 用于解析md文档
    cnpm install github-markdown-css               # 用于解析md样式
    yarn add markdown-it                           # 用于解析md文档
    yarn add github-markdown-css                   # 用于解析md样式
b.配置
    无
c.使用
    /views/PostDetail.vue
    ------------------------------------------------------------
    <template>
      <div>
        <div>
          <!--使用【解析md样式、解析md文档】-->
          <div class="markdown-body" v-html="post.content"></div>
        </div>
      </div>
    </template>

    <script>
    /*配置【解析md样式】*/
    import 'github-markdown-css'

    export default {
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

          /*配置【解析md文档】*/
          var MardownIt = require("markdown-it")
          var md = new MardownIt()
          var result = md.render(post.content)
          _this.post.content = result

          _this.editButton = (post.userId === _this.$store.getters.GET_USERINFO.id)
        })
      }
    }
    </script>
```

- `/views/PostDetail.vue` ：博客详情

```vue
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
```
