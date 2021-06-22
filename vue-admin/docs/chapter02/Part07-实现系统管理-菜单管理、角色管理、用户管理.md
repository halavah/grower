# Part07-实现系统管理-菜单管理、角色管理、用户管理

```text
vue-admin-vue
│
└─src
    │
    └─views
        ├─sys
        │      Menu.vue         # 7.1 系统管理 - 菜单管理
        │      Role.vue         # 7.2 系统管理 - 角色管理
        │      User.vue         # 7.3 系统管理 - 用户管理
        │
        └─user
                Center.vue      # 7.4 个人中心 - 修改密码
```

## 7.1 系统管理 - 菜单管理

- `/views/sys/Menu.vue` ：菜单管理

```vue
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
```

## 7.2 系统管理 - 角色管理

- `/views/sys/Role.vue` ：角色管理

```vue
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
```

## 7.3 系统管理 - 用户管理

- `/views/sys/User.vue` ：用户管理

```vue
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
```

## 7.4 个人中心 - 修改密码

- `/views/user/Center.vue` ：修改密码

```vue
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
```
