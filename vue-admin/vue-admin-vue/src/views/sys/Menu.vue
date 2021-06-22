<template>
  <div>
    <!-- 1.【Form 表单：行内表单】 -->
    <el-form :inline="true">
      <el-form-item>
        <el-button type="primary" size="mini" @click="addOneMenu">新增一行</el-button>
      </el-form-item>
    </el-form>

    <!-- 2.【Table 表格：树形数据与懒加载】 -->
    <el-table :data="tableMenuData" row-key="id" border stripe size="small" default-expand-all>
      <el-table-column prop="title" label="标题" sortable width="180px"></el-table-column>
      <el-table-column prop="path" label="路径" width="120px"> </el-table-column>
      <el-table-column prop="icon" label="图标" width="160px"></el-table-column>
      <el-table-column prop="perms" label="权限" width="160px"></el-table-column>
      <el-table-column prop="component" label="组件" width="100px"> </el-table-column>

      <el-table-column prop="sorted" label="排列" width="70px"> </el-table-column>
      <el-table-column prop="type" label="类型" width="85px">
        <!-- 【Table 表格：插槽slot】 -->
        <template v-slot="scope">
          <!-- 【Tag 标签】 -->
          <el-tag v-if="scope.row.type === 0" size="small">目录</el-tag>
          <el-tag v-else-if="scope.row.type === 1" size="small" type="success">菜单</el-tag>
          <el-tag v-else-if="scope.row.type === 2" size="small" type="info">按钮</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="85px">
        <!-- 【Table 表格：插槽slot】 -->
        <template v-slot="scope">
          <!-- 【Tag 标签】 -->
          <el-tag v-if="scope.row.status === 0" size="small" type="success">正常</el-tag>
          <el-tag v-else-if="scope.row.status === 1" size="small" type="danger">禁用</el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作">
        <!-- 【Table 表格：插槽slot】 -->
        <template v-slot="scope">
          <!-- 【Button 按钮：基础用法】 -->
          <el-button type="primary" size="mini" @click="updateOneMenu(scope.row.id)"
            >编辑该行</el-button
          >
          <!-- 【Divider 分割线：垂直分割】-->
          <el-divider direction="vertical"></el-divider>
          <!-- 【Popconfirm 气泡确认框：基础用法】 -->
          <el-popconfirm title="是否删除当前行内容？" @confirm="deleteOneMenu(scope.row.id)">
            <el-button slot="reference" type="danger" size="mini">删除该行</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <!-- 3.【Dialog 对话框：基本用法】- 表格数据（该行） -->
    <el-dialog :title="dialogMenuTitle" :visible.sync="dialogMenuVisible" width="600px">
      <!-- 【Form 表单：表单验证】 -->
      <el-form ref="ruleMenuForm" :model="ruleMenuForm" :rules="ruleMenu" label-width="100px">
        <el-form-item label="上级" prop="parentId">
          <!-- Select 选择器：基础用法 -->
          <el-select v-model="ruleMenuForm.parentId" placeholder="请选择上级菜单">
            <template v-for="item in tableMenuData">
              <el-option :label="item.title" :key="item.id" :value="item.id"></el-option>
              <template v-for="child in item.children">
                <el-option :label="child.title" :key="child.id" :value="child.id">
                  <span>{{ '- ' + child.title }}</span>
                </el-option>
              </template>
            </template>
          </el-select>
        </el-form-item>

        <el-form-item label="名称" prop="name" label-width="100px">
          <!-- 【Input 输入框：基础用法】 -->
          <el-input v-model="ruleMenuForm.title" placeholder="请输入菜单标题"></el-input>
        </el-form-item>
        <el-form-item label="路径" prop="path" label-width="100px">
          <!-- 【Input 输入框：基础用法】 -->
          <el-input v-model="ruleMenuForm.path" placeholder="请输入菜单路径"></el-input>
        </el-form-item>
        <el-form-item label="图标" prop="icon" label-width="100px">
          <!-- 【Input 输入框：基础用法】 -->
          <el-input v-model="ruleMenuForm.icon" placeholder="请输入菜单图标"></el-input>
        </el-form-item>
        <el-form-item label="权限" prop="perms" label-width="100px">
          <!-- 【Input 输入框：基础用法】 -->
          <el-input v-model="ruleMenuForm.perms" placeholder="请输入菜单权限"></el-input>
        </el-form-item>
        <el-form-item label="组件" prop="component" label-width="100px">
          <!-- 【Input 输入框：基础用法】 -->
          <el-input v-model="ruleMenuForm.component" placeholder="请输入菜单组件"></el-input>
        </el-form-item>

        <el-form-item label="排列" prop="sorted" label-width="100px">
          <!-- 【InputNumber 计数器：基础用法】 -->
          <el-input-number v-model="ruleMenuForm.sorted" :min="1" label="排序号">1</el-input-number>
        </el-form-item>

        <el-form-item label="类型" prop="type" label-width="100px">
          <!-- 【Radio 单选框：单选框组】 -->
          <el-radio-group v-model="ruleMenuForm.type" size="small">
            <el-radio :label="0">目录</el-radio>
            <el-radio :label="1">菜单</el-radio>
            <el-radio :label="2">按钮</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="状态" prop="status" label-width="100px">
          <!-- 【Radio 单选框：单选框组】 -->
          <el-radio-group v-model="ruleMenuForm.status" size="small">
            <el-radio :label="0">正常</el-radio>
            <el-radio :label="1">禁用</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item>
          <!-- 【Button 按钮：基础用法】 -->
          <el-button type="primary" size="mini" @click="submitMenuForm('ruleMenuForm')"
            >提交</el-button
          >
          <el-button type="success" size="mini" @click="resetMenuForm('ruleMenuForm')"
            >重置</el-button
          >
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'SysMenu',
  data() {
    return {
      /* 1.【Form 表单：行内表单】 */

      /* 2.【Table 表格：树形数据与懒加载】 */
      tableMenuData: [],

      /* 3.【Dialog 对话框：基本用法】- 表格数据（该行） */
      dialogMenuVisible: false,
      dialogMenuTitle: '',
      ruleMenuForm: {},
      ruleMenu: {
        parentId: [{ required: true, message: '请选择上级', trigger: 'blur' }],
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        perms: [{ required: true, message: '请输入权限', trigger: 'blur' }],
        sorted: [{ required: true, message: '请选择排列', trigger: 'blur' }],
        type: [{ required: true, message: '请选择类型', trigger: 'blur' }],
        status: [{ required: true, message: '请选择状态', trigger: 'blur' }],
      },
    }
  },
  created() {
    this.queryAllMenu()
  },
  methods: {
    /* 1.【Form 表单：行内表单】 */
    addOneMenu() {
      this.ruleMenuForm = {
        parentId: '',
        name: '',
        title: '',
        path: '',
        icon: '',
        perms: '',
        component: '',
        sorted: '',
        type: '',
        status: '',
      }
      this.dialogMenuTitle = '新增一行'
      this.dialogMenuVisible = true
    },

    /* 2.【Table 表格：树形数据与懒加载】 */
    queryAllMenu() {
      this.$axios.get('/sys/menu/list').then((res) => {
        this.tableMenuData = res.data.data
      })
    },
    updateOneMenu(id) {
      this.$axios.get('/sys/menu/info/' + id).then((res) => {
        this.ruleMenuForm = res.data.data
        this.dialogMenuTitle = '编辑该行'
        this.dialogMenuVisible = true
      })
    },
    deleteOneMenu(id) {
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
            this.queryAllMenu()
          },
        })
      })
    },

    /* 3.【Dialog 对话框：基本用法】- 表格数据（该行） */
    submitMenuForm(ruleMenuForm) {
      this.$refs[ruleMenuForm].validate((valid) => {
        if (valid) {
          /* 方法共用：通过判断【this.ruleMenuForm.id】是否存在，区分 update 还是 save 请求 */
          this.$axios
            .post('/sys/menu/' + (this.ruleMenuForm.id ? 'update' : 'save'), this.ruleMenuForm)
            .then((res) => {
              /* 【Message 消息提示：可关闭】 */
              this.$message({
                showClose: true,
                message: '操作成功！',
                type: 'success',
                center: true,
                onClose: () => {
                  /* 关闭时的回调函数, 参数为被关闭的 message 实例 */
                  this.queryAllMenu()
                },
              })
              this.dialogMenuVisible = false
            })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    resetMenuForm(ruleMenuForm) {
      this.$refs[ruleMenuForm].resetFields()
      this.ruleMenuForm = {
        parentId: '',
        name: '',
        title: '',
        path: '',
        icon: '',
        perms: '',
        component: '',
        sorted: '',
        type: '',
        status: '',
      }
    },
  },
}
</script>
