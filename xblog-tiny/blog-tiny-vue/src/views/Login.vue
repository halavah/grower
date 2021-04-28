<template>
  <div>
    <el-container>
      <el-header>
        <img class="logo" src="https://www.markerhub.com/dist/images/logo/markerhub-logo.png">
      </el-header>
      <el-main>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="ruleForm.username"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input type="password" v-model="ruleForm.password"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
            <el-button @click="resetForm('ruleForm')">重置</el-button>
          </el-form-item>
        </el-form>
      </el-main>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "Login",

  data() {
    return {
      ruleForm: {
        username: 'admin',
        password: '123456',
      },
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 3, max: 15, message: '长度在 3 到 15 个字符', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'change'},
        ],
      }
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          const _this = this

          // axios.js 中 axios.defaults.baseURL + /login 等同于 http://localhost:8765/login
          this.$axios.post('/login', this.ruleForm).then(res => {
            //请求后的数据
            console.log(res.data)
            console.log(res.headers)

            const token = res.headers['authorization']
            const userInfo = res.data.data

            //调用vuex中的set方法
            _this.$store.commit("SET_TOKEN", token);
            _this.$store.commit("SET_USERINFO", userInfo);

            //获取vuex中的get方法
            console.log(_this.$store.getters.GET_TOKEN);
            console.log(_this.$store.getters.GET_USERINFO);
            console.log(_this.$store.getters.GET_USERINFO.avatar);
            console.log(_this.$store.getters.GET_USERINFO.username);

            //跳转页面
            _this.$router.push("/");
          })

        } else {
          console.log('登录失败！！！');
          return false;
        }
      });
    },

    resetForm(formName) {
      this.$refs[formName].resetFields();
    }

  }
}
</script>

<style>
.el-header, .el-footer {
  background-color: #B3C0D1;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.el-aside {
  background-color: #D3DCE6;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  color: #333;
  text-align: center;
  line-height: 160px;
}

body > .el-container {
  margin-bottom: 40px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
  line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
  line-height: 320px;
}

/*----------------自定义样式----------------*/
.logo {
  height: 60%;
  margin-top: 10px;
}

.demo-ruleForm {
  max-width: 500px;
  margin: 0 auto;
}

</style>