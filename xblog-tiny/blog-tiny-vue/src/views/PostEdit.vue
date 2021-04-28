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