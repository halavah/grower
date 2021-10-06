// ? 内容：模拟数据（测试URL），根据【不同URL】响应【模拟数据】

const Mock = require('mockjs')

let Result = {
  code: 200,
  msg: '操作成功',
  data: null,
}

// ***************登录/登出/验证码*****************

// 登录
Mock.mock('/doLogin', 'post', () => {
  // 此处token并不是真实从【res.headers['authorization']】获取的jwt，只是为了【测试携带token的/login请求】
  Result.data = {
    token: Mock.Random.string(32),
  }
  return Result
})

// 登出
Mock.mock('/doLogout', 'post', () => {
  return Result
})

// 验证码
Mock.mock('/captcha', 'get', () => {
  Result.data = {
    key: Mock.Random.string(32),
    codeBase64Image: Mock.Random.dataImage('120x60', 'p7n5w'),
  }
  return Result
})

// *******************用户信息********************

// 用户信息
Mock.mock('/sys/user/info', 'get', () => {
  Result.data = {
    id: '1',
    username: 'admin',
    avatar: 'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',
  }
  return Result
})

// 动态菜单以及权限接口
Mock.mock('/sys/menu/nav', 'get', () => {
  let nav = [
    {
      id: 1,
      parentId: 0,
      name: 'SysManage',
      title: '系统管理',
      path: '',
      icon: 'el-icon-s-operation',
      perms: 'sys:manage',
      component: '',
      sorted: 1,
      type: 0,
      status: 0,
      created: '2021-01-15T18:58:18',
      modified: '2021-01-15T18:58:20',
      children: [
        {
          id: 2,
          parentId: 1,
          name: 'SysUser',
          title: '用户管理',
          path: '/sys/users',
          icon: 'el-icon-s-custom',
          perms: 'sys:user:list',
          component: 'sys/User',
          sorted: 1,
          type: 1,
          status: 0,
          created: '2021-01-15T19:03:45',
          modified: '2021-01-15T19:03:48',
          children: [],
        },
        {
          id: 3,
          parentId: 1,
          name: 'SysRole',
          title: '角色管理',
          path: '/sys/roles',
          icon: 'el-icon-rank',
          perms: 'sys:role:list',
          component: 'sys/Role',
          sorted: 6,
          type: 1,
          status: 0,
          created: '2021-01-15T19:03:45',
          modified: '2021-01-15T19:03:48',
          children: [],
        },
        {
          id: 4,
          parentId: 1,
          name: 'SysMenu',
          title: '菜单管理',
          path: '/sys/menus',
          icon: 'el-icon-menu',
          perms: 'sys:menu:list',
          component: 'sys/Menu',
          sorted: 7,
          type: 1,
          status: 0,
          created: '2021-01-15T19:03:45',
          modified: '2021-01-15T19:03:48',
          children: [],
        },
      ],
    },
    {
      id: 5,
      parentId: 0,
      name: 'SysTools',
      title: '系统工具',
      path: '',
      icon: 'el-icon-s-tools',
      perms: 'sys:tools',
      component: null,
      sorted: 8,
      type: 0,
      status: 0,
      created: '2021-01-15T19:06:11',
      modified: '2021-01-18T16:32:13',
      children: [
        {
          id: 6,
          parentId: 1,
          name: '数字字典',
          path: '/sys/dicts',
          icon: 'el-icon-s-order',
          perms: 'sys:dict:list',
          component: 'sys/Dict',
          sorted: 9,
          type: 1,
          status: 0,
          created: '2021-01-15T19:07:18',
          modified: '2021-01-18T16:32:13',
          children: [],
        },
      ],
    },
  ]
  let authoritys = ['sys:user:list', 'sys:user:save', 'sys:user:delete']
  Result.data = {
    nav: nav,
    authoritys: authoritys,
  }
  return Result
})

// *******************菜单管理********************

// 查看【全部】菜单 或 搜索【部分】菜单
Mock.mock('/sys/menu/list', 'get', () => {
  let menus = [
    {
      id: 1,
      parentId: 0,
      name: 'SysManage',
      title: '系统管理',
      path: '',
      icon: 'el-icon-s-operation',
      perms: 'sys:manage',
      component: '',
      sorted: 1,
      type: 0,
      status: 0,
      created: '2021-01-15T18:58:18',
      modified: '2021-01-15T18:58:20',
      children: [
        {
          id: 2,
          parentId: 1,
          name: 'SysUser',
          title: '用户管理',
          path: '/sys/users',
          icon: 'el-icon-s-custom',
          perms: 'sys:user:list',
          component: 'sys/User',
          sorted: 1,
          type: 1,
          status: 0,
          created: '2021-01-15T19:03:45',
          modified: '2021-01-15T19:03:48',
          children: [
            {
              id: 9,
              parentId: 2,
              name: 'SysUserAdd',
              title: '添加用户',
              path: null,
              icon: null,
              perms: 'sys:user:save',
              component: null,
              sorted: 1,
              type: 2,
              status: 0,
              created: '2021-01-17T21:48:32',
              modified: '2021-01-15T19:03:48',
              children: [],
            },
            {
              id: 10,
              parentId: 2,
              name: 'SysUserModify',
              title: '修改用户',
              path: null,
              icon: null,
              perms: 'sys:user:update',
              component: null,
              sorted: 2,
              type: 2,
              status: 0,
              created: '2021-01-17T21:49:03',
              modified: '2021-01-17T21:53:04',
              children: [],
            },
            {
              id: 11,
              parentId: 2,
              name: 'SysUserDelete',
              title: '删除用户',
              path: null,
              icon: null,
              perms: 'sys:user:delete',
              component: null,
              sorted: 3,
              type: 2,
              status: 0,
              created: '2021-01-17T21:49:21',
              modified: null,
              children: [],
            },
            {
              id: 12,
              parentId: 2,
              name: 'SysRoleHandle',
              title: '分配角色',
              path: null,
              icon: null,
              perms: 'sys:user:role',
              component: null,
              sorted: 4,
              type: 2,
              status: 0,
              created: '2021-01-17T21:49:58',
              modified: null,
              children: [],
            },
            {
              id: 13,
              parentId: 2,
              name: 'SysUserPass',
              title: '重置密码',
              path: null,
              icon: null,
              perms: 'sys:user:repass',
              component: null,
              sorted: 5,
              type: 2,
              status: 0,
              created: '2021-01-17T21:50:36',
              modified: null,
              children: [],
            },
          ],
        },
        {
          id: 3,
          parentId: 1,
          name: 'SysRole',
          title: '角色管理',
          path: '/sys/roles',
          icon: 'el-icon-rank',
          perms: 'sys:role:list',
          component: 'sys/Role',
          sorted: 6,
          type: 1,
          status: 0,
          created: '2021-01-15T19:03:45',
          modified: '2021-01-15T19:03:48',
          children: [],
        },
        {
          id: 4,
          parentId: 1,
          name: 'SysMenu',
          title: '菜单管理',
          path: '/sys/menus',
          icon: 'el-icon-menu',
          perms: 'sys:menu:list',
          component: 'sys/Menu',
          sorted: 7,
          type: 1,
          status: 0,
          created: '2021-01-15T19:03:45',
          modified: '2021-01-15T19:03:48',
          children: [],
        },
      ],
    },
    {
      id: 5,
      parentId: 0,
      name: 'SysTools',
      title: '系统工具',
      path: '',
      icon: 'el-icon-s-tools',
      perms: 'sys:tools',
      component: null,
      sorted: 8,
      type: 0,
      status: 0,
      created: '2021-01-15T19:06:11',
      modified: '2021-01-18T16:32:13',
      children: [
        {
          id: 7,
          parentId: 1,
          name: 'SysDicts',
          title: '数字字典',
          path: '/sys/dicts',
          icon: 'el-icon-s-order',
          perms: 'sys:dict:list',
          component: 'sys/Dict',
          sorted: 9,
          type: 1,
          status: 0,
          created: '2021-01-15T19:07:18',
          modified: '2021-01-18T16:32:13',
          children: [],
        },
      ],
    },
  ]
  Result.data = menus
  return Result
})

// 查看【某个】菜单
Mock.mock(RegExp('/sys/menu/info/*'), 'get', () => {
  Result.data = {
    id: 3,
    parentId: 1,
    name: '角色管理',
    path: '/sys/roles',
    icon: 'el-icon-rank',
    perms: 'sys:role:list',
    component: 'sys/Role',
    sorted: 2,
    type: 1,
    status: 0,
    created: '2021-01-15T19:03:45',
    modified: '2021-01-15T19:03:48',
    children: [],
  }
  return Result
})

// 添加【某个】菜单 或 更新【某个】菜单 或 删除【某个/多个】菜单
Mock.mock(RegExp('/sys/menu/*'), 'post', () => {
  return Result
})

// ******************角色管理********************

// 查看【全部】角色 或 搜索【部分】角色
Mock.mock(RegExp('/sys/role/list*'), 'get', () => {
  Result.data = {
    records: [
      {
        id: 1,
        name: '超级管理员',
        code: 'admin',
        remark: '系统默认最高权限，不可以编辑和任意修改',
        status: 0,
        created: '2021-01-16T13:29:03',
        modified: '2021-01-17T15:50:45',
        menuIds: [
          {
            id: 1,
            parentId: 0,
            name: '系统管理',
            path: '',
            icon: 'el-icon-s-operation',
            perms: 'sys:manage',
            component: '',
            sorted: 1,
            type: 0,
            status: 0,
            created: '2021-01-15T18:58:18',
            modified: '2021-01-15T18:58:20',
            children: [
              {
                id: 2,
                parentId: 1,
                name: '用户管理',
                path: '/sys/users',
                icon: 'el-icon-s-custom',
                perms: 'sys:user:list',
                component: 'sys/User',
                sorted: 1,
                type: 1,
                status: 0,
                created: '2021-01-15T19:03:45',
                modified: '2021-01-15T19:03:48',
                children: [
                  {
                    id: 9,
                    parentId: 2,
                    name: '添加用户',
                    path: null,
                    icon: null,
                    perms: 'sys:user:save',
                    component: null,
                    sorted: 1,
                    type: 2,
                    status: 0,
                    created: '2021-01-17T21:48:32',
                    modified: '2021-01-15T19:03:48',
                    children: [],
                  },
                  {
                    id: 10,
                    parentId: 2,
                    name: '修改用户',
                    path: null,
                    icon: null,
                    perms: 'sys:user:update',
                    component: null,
                    sorted: 2,
                    type: 2,
                    status: 0,
                    created: '2021-01-17T21:49:03',
                    modified: '2021-01-17T21:53:04',
                    children: [],
                  },
                  {
                    id: 11,
                    parentId: 2,
                    name: '删除用户',
                    path: null,
                    icon: null,
                    perms: 'sys:user:delete',
                    component: null,
                    sorted: 3,
                    type: 2,
                    status: 0,
                    created: '2021-01-17T21:49:21',
                    modified: null,
                    children: [],
                  },
                  {
                    id: 12,
                    parentId: 2,
                    name: '分配角色',
                    path: null,
                    icon: null,
                    perms: 'sys:user:role',
                    component: null,
                    sorted: 4,
                    type: 2,
                    status: 0,
                    created: '2021-01-17T21:49:58',
                    modified: null,
                    children: [],
                  },
                  {
                    id: 13,
                    parentId: 2,
                    name: '重置密码',
                    path: null,
                    icon: null,
                    perms: 'sys:user:repass',
                    component: null,
                    sorted: 5,
                    type: 2,
                    status: 0,
                    created: '2021-01-17T21:50:36',
                    modified: null,
                    children: [],
                  },
                ],
              },
              {
                id: 3,
                parentId: 1,
                name: '角色管理',
                path: '/sys/roles',
                icon: 'el-icon-rank',
                perms: 'sys:role:list',
                component: 'sys/Role',
                sorted: 2,
                type: 1,
                status: 0,
                created: '2021-01-15T19:03:45',
                modified: '2021-01-15T19:03:48',
                children: [],
              },
            ],
          },
          {
            id: 5,
            parentId: 0,
            name: '系统工具',
            path: '',
            icon: 'el-icon-s-tools',
            perms: 'sys:tools',
            component: null,
            sorted: 2,
            type: 0,
            status: 0,
            created: '2021-01-15T19:06:11',
            modified: null,
            children: [
              {
                id: 6,
                parentId: 5,
                name: '数字字典',
                path: '/sys/dicts',
                icon: 'el-icon-s-order',
                perms: 'sys:dict:list',
                component: 'sys/Dict',
                sorted: 1,
                type: 1,
                status: 0,
                created: '2021-01-15T19:07:18',
                modified: '2021-01-18T16:32:13',
                children: [],
              },
            ],
          },
        ],
      },
      {
        id: 2,
        name: '用户2',
        code: 'normal',
        remark: '只有基本查看功能',
        status: 0,
        created: '2021-01-04T10:09:14',
        modified: '2021-01-30T08:19:52',
        menuIds: [],
      },
      {
        id: 3,
        name: '用户3',
        code: 'normal',
        remark: '只有基本查看功能',
        status: 0,
        created: '2021-01-04T10:09:14',
        modified: '2021-01-30T08:19:52',
        menuIds: [],
      },
      {
        id: 4,
        name: '用户4',
        code: 'normal',
        remark: '只有基本查看功能',
        status: 0,
        created: '2021-01-04T10:09:14',
        modified: '2021-01-30T08:19:52',
        menuIds: [],
      },
    ],
    current: 1,
    size: 10,
    total: 20,
  }
  return Result
})

// 编辑【某个】角色
Mock.mock(RegExp('/sys/role/info/*'), 'get', () => {
  Result.data = {
    id: 1,
    name: '超级管理员',
    code: 'admin',
    remark: '系统默认最高权限，不可以编辑和任意修改',
    status: 0,
    created: '2021-01-16T13:29:03',
    modified: '2021-01-17T15:50:45',
    menuIds: [1],
  }
  return Result
})

// 添加【某个】角色 或 更新【某个】角色 或 删除【某个/多个】角色
Mock.mock(RegExp('/sys/role/*'), 'post', () => {
  return Result
})

// ******************用户管理********************

// 查看【全部】用户 或 搜索【部分】用户
Mock.mock(RegExp('/sys/user/list*'), 'get', () => {
  Result.data = {
    records: [
      {
        id: 1,
        username: 'admin',
        password: '123456',
        email: '123456@qq.com',
        mobile: '12345678901',
        avatar: 'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg',
        status: 0,
        created: '2021-01-12T22:13:53',
        modified: '2021-01-16T16:57:32',
        roleIds: [
          {
            id: 1,
            name: '超级管理员',
            code: 'admin',
            remark: '系统默认最高权限，不可以编辑和任意修改',
            status: 0,
            created: '2021-01-16T13:29:03',
            modified: '2021-01-17T15:50:45',
            menuIds: [],
          },
          {
            id: 2,
            name: '用户2',
            code: 'normal',
            remark: '只有基本查看功能',
            status: 0,
            created: '2021-01-04T10:09:14',
            modified: '2021-01-30T08:19:52',
            menuIds: [],
          },
        ],
      },
      {
        id: 1,
        username: 'admin2',
        password: '123456',
        email: '123456@qq.com',
        mobile: '12345678901',
        avatar: 'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',
        status: 0,
        created: '2021-01-12T22:13:53',
        modified: '2021-01-16T16:57:32',
        roleIds: [
          {
            id: 2,
            name: '用户2',
            code: 'normal',
            remark: '只有基本查看功能',
            status: 0,
            created: '2021-01-04T10:09:14',
            modified: '2021-01-30T08:19:52',
            menuIds: [],
          },
        ],
      },
    ],
    current: 1,
    size: 10,
    total: 20,
  }
  return Result
})

// 编辑【某个】用户
Mock.mock(RegExp('/sys/user/info/*'), 'get', () => {
  Result.data = {
    id: 1,
    username: 'admin',
    password: '123456',
    email: '123456@qq.com',
    mobile: '12345678901',
    avatar: 'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg',
    status: 1,
    created: '2021-01-12T22:13:53',
    modified: '2021-01-16T16:57:32',
    roleIds: [2],
  }
  return Result
})

// 添加【某个】用户 或 更新【某个】用户 或 删除【某个/多个】用户 或 重置【密码】用户
Mock.mock(RegExp('/sys/user/*'), 'post', () => {
  return Result
})

export default Mock
