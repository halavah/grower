# Part02-完成项目搭建-配置文件、模拟数据、全局样式、路由规则

```tree
vue-admin-vue
│  .eslintrc.js                  # 2.1 配置文件
│  .prettierrc.js                # 2.1 配置文件
│  vue.config.js                 # 2.1 配置文件
│
└─src
    │  App.vue                   # 2.3 全局样式
    │
    ├─router
    │      index.js              # 2.4 路由规则
    │
    ├─styles
    │      main.scss             # 2.3 全局样式
    │      normalize.scss
    │
    ├─utils
    │      mock.js               # 2.2 模拟数据
    │
    └─views
        │  Index.vue             # 2.4 页面渲染
        │  Login.vue             # 2.4 页面渲染
        │
        ├─inc
        │      NavBar.vue        # 2.4 页面渲染
        │      NavTab.vue        # 2.4 页面渲染
        │      SideMenu.vue      # 2.4 页面渲染
        │
        ├─sys
        │      Dict.vue          # 2.4 页面渲染
        │      Menu.vue          # 2.4 页面渲染
        │      Role.vue          # 2.4 页面渲染
        │      User.vue          # 2.4 页面渲染
        │
        └─user
                Center.vue       # 2.4 页面渲染
```

## 2.1 使用 配置文件 完成项目搭建

- `.eslintrc.js`：配置文件

```javascript
module.exports = {
  extends: ['alloy', 'alloy/vue'],
  env: {
    // Your environments (which contains several predefined global variables)
    //
    // browser: true,
    // node: true,
    // mocha: true,
    // jest: true,
    // jquery: true
  },
  globals: {
    // Your global variables (setting to false means it's not allowed to be reassigned)
    //
    // myGlobal: false
  },
  rules: {},
}
```

- `.prettierrc.js`：配置文件

```javascript
// .prettierrc.js
module.exports = {
  // max 120 characters per line
  printWidth: 100,
  // use 2 spaces for indentation
  tabWidth: 2,
  // use spaces instead of indentations
  useTabs: false,
  // semicolon at the end of the line
  semi: false,
  // use single quotes
  singleQuote: true,
  // object's key is quoted only when necessary
  quoteProps: 'as-needed',
  // use double quotes instead of single quotes in jsx
  jsxSingleQuote: false,
  // no comma at the end
  trailingComma: 'all',
  // spaces are required at the beginning and end of the braces
  bracketSpacing: true,
  // end tag of jsx need to wrap
  jsxBracketSameLine: false,
  // brackets are required for arrow function parameter, even when there is only one parameter
  arrowParens: 'always',
  // format the entire contents of the file
  rangeStart: 0,
  rangeEnd: Infinity,
  // no need to write the beginning @prettier of the file
  requirePragma: false,
  // No need to automatically insert @prettier at the beginning of the file
  insertPragma: false,
  // use default break criteria
  proseWrap: 'preserve',
  // decide whether to break the html according to the display style
  htmlWhitespaceSensitivity: 'css',
  // vue files script and style tags indentation
  vueIndentScriptAndStyle: false,
  // lf for newline
  endOfLine: 'lf',
  // formats quoted code embedded
  embeddedLanguageFormatting: 'auto',
}
```

- `vue.config.js` ：配置文件，【与 package.json 同属于根目录，@vue/cli-service 会自动加载该配置文件】

```javascript
//* ***************一、跨越问题********************
let proxyObj = {}

// 使用ws代理
// proxyObj['/ws'] = {
//     ws: true,
//     target: "ws://localhost:8765"
// };

// 使用http代理
proxyObj['/'] = {
  ws: false,
  target: 'http://localhost:8765',
  changeOrigin: true,
  pathRewrite: {
    '^/': '',
  },
}

//* ***************二、常用设置********************
// const path = require('path')
module.exports = {
  // 基本路径
  publicPath: process.env.NODE_ENV === 'production' ? '' : '/',

  // 输出文件目录
  outputDir: process.env.NODE_ENV === 'production' ? 'dist' : 'devdist',

  // eslint-loader 是否在保存的时候检查
  lintOnSave: false,

  /**
   * webpack配置,see https://github.com/vuejs/vue-cli/blob/dev/docs/webpack.md
   **/
  chainWebpack: (config) => {},
  configureWebpack: (config) => {
    // devtool: 'source-map'
    // config.resolve = { // 配置解析别名
    //   extensions: ['.js', '.json', '.vue'],
    //   alias: {
    //     '@': path.resolve(__dirname, './src'),
    //     'public': path.resolve(__dirname, './public'),
    //     'components': path.resolve(__dirname, './src/components'),
    //     'common': path.resolve(__dirname, './src/common'),
    //     'api': path.resolve(__dirname, './src/api'),
    //     'views': path.resolve(__dirname, './src/views'),
    //     'data': path.resolve(__dirname, './src/data')
    //   }
    // },
  },

  // 生产环境是否生成 sourceMap 文件
  productionSourceMap: false,

  // css相关配置
  css: {
    // 是否使用css分离插件 ExtractTextPlugin
    extract: true,
    // 开启 CSS source maps?
    sourceMap: false,
    // css预设器配置项
    loaderOptions: {
      // 如发现 css.modules 报错，请查看这里：http://www.web-jshtml.cn/#/detailed?id=12
      scss: {
        prependData: `@import "./src/styles/main.scss";`,
      },
    },
  },

  // use thread-loader for babel & TS in production build
  // enabled by default if the machine has more than 1 cores
  parallel: require('os').cpus().length > 1,

  /**
   *  PWA 插件相关配置,see https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-pwa
   */
  pwa: {},

  // webpack-dev-server 相关配置
  devServer: {
    open: false, // 编译完成是否打开网页
    host: '0.0.0.0', // 指定使用地址，默认localhost,0.0.0.0代表可以被外界访问
    port: 8080, // 访问端口
    https: false, // 编译失败时刷新页面
    hot: true, // 开启热加载
    hotOnly: false,
    proxy: null, // 设置代理，【可选：proxyObj 或 null】，proxyObj可以解决跨域问题
    overlay: {
      // 全屏模式下是否显示脚本错误
      warnings: true,
      errors: true,
    },
    before: (app) => {},
  },

  /**
   * 第三方插件配置
   */
  pluginOptions: {},
}
```

## 2.2 使用 模拟数据 完成项目搭建

- `/utils/mock.js` ：模拟数据

```javascript
// ? 内容：模拟数据（测试URL），根据【不同URL】响应【模拟数据】

const Mock = require('mockjs')

let Result = {
  code: 200,
  msg: '操作成功',
  data: null,
}

// ***************登录/登出/验证码*****************

// 登录
Mock.mock('/login', 'post', () => {
  // 此处token并不是真实从【res.headers['authorization']】获取的jwt，只是为了【测试携带token的/login请求】
  Result.data = {
    token: Mock.Random.string(32),
  }
  return Result
})

// 登出
Mock.mock('/logout', 'post', () => {
  return Result
})

// 验证码
Mock.mock('/captcha', 'get', () => {
  Result.data = {
    token: Mock.Random.string(32),
    captchaImg: Mock.Random.dataImage('120x60', 'p7n5w'),
  }
  return Result
})

// *******************用户信息********************

// 用户信息
Mock.mock('/sys/userInfo', 'get', () => {
  Result.data = {
    id: '1',
    username: 'admin',
    avatar:
      'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',
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
        avatar:
          'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg',
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
        avatar:
          'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',
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
    avatar:
      'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg',
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
```

## 2.3 使用 全局样式 完成项目搭建

- `App.vue` ：全局样式

```vue
<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App',
}
</script>

<style>
/* 初始化浏览器尺寸 */
html,
body,
#app {
  height: 100%;
  padding: 0;
  margin: 0;
  font-size: 15px;
}

/* 取消超链接下划线 */
a {
  text-decoration: none;
}
</style>
```

- `/styles/main.scss` ：css 预设器

```css
@import './normalize.scss';
```

- `/styles/normalize.scss` ：css 预设器

```css
/*! normalize.css v8.0.1 | MIT License | github.com/necolas/normalize.css */

/* Document
   ========================================================================== */

/**
 * 1. Correct the line height in all browsers.
 * 2. Prevent adjustments of font size after orientation changes in iOS.
 */
/* div的默认样式不存在padding和margin为0的情况*/
html,
body,
div,
span,
applet,
object,
iframe,
h1,
h2,
h3,
h4,
h5,
h6,
p,
blockquote,
pre,
a,
abbr,
acronym,
address,
big,
cite,
code,
del,
dfn,
em,
img,
ins,
kbd,
q,
s,
samp,
small,
strike,
strong,
sub,
sup,
tt,
var,
b,
u,
i,
center,
dl,
dt,
dd,
ol,
ul,
fieldset,
form,
label,
legend,
table,
caption,
tbody,
tfoot,
thead,
tr,
th,
td,
article,
aside,
canvas,
details,
embed,
figure,
figcaption,
footer,
header,
hgroup,
menu,
nav,
output,
ruby,
section,
summary,
time,
mark,
audio,
video {
  margin: 0;
  padding: 0;
  height: 100%;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
}

/* HTML5 display-role reset for older browsers */
article,
aside,
details,
figcaption,
figure,
footer,
header,
hgroup,
menu,
nav,
section {
  display: block;
}

html {
  line-height: 1.15; /* 1 */
  -webkit-text-size-adjust: 100%; /* 2 */
}

/* Sections
   ========================================================================== */

/**
 * Remove the margin in all browsers.
 */

body {
  margin: 0;
  background-color: #f7f7f7;
  font-family: 'Microsoft YaHei';
  font-size: 15px;
}

/**
 * Render the `main` element consistently in IE.
 */

main {
  display: block;
}

/**
 * Correct the font size and margin on `h1` elements within `section` and
 * `article` contexts in Chrome, Firefox, and Safari.
 */

/* Grouping content
   ========================================================================== */

/**
 * 1. Add the correct box sizing in Firefox.
 * 2. Show the overflow in Edge and IE.
 */

hr {
  box-sizing: content-box; /* 1 */
  height: 0; /* 1 */
  overflow: visible; /* 2 */
}

/**
 * 1. Correct the inheritance and scaling of font size in all browsers.
 * 2. Correct the odd `em` font sizing in all browsers.
 */

pre {
  font-family: monospace, monospace; /* 1 */
  font-size: 1em; /* 2 */
}

/* Text-level semantics
   ========================================================================== */

/**
 * Remove the gray background on active links in IE 10.
 */

a {
  background-color: transparent;
  text-decoration: none;
}

/**
 * 1. Remove the bottom border in Chrome 57-
 * 2. Add the correct text decoration in Chrome, Edge, IE, Opera, and Safari.
 */

abbr[title] {
  border-bottom: none; /* 1 */
  text-decoration: underline; /* 2 */
  text-decoration: underline dotted; /* 2 */
}

/**
 * Add the correct font weight in Chrome, Edge, and Safari.
 */

b,
strong {
  font-weight: bolder;
}

/**
 * 1. Correct the inheritance and scaling of font size in all browsers.
 * 2. Correct the odd `em` font sizing in all browsers.
 */

code,
kbd,
samp {
  font-family: monospace, monospace; /* 1 */
  font-size: 1em; /* 2 */
}

/**
 * Add the correct font size in all browsers.
 */

small {
  font-size: 80%;
}

/**
 * Prevent `sub` and `sup` elements from affecting the line height in
 * all browsers.
 */

sub,
sup {
  font-size: 75%;
  line-height: 0;
  position: relative;
  vertical-align: baseline;
}

sub {
  bottom: -0.25em;
}

sup {
  top: -0.5em;
}

/* Embedded content
   ========================================================================== */

/**
 * Remove the border on images inside links in IE 10.
 */

img {
  display: block;
  border-style: none;
}

/* Forms
   ========================================================================== */

/**
 * 1. Change the font styles in all browsers.
 * 2. Remove the margin in Firefox and Safari.
 */

button,
input,
optgroup,
select,
textarea {
  font-family: inherit; /* 1 */
  font-size: 100%; /* 1 */
  line-height: 1.15; /* 1 */
  margin: 0; /* 2 */
}

/**
 * Show the overflow in IE.
 * 1. Show the overflow in Edge.
 */

button,
input {
  /* 1 */
  overflow: visible;
}

/**
 * Remove the inheritance of text transform in Edge, Firefox, and IE.
 * 1. Remove the inheritance of text transform in Firefox.
 */

button,
select {
  /* 1 */
  text-transform: none;
}

/**
 * Correct the inability to style clickable types in iOS and Safari.
 */

button,
[type='button'],
[type='reset'],
[type='submit'] {
  -webkit-appearance: button;
}

/**
 * Remove the inner border and padding in Firefox.
 */

button::-moz-focus-inner,
[type='button']::-moz-focus-inner,
[type='reset']::-moz-focus-inner,
[type='submit']::-moz-focus-inner {
  border-style: none;
  padding: 0;
}

/**
 * Restore the focus styles unset by the previous rule.
 */

button:-moz-focusring,
[type='button']:-moz-focusring,
[type='reset']:-moz-focusring,
[type='submit']:-moz-focusring {
  outline: 1px dotted ButtonText;
}

/**
 * Correct the padding in Firefox.
 */

fieldset {
  padding: 0.35em 0.75em 0.625em;
}

/**
 * 1. Correct the text wrapping in Edge and IE.
 * 2. Correct the color inheritance from `fieldset` elements in IE.
 * 3. Remove the padding so developers are not caught out when they zero out
 *    `fieldset` elements in all browsers.
 */

legend {
  box-sizing: border-box; /* 1 */
  color: inherit; /* 2 */
  display: table; /* 1 */
  max-width: 100%; /* 1 */
  padding: 0; /* 3 */
  white-space: normal; /* 1 */
}

/**
 * Add the correct vertical alignment in Chrome, Firefox, and Opera.
 */

progress {
  vertical-align: baseline;
}

/**
 * Remove the default vertical scrollbar in IE 10+.
 */

textarea {
  overflow: auto;
}

/**
 * 1. Add the correct box sizing in IE 10.
 * 2. Remove the padding in IE 10.
 */

[type='checkbox'],
[type='radio'] {
  box-sizing: border-box; /* 1 */
  padding: 0; /* 2 */
}

/**
 * Correct the cursor style of increment and decrement buttons in Chrome.
 */

[type='number']::-webkit-inner-spin-button,
[type='number']::-webkit-outer-spin-button {
  height: auto;
}

/**
 * 1. Correct the odd appearance in Chrome and Safari.
 * 2. Correct the outline style in Safari.
 */

[type='search'] {
  -webkit-appearance: textfield; /* 1 */
  outline-offset: -2px; /* 2 */
}

/**
 * Remove the inner padding in Chrome and Safari on macOS.
 */

[type='search']::-webkit-search-decoration {
  -webkit-appearance: none;
}

/**
 * 1. Correct the inability to style clickable types in iOS and Safari.
 * 2. Change font properties to `inherit` in Safari.
 */

::-webkit-file-upload-button {
  -webkit-appearance: button; /* 1 */
  font: inherit; /* 2 */
}

/* Interactive
   ========================================================================== */

/*
 * Add the correct display in Edge, IE 10+, and Firefox.
 */

details {
  display: block;
}

/*
 * Add the correct display in all browsers.
 */

summary {
  display: list-item;
}

/* Misc
   ========================================================================== */

/**
 * Add the correct display in IE 10+.
 */

template {
  display: none;
}

/**
 * Add the correct display in IE 10.
 */

[hidden] {
  display: none;
}

ul,
li {
  list-style: none;
}
```

## 2.4 使用 路由规则 完成项目搭建

- `/router/index.js` ：路由规则

```javascript
import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '@/views/Login'
import Index from '@/views/Index'

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
  {
    path: '/',
    name: 'Index',
    component: Index,
    children: [
      {
        path: '/user/center',
        name: 'userCenter',
        component: () => import('@/views/user/Center'),
      },
      {
        path: '/sys/users',
        name: 'SysUser',
        component: () => import('@/views/sys/User'),
      },
      {
        path: '/sys/roles',
        name: 'SysRole',
        component: () => import('@/views/sys/Role'),
      },
      {
        path: '/sys/menus',
        name: 'SysMenu',
        component: () => import('@/views/sys/Menu'),
      },
    ],
  },
]

const router = new VueRouter({
  /* 采用history模式，利用了HTML5 History Interface 解决URL没有 “#” 号的问题 */
  mode: 'history',
  routes,
})

export default router
```

- `/views/xxx.vue` ：页面渲染

```vue
<template>
  <div>XX管理</div>
</template>

<script>
export default {
  name: 'SysXxxx',
}
</script>
```
