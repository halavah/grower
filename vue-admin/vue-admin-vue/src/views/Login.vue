<template>
  <div>
    <!-- 【Form 表单：自定义校验规则】 -->
    <el-form ref="ruleLoginForm" :rules="ruleLogin" :model="ruleLoginForm" class="loginContainer">
      <h3 class="loginTitle">用户登录</h3>

      <el-form-item prop="username">
        <el-input
          v-model="ruleLoginForm.username"
          size="normal"
          type="text"
          auto-complete="off"
          placeholder="请输入用户名"
        ></el-input>
      </el-form-item>

      <el-form-item prop="password">
        <el-input
          v-model="ruleLoginForm.password"
          size="normal"
          type="password"
          auto-complete="off"
          placeholder="请输入密码"
        ></el-input>
      </el-form-item>

      <el-form-item prop="code">
        <el-input
          v-model="ruleLoginForm.code"
          maxlength="5"
          style="width: 262px; float: left"
        ></el-input>
        <el-image :src="codeBase64Image" class="codeBase64Image" @click="getCaptcha"></el-image>
      </el-form-item>

      <!-- 【Checkbox 多选框：基础用法】 -->
      <el-checkbox v-model="checked" size="normal" class="loginRemember">点击记住我</el-checkbox>

      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleLoginForm')">登录</el-button>
        <el-button @click="resetForm('ruleLoginForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import qs from 'qs'

export default {
  name: 'Login',

  data() {
    return {
      ruleLoginForm: {
        username: 'admin',
        password: '123456',
        code: '',
        key: '',
      },
      ruleLogin: {
        username: [
          {
            required: true,
            message: '请输入用户名',
            trigger: 'blur',
          },
        ],
        password: [
          {
            required: true,
            message: '请输入密码',
            trigger: 'blur',
          },
        ],
        code: [
          {
            required: true,
            message: '请输入验证码',
            trigger: 'blur',
          },
          {
            min: 5,
            max: 5,
            message: '长度为 5 个字符',
            trigger: 'blur',
          },
        ],
      },
      checked: true,
      codeBase64Image: null,
    }
  },

  created() {
    this.getCaptcha()
  },

  methods: {
    submitForm(ruleLoginForm) {
      this.$refs[ruleLoginForm].validate((valid) => {
        if (valid) {
          this.$axios.post('/doLogin?' + qs.stringify(this.ruleLoginForm)).then((res) => {
            // 1.Post请求：获取jwt并存放到vuex
            const jwt = res.headers['authorization']
            this.$store.commit('SET_TOKEN', jwt)

            // // 2.Get请求：获取userInfo并存放到vuex
            // this.$axios.get('/sys/userInfo').then((res) => {
            //   this.$store.commit('SET_USERINFO', res.data.data)
            // })

            // 3.跳转主页
            // this.$router.push('/')
          })
        } else {
          return false
        }
      })
    },

    resetForm(ruleLoginForm) {
      this.$refs[ruleLoginForm].resetFields()
    },

    getCaptcha() {
      this.$axios.get('/captcha').then((res) => {
        this.ruleLoginForm.key = res.data.data.key
        this.codeBase64Image = res.data.data.codeBase64Image
        this.ruleLoginForm.code = ''
      })
    },
  },
}
</script>

<style>
.loginContainer {
  border-radius: 15px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 15px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}

.loginTitle {
  margin: 15px auto 20px auto;
  text-align: center;
}

.loginRemember {
  text-align: left;
  margin: 0px 0px 15px 0px;
}

.codeBase64Image {
  width: 80px;
  float: left;
  margin-left: 8px;
  border-radius: 4px;
}
</style>
