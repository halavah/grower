<template>
  <div>
    <!-- 1.【Form 表单：行内表单】 -->
    <el-form :inline="true" :model="formInline">
      <el-form-item>
        <el-input
          v-model="formInline.name"
          placeholder="请输入名称"
          clearable
          size="mini"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="success" size="mini" @click="querySomeUser">搜索</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" size="mini" @click="addOneUser">新增一行</el-button>
      </el-form-item>
      <el-form-item>
        <el-popconfirm title="确定批量删除吗？？" @confirm="deleteSomeUser">
          <el-button slot="reference" type="danger" size="mini" :disabled="deleteSomeStatus"
            >批量删除</el-button
          >
        </el-popconfirm>
      </el-form-item>
    </el-form>

    <!-- 2.【Table 表格：多选】 -->
    <el-table
      ref="multipleTable"
      :data="tableUserData"
      tooltip-effect="dark"
      border
      stripe
      size="small"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"></el-table-column>

      <el-table-column label="头像" width="50">
        <template v-slot="scope">
          <el-avatar size="small" :src="scope.row.avatar"></el-avatar>
        </template>
      </el-table-column>
      <el-table-column prop="username" label="昵称" width="120"></el-table-column>
      <el-table-column prop="email" label="邮箱" width="120"></el-table-column>
      <el-table-column prop="mobile" label="手机" width="120"></el-table-column>

      <el-table-column prop="role" label="角色" width="200">
        <template v-slot="scope">
          <el-tag
            v-for="(item, index) in scope.row.roleIds"
            :key="index"
            size="small"
            type="info"
            >{{ item.name }}</el-tag
          >
        </template>
      </el-table-column>

      <el-table-column prop="status" label="状态" width="120">
        <template v-slot="scope">
          <el-tag v-if="scope.row.status === 0" size="small" type="success">正常</el-tag>
          <el-tag v-else-if="scope.row.status === 1" size="small" type="danger">禁用</el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作">
        <template v-slot="scope">
          <el-button
            type="warning"
            size="mini"
            @click="updatePassUser(scope.row.id, scope.row.username)"
            >重置密码</el-button
          >
          <el-divider direction="vertical"></el-divider>
          <el-button type="success" size="mini" @click="updateUserRole(scope.row.id)"
            >关联表（用户-角色）</el-button
          >
          <el-divider direction="vertical"></el-divider>
          <el-button type="primary" size="mini" @click="updateOneUser(scope.row.id)"
            >编辑该行</el-button
          >
          <el-divider direction="vertical"></el-divider>
          <span>
            <el-popconfirm title="是否删除当前行内容？" @confirm="deleteOneUser(scope.row.id)">
              <el-button slot="reference" type="danger" size="mini">删除该行</el-button>
            </el-popconfirm>
          </span>
        </template>
      </el-table-column>
    </el-table>

    <!-- 3.【Pagination 分页：完整功能】 -->
    <el-pagination
      style="margin-top: 10px"
      layout="total, sizes, prev, pager, next, jumper"
      :page-sizes="[10, 20, 50, 100]"
      :current-page="current"
      :page-size="size"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    >
    </el-pagination>

    <!-- 4.【Dialog 对话框：基本用法】- 表格数据（该行）-->
    <el-dialog :title="dialogUserTitle" :visible.sync="dialogUserVisible" width="600px">
      <el-form ref="ruleUserForm" :model="ruleUserForm" :rules="ruleUser" label-width="100px">
        <el-form-item label="昵称" prop="username" label-width="100px">
          <el-input v-model="ruleUserForm.username" placeholder="请输入用户昵称"></el-input>
        </el-form-item>
        <el-form-item label="密码" label-width="100px">
          <el-alert title="初始密码为123456" :closable="false" style="line-height: 12px"></el-alert>
        </el-form-item>
        <el-form-item label="邮箱" prop="email" label-width="100px">
          <el-input v-model="ruleUserForm.email" placeholder="请输入用户邮箱"></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="mobile" label-width="100px">
          <el-input v-model="ruleUserForm.mobile" placeholder="请输入用户手机"></el-input>
        </el-form-item>

        <el-form-item label="状态" prop="status" label-width="100px">
          <el-radio-group v-model="ruleUserForm.status">
            <el-radio :label="0">正常</el-radio>
            <el-radio :label="1">禁用</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" size="mini" @click="submitUserForm('ruleUserForm')"
            >提交</el-button
          >
          <el-button type="success" size="mini" @click="resetUserForm('ruleUserForm')"
            >重置</el-button
          >
        </el-form-item>
      </el-form>
    </el-dialog>

    <!-- 5.【Dialog 对话框：基本用法】- 关联表（用户-角色） -->
    <el-dialog :title="dialogUserRoleTitle" :visible.sync="dialogUserRoleVisible" width="600px">
      <el-form :model="ruleUserRoleForm">
        <!-- 【Tree 树形控件：树节点的选择】 -->
        <el-tree
          ref="tree"
          :data="roleTree"
          show-checkbox
          default-expand-all
          node-key="id"
          :check-strictly="true"
          :props="defaultProps"
        >
        </el-tree>
      </el-form>
      <span class="dialog-footer">
        <el-button type="primary" size="mini" @click="submitUserRoleForm('ruleUserRoleForm')"
          >确 定</el-button
        >
        <el-button type="success" size="mini" @click="resetUserRoleForm">取 消</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'SysUser',
  data() {
    return {
      /* 1.【Form 表单：行内表单】 */
      formInline: {
        name: '',
      },
      deleteSomeStatus: true,

      /* 2.【Table 表格：多选】 */
      tableUserData: [],
      multipleSelection: [],

      /* 3.【Pagination 分页：完整功能】 */
      current: 1,
      size: 10,
      total: 0,

      /* 4.【Dialog 对话框：基本用法】- 表格数据（该行） */
      dialogUserVisible: false,
      dialogUserTitle: '',
      ruleUserForm: {},
      ruleUser: {
        username: [{ required: true, message: '请输入用户昵称', trigger: 'blur' }],
        email: [{ required: true, message: '请输入用户邮箱', trigger: 'blur' }],
        mobile: [{ required: true, message: '请输入用户手机', trigger: 'blur' }],
        status: [{ required: true, message: '请选择用户状态', trigger: 'blur' }],
      },

      /* 5.【Dialog 对话框：基本用法】- 关联表（用户-角色） */
      dialogUserRoleVisible: false,
      dialogUserRoleTitle: '',
      ruleUserRoleForm: {},
      /* 【Tree 树形控件：树节点的选择】 */
      roleTree: [],
      defaultProps: {
        children: 'children',
        label: 'name',
      },
    }
  },
  created() {
    this.queryAllUser()
    this.queryAllRole()
  },
  methods: {
    /* 1.【Form 表单：行内表单】 */
    querySomeUser() {
      this.$axios
        .get('/sys/user/list', {
          params: {
            name: this.formInline.name,
            current: this.current,
            size: this.size,
          },
        })
        .then((res) => {
          this.tableUserData = res.data.data.records
          this.size = res.data.data.size
          this.current = res.data.data.current
          this.total = res.data.data.total
        })
    },
    addOneUser() {
      this.ruleUserForm = {
        username: '',
        email: '',
        mobile: '',
        status: '',
      }
      this.dialogUserTitle = '新增一行'
      this.dialogUserVisible = true
    },
    deleteSomeUser() {
      let ids = []
      this.multipleSelection.forEach((row) => {
        ids.push(row.id)
      })
      this.$axios.post('/sys/user/delete', ids).then((res) => {
        this.$message({
          showClose: true,
          message: '操作成功',
          type: 'success',
          center: true,
          onClose: () => {
            this.getRoleList()
          },
        })
      })
    },

    /* 2.【Table 表格：多选】 */
    handleSelectionChange(val) {
      this.multipleSelection = val
      this.deleteSomeStatus = val.length == 0 ? true : false
    },
    queryAllUser() {
      this.$axios.get('/sys/user/list').then((res) => {
        this.tableUserData = res.data.data.records
        this.size = res.data.data.size
        this.current = res.data.data.current
        this.total = res.data.data.total
      })
    },
    updateUserRole(id) {
      this.dialogUserRoleTitle = '关联表（用户-角色）'
      this.dialogUserRoleVisible = true
      this.$axios.get('/sys/user/info/' + id).then((res) => {
        this.ruleUserRoleForm = res.data.data
        this.$refs.tree.setCheckedKeys(res.data.data.roleIds) // 【Tree 树形控件：树节点的选择】
      })
    },
    updatePassUser(id, username) {
      this.$confirm('将重置用户【' + username + '】的密码, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      })
        .then(() => {
          this.$axios.post('/sys/user/repass', id).then((res) => {
            this.$message({
              showClose: true,
              message: '操作成功',
              type: 'success',
              center: true,
              onClose: () => {},
            })
          })
        })
        .catch(() => {
          this.$message({
            type: 'info',
            message: '取消操作',
            center: true,
          })
        })
    },
    updateOneUser(id) {
      this.$axios.get('/sys/user/info/' + id).then((res) => {
        this.ruleUserForm = res.data.data
        this.dialogUserTitle = '编辑该行'
        this.dialogUserVisible = true
      })
    },
    deleteOneUser(id) {
      let ids = []
      ids.push(id)
      this.$axios.post('/sys/user/delete/' + ids).then((res) => {
        /* 【Message 消息提示：可关闭】 */
        this.$message({
          showClose: true,
          message: '删除成功！',
          type: 'success',
          center: true,
          onClose: () => {
            /* 关闭时的回调函数, 参数为被关闭的 message 实例 */
            this.queryAllUser()
          },
        })
      })
    },

    /* 3.【Pagination 分页：完整功能】 */
    handleSizeChange(val) {
      this.size = val
      this.queryAllUser()
    },
    handleCurrentChange(val) {
      this.current = val
      this.queryAllUser()
    },

    /* 4.【Dialog 对话框：基本用法】- 表格数据（该行） */
    submitUserForm(ruleUserForm) {
      this.$refs[ruleUserForm].validate((valid) => {
        if (valid) {
          this.$axios
            .post('/sys/user/' + (this.ruleUserForm.id ? 'update' : 'save'), this.ruleUserForm)
            .then((res) => {
              this.$message({
                showClose: true,
                message: '操作成功！',
                type: 'success',
                center: true,
                onClose: () => {
                  this.queryAllUser()
                },
              })
              this.dialogUserVisible = false
            })
        } else {
          return false
        }
      })
    },
    resetUserForm(ruleUserForm) {
      this.$refs[ruleUserForm].resetFields()
      this.ruleUserForm = {
        username: '',
        email: '',
        mobile: '',
        status: '',
      }
    },

    /* 5.【Dialog 对话框：基本用法】- 关联表（用户-角色） */
    submitUserRoleForm(ruleUserRoleForm) {
      let roleIds = this.$refs.tree.getCheckedKeys()
      this.$axios.post('/sys/user/role/' + this.ruleUserRoleForm.id, roleIds).then((res) => {
        this.$message({
          showClose: true,
          message: '操作成功！',
          type: 'success',
          center: true,
          onClose: () => {
            this.queryAllUser()
          },
        })
        this.dialogUserRoleVisible = false
      })
    },
    resetUserRoleForm() {
      this.dialogUserRoleVisible = false
    },
    queryAllRole() {
      this.$axios.get('/sys/role/list').then((res) => {
        this.roleTree = res.data.data.records
      })
    },
  },
}
</script>
