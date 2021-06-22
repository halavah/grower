<template>
  <div>
    <!-- 1.【Form 表单：行内表单】 -->
    <el-form :inline="true" :model="formInline">
      <el-form-item>
        <el-input
          v-model="formInline.name"
          size="mini"
          placeholder="请输入名称"
          clearable
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="success" size="mini" @click="querySomeRole">搜索</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" size="mini" @click="addOneRole">新增一行</el-button>
      </el-form-item>
      <el-form-item>
        <el-popconfirm title="确定批量删除吗？？" @confirm="deleteSomeRole">
          <el-button slot="reference" type="danger" size="mini" :disabled="deleteSomeStatus"
            >批量删除</el-button
          >
        </el-popconfirm>
      </el-form-item>
    </el-form>

    <!-- 2.【Table 表格：多选】 -->
    <el-table
      ref="multipleTable"
      :data="tableRoleData"
      tooltip-effect="dark"
      border
      stripe
      size="small"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"></el-table-column>

      <el-table-column prop="name" label="名称" width="120"></el-table-column>
      <el-table-column prop="code" label="编码" width="120"></el-table-column>
      <el-table-column prop="remark" label="描述" width="300"></el-table-column>

      <el-table-column prop="menu" label="菜单" width="200">
        <template v-slot="scope">
          <el-tag
            v-for="(item, index) in scope.row.menuIds"
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
          <el-button type="success" size="mini" @click="updateRoleMenu(scope.row.id)"
            >关联表（角色-菜单）</el-button
          >
          <el-divider direction="vertical"></el-divider>
          <el-button type="primary" size="mini" @click="updateOneRole(scope.row.id)"
            >编辑该行</el-button
          >
          <el-divider direction="vertical"></el-divider>
          <span>
            <el-popconfirm title="是否删除当前行内容？" @confirm="deleteOneRole(scope.row.id)">
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
    <el-dialog :title="dialogRoleTitle" :visible.sync="dialogRoleVisible" width="600px">
      <el-form ref="ruleRoleForm" :model="ruleRoleForm" :rules="ruleRole" label-width="100px">
        <el-form-item label="名称" prop="name" label-width="100px">
          <el-input v-model="ruleRoleForm.name" placeholder="请输入角色名称"></el-input>
        </el-form-item>
        <el-form-item label="编码" prop="code" label-width="100px">
          <el-input v-model="ruleRoleForm.code" placeholder="请输入角色编码"></el-input>
        </el-form-item>
        <el-form-item label="描述" prop="remark" label-width="100px">
          <el-input v-model="ruleRoleForm.remark" placeholder="请输入角色描述"></el-input>
        </el-form-item>

        <el-form-item label="状态" prop="status" label-width="100px">
          <el-radio-group v-model="ruleRoleForm.status">
            <el-radio :label="0">正常</el-radio>
            <el-radio :label="1">禁用</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" size="mini" @click="submitRoleForm('ruleRoleForm')"
            >提交</el-button
          >
          <el-button type="success" size="mini" @click="resetRoleForm('ruleRoleForm')"
            >重置</el-button
          >
        </el-form-item>
      </el-form>
    </el-dialog>

    <!-- 5.【Dialog 对话框：基本用法】- 关联表（角色-菜单） -->
    <el-dialog :title="dialogRoleMenuTitle" :visible.sync="dialogRoleMenuVisible" width="600px">
      <el-form :model="ruleRoleMenuForm">
        <!-- 【Tree 树形控件：树节点的选择】 -->
        <el-tree
          ref="tree"
          :data="menuTree"
          show-checkbox
          default-expand-all
          node-key="id"
          :check-strictly="true"
          :props="defaultProps"
        >
        </el-tree>
      </el-form>
      <span class="dialog-footer">
        <el-button type="primary" size="mini" @click="submitRoleMenuForm('ruleRoleMenuForm')"
          >确 定</el-button
        >
        <el-button type="success" size="mini" @click="resetRoleMenuForm">取 消</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'SysRole',
  data() {
    return {
      /* 1.【Form 表单：行内表单】 */
      formInline: {
        name: '',
      },
      deleteSomeStatus: true,

      /* 2.【Table 表格：多选】 */
      tableRoleData: [],
      multipleSelection: [],

      /* 3.【Pagination 分页：完整功能】 */
      current: 1,
      size: 10,
      total: 0,

      /* 4.【Dialog 对话框：基本用法】- 表格数据（该行） */
      dialogRoleVisible: false,
      dialogRoleTitle: '',
      ruleRoleForm: {},
      ruleRole: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        code: [{ required: true, message: '请输入编码', trigger: 'blur' }],
        status: [{ required: true, message: '请选择状态', trigger: 'blur' }],
      },

      /* 5.【Dialog 对话框：基本用法】- 关联表（角色-菜单） */
      dialogRoleMenuVisible: false,
      dialogRoleMenuTitle: '',
      ruleRoleMenuForm: {},
      /* 【Tree 树形控件：树节点的选择】 */
      menuTree: [],
      defaultProps: {
        children: 'children',
        label: 'title',
      },
    }
  },
  created() {
    this.queryAllRole()
    this.queryAllMenu()
  },
  methods: {
    /* 1.【Form 表单：行内表单】 */
    querySomeRole() {
      this.$axios
        .get('/sys/role/list', {
          params: {
            name: this.formInline.name,
            current: this.current,
            size: this.size,
          },
        })
        .then((res) => {
          this.tableRoleData = res.data.data.records
          this.size = res.data.data.size
          this.current = res.data.data.current
          this.total = res.data.data.total
        })
    },
    addOneRole() {
      this.ruleRoleForm = {
        name: '',
        code: '',
        remark: '',
        status: '',
      }
      this.dialogRoleTitle = '新增一行'
      this.dialogRoleVisible = true
    },
    deleteSomeRole() {
      let ids = []
      this.multipleSelection.forEach((row) => {
        ids.push(row.id)
      })
      this.$axios.post('/sys/role/delete', ids).then((res) => {
        this.$message({
          showClose: true,
          message: '操作成功',
          type: 'success',
          center: true,
          onClose: () => {
            this.queryAllRole()
          },
        })
      })
    },

    /* 2.【Table 表格：多选】 */
    handleSelectionChange(val) {
      this.multipleSelection = val
      this.deleteSomeStatus = val.length == 0 ? true : false
    },
    queryAllRole() {
      this.$axios.get('/sys/role/list').then((res) => {
        this.tableRoleData = res.data.data.records
        this.size = res.data.data.size
        this.current = res.data.data.current
        this.total = res.data.data.total
      })
    },
    updateRoleMenu(id) {
      this.dialogRoleMenuTitle = '关联表（角色-菜单）'
      this.dialogRoleMenuVisible = true
      this.$axios.get('/sys/role/info/' + id).then((res) => {
        this.ruleRoleMenuForm = res.data.data
        /* 【Tree 树形控件：树节点的选择】 */
        this.$refs.tree.setCheckedKeys(res.data.data.menuIds)
      })
    },
    updateOneRole(id) {
      this.$axios.get('/sys/role/info/' + id).then((res) => {
        this.ruleRoleForm = res.data.data
        this.dialogRoleTitle = '编辑该行'
        this.dialogRoleVisible = true
      })
    },
    deleteOneRole(id) {
      let ids = []
      ids.push(id)
      this.$axios.post('/sys/menu/delete/' + ids).then((res) => {
        /* 【Message 消息提示：可关闭】 */
        this.$message({
          showClose: true,
          message: '删除成功！',
          type: 'success',
          center: true,
          onClose: () => {
            /* 关闭时的回调函数, 参数为被关闭的 message 实例 */
            this.queryAllRole()
          },
        })
      })
    },

    /* 3.【Pagination 分页：完整功能】 */
    handleSizeChange(val) {
      this.size = val
      this.queryAllRole()
    },
    handleCurrentChange(val) {
      this.current = val
      this.queryAllRole()
    },

    /* 4.【Dialog 对话框：基本用法】- 表格数据（该行） */
    submitRoleForm(ruleRoleForm) {
      this.$refs[ruleRoleForm].validate((valid) => {
        if (valid) {
          this.$axios
            .post('/sys/role/' + (this.ruleRoleForm.id ? 'update' : 'save'), this.ruleRoleForm)
            .then((res) => {
              this.$message({
                showClose: true,
                message: '操作成功！',
                type: 'success',
                center: true,
                onClose: () => {
                  this.queryAllRole()
                },
              })
              this.dialogRoleVisible = false
            })
        } else {
          return false
        }
      })
    },
    resetRoleForm(ruleRoleForm) {
      this.$refs[ruleRoleForm].resetFields()
      this.ruleRoleForm = {
        name: '',
        code: '',
        remark: '',
        status: '',
      }
    },

    /* 5.【Dialog 对话框：基本用法】- 关联表（角色-菜单） */
    submitRoleMenuForm(ruleRoleMenuForm) {
      let menuIds = this.$refs.tree.getCheckedKeys()
      this.$axios.post('/sys/role/menu/' + this.ruleRoleMenuForm.id, menuIds).then((res) => {
        this.$message({
          showClose: true,
          message: '操作成功！',
          type: 'success',
          center: true,
          onClose: () => {
            this.queryAllRole()
          },
        })
        this.dialogRoleMenuVisible = false
      })
    },
    resetRoleMenuForm() {
      this.dialogRoleMenuVisible = false
    },
    queryAllMenu() {
      this.$axios.get('/sys/menu/list').then((res) => {
        this.menuTree = res.data.data
      })
    },
  },
}
</script>
