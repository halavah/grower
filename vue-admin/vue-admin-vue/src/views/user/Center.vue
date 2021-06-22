<template>
  <div style="text-align: center">
    <h2>欢迎！{{ userInfo.username }} 用户</h2>

    <!-- 【Form 表单：自定义校验规则】 -->
    <el-form :model="passForm" status-icon :rules="rules" label-width="100px">
      <el-form-item label="旧密码" prop="currentPass">
        <el-input v-model="passForm.currentPass" type="password" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="新密码" prop="password">
        <el-input v-model="passForm.password" type="password" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="确认密码" prop="checkPass">
        <el-input v-model="passForm.checkPass" type="password" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('passForm')">提交</el-button>
        <el-button @click="resetForm('passForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: 'UserCenter',

  data() {
    let validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'))
      } else if (value !== this.passForm.password) {
        callback(new Error('两次输入密码不一致!'))
      } else {
        callback()
      }
    }
    return {
      passForm: {
        password: '123456',
        checkPass: '123456',
        currentPass: '123456',
      },
      rules: {
        password: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
          {
            min: 6,
            max: 12,
            message: '长度在 6 到 12 个字符',
            trigger: 'blur',
          },
        ],
        checkPass: [{ required: true, validator: validatePass, trigger: 'blur' }],
        currentPass: [{ required: true, message: '请输入当前密码', trigger: 'blur' }],
      },
    }
  },

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
    submitForm(passForm) {
      this.$refs[passForm].validate((valid) => {
        if (valid) {
          this.$axios.post('/sys/user/updatePass', this.passForm).then((res) => {
            const _this = this
            /* 【MessageBox 弹框：消息提示】 */
            _this.$alert(res.data.msg, '提示', {
              confirmButtonText: '确定',
              callback: (action) => {
                this.$refs[passForm].resetFields()
                this.$message({
                  message: '修改密码成功！！！',
                  type: 'success',
                })
              },
            })
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    resetForm(passForm) {
      this.$refs[passForm].resetFields()
    },
  },
}
</script>

<style scoped>
.el-form {
  width: 420px;
  margin: 50px auto;
}
</style>
