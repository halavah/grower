[comment]: <> (# Part02-完成项目搭建-配置文件、模拟数据、全局样式、路由规则)

[comment]: <> (```tree)

[comment]: <> (vue-admin-vue)

[comment]: <> (│  .eslintrc.js                  # 2.1 配置文件)

[comment]: <> (│  .prettierrc.js                # 2.1 配置文件)

[comment]: <> (│  vue.config.js                 # 2.1 配置文件)

[comment]: <> (│)

[comment]: <> (└─src)

[comment]: <> (    │  App.vue                   # 2.3 全局样式)

[comment]: <> (    │)

[comment]: <> (    ├─router)

[comment]: <> (    │      index.js              # 2.4 路由规则)

[comment]: <> (    │)

[comment]: <> (    ├─styles)

[comment]: <> (    │      main.scss             # 2.3 全局样式)

[comment]: <> (    │      normalize.scss)

[comment]: <> (    │)

[comment]: <> (    ├─utils)

[comment]: <> (    │      mock.js               # 2.2 模拟数据)

[comment]: <> (    │)

[comment]: <> (    └─views)

[comment]: <> (        │  Index.vue             # 2.4 页面渲染)

[comment]: <> (        │  Login.vue             # 2.4 页面渲染)

[comment]: <> (        │)

[comment]: <> (        ├─inc)

[comment]: <> (        │      NavBar.vue        # 2.4 页面渲染)

[comment]: <> (        │      NavTab.vue        # 2.4 页面渲染)

[comment]: <> (        │      SideMenu.vue      # 2.4 页面渲染)

[comment]: <> (        │)

[comment]: <> (        ├─sys)

[comment]: <> (        │      Dict.vue          # 2.4 页面渲染)

[comment]: <> (        │      Menu.vue          # 2.4 页面渲染)

[comment]: <> (        │      Role.vue          # 2.4 页面渲染)

[comment]: <> (        │      User.vue          # 2.4 页面渲染)

[comment]: <> (        │)

[comment]: <> (        └─user)

[comment]: <> (                Center.vue       # 2.4 页面渲染)

[comment]: <> (```)

[comment]: <> (## 2.1 使用 配置文件 完成项目搭建)

[comment]: <> (- `.eslintrc.js`：配置文件)

[comment]: <> (```javascript)

[comment]: <> (module.exports = {)

[comment]: <> (  extends: ['alloy', 'alloy/vue'],)

[comment]: <> (  env: {)

[comment]: <> (    // Your environments &#40;which contains several predefined global variables&#41;)

[comment]: <> (    //)

[comment]: <> (    // browser: true,)

[comment]: <> (    // node: true,)

[comment]: <> (    // mocha: true,)

[comment]: <> (    // jest: true,)

[comment]: <> (    // jquery: true)

[comment]: <> (  },)

[comment]: <> (  globals: {)

[comment]: <> (    // Your global variables &#40;setting to false means it's not allowed to be reassigned&#41;)

[comment]: <> (    //)

[comment]: <> (    // myGlobal: false)

[comment]: <> (  },)

[comment]: <> (  rules: {},)

[comment]: <> (})

[comment]: <> (```)

[comment]: <> (- `.prettierrc.js`：配置文件)

[comment]: <> (```javascript)

[comment]: <> (// .prettierrc.js)

[comment]: <> (module.exports = {)

[comment]: <> (  // max 120 characters per line)

[comment]: <> (  printWidth: 100,)

[comment]: <> (  // use 2 spaces for indentation)

[comment]: <> (  tabWidth: 2,)

[comment]: <> (  // use spaces instead of indentations)

[comment]: <> (  useTabs: false,)

[comment]: <> (  // semicolon at the end of the line)

[comment]: <> (  semi: false,)

[comment]: <> (  // use single quotes)

[comment]: <> (  singleQuote: true,)

[comment]: <> (  // object's key is quoted only when necessary)

[comment]: <> (  quoteProps: 'as-needed',)

[comment]: <> (  // use double quotes instead of single quotes in jsx)

[comment]: <> (  jsxSingleQuote: false,)

[comment]: <> (  // no comma at the end)

[comment]: <> (  trailingComma: 'all',)

[comment]: <> (  // spaces are required at the beginning and end of the braces)

[comment]: <> (  bracketSpacing: true,)

[comment]: <> (  // end tag of jsx need to wrap)

[comment]: <> (  jsxBracketSameLine: false,)

[comment]: <> (  // brackets are required for arrow function parameter, even when there is only one parameter)

[comment]: <> (  arrowParens: 'always',)

[comment]: <> (  // format the entire contents of the file)

[comment]: <> (  rangeStart: 0,)

[comment]: <> (  rangeEnd: Infinity,)

[comment]: <> (  // no need to write the beginning @prettier of the file)

[comment]: <> (  requirePragma: false,)

[comment]: <> (  // No need to automatically insert @prettier at the beginning of the file)

[comment]: <> (  insertPragma: false,)

[comment]: <> (  // use default break criteria)

[comment]: <> (  proseWrap: 'preserve',)

[comment]: <> (  // decide whether to break the html according to the display style)

[comment]: <> (  htmlWhitespaceSensitivity: 'css',)

[comment]: <> (  // vue files script and style tags indentation)

[comment]: <> (  vueIndentScriptAndStyle: false,)

[comment]: <> (  // lf for newline)

[comment]: <> (  endOfLine: 'lf',)

[comment]: <> (  // formats quoted code embedded)

[comment]: <> (  embeddedLanguageFormatting: 'auto',)

[comment]: <> (})

[comment]: <> (```)

[comment]: <> (- `vue.config.js` ：配置文件，【与 package.json 同属于根目录，@vue/cli-service 会自动加载该配置文件】)

[comment]: <> (```javascript)

[comment]: <> (//* ***************一、跨越问题********************)

[comment]: <> (let proxyObj = {})

[comment]: <> (// 使用ws代理)

[comment]: <> (// proxyObj['/ws'] = {)

[comment]: <> (//     ws: true,)

[comment]: <> (//     target: "ws://localhost:8765")

[comment]: <> (// };)

[comment]: <> (// 使用http代理)

[comment]: <> (proxyObj['/'] = {)

[comment]: <> (  ws: false,)

[comment]: <> (  target: 'http://localhost:8765',)

[comment]: <> (  changeOrigin: true,)

[comment]: <> (  pathRewrite: {)

[comment]: <> (    '^/': '',)

[comment]: <> (  },)

[comment]: <> (})

[comment]: <> (//* ***************二、常用设置********************)

[comment]: <> (// const path = require&#40;'path'&#41;)

[comment]: <> (module.exports = {)

[comment]: <> (  // 基本路径)

[comment]: <> (  publicPath: process.env.NODE_ENV === 'production' ? '' : '/',)

[comment]: <> (  // 输出文件目录)

[comment]: <> (  outputDir: process.env.NODE_ENV === 'production' ? 'dist' : 'devdist',)

[comment]: <> (  // eslint-loader 是否在保存的时候检查)

[comment]: <> (  lintOnSave: false,)

[comment]: <> (  /**)

[comment]: <> (   * webpack配置,see https://github.com/vuejs/vue-cli/blob/dev/docs/webpack.md)

[comment]: <> (   **/)

[comment]: <> (  chainWebpack: &#40;config&#41; => {},)

[comment]: <> (  configureWebpack: &#40;config&#41; => {)

[comment]: <> (    // devtool: 'source-map')

[comment]: <> (    // config.resolve = { // 配置解析别名)

[comment]: <> (    //   extensions: ['.js', '.json', '.vue'],)

[comment]: <> (    //   alias: {)

[comment]: <> (    //     '@': path.resolve&#40;__dirname, './src'&#41;,)

[comment]: <> (    //     'public': path.resolve&#40;__dirname, './public'&#41;,)

[comment]: <> (    //     'components': path.resolve&#40;__dirname, './src/components'&#41;,)

[comment]: <> (    //     'common': path.resolve&#40;__dirname, './src/common'&#41;,)

[comment]: <> (    //     'api': path.resolve&#40;__dirname, './src/api'&#41;,)

[comment]: <> (    //     'views': path.resolve&#40;__dirname, './src/views'&#41;,)

[comment]: <> (    //     'data': path.resolve&#40;__dirname, './src/data'&#41;)

[comment]: <> (    //   })

[comment]: <> (    // },)

[comment]: <> (  },)

[comment]: <> (  // 生产环境是否生成 sourceMap 文件)

[comment]: <> (  productionSourceMap: false,)

[comment]: <> (  // css相关配置)

[comment]: <> (  css: {)

[comment]: <> (    // 是否使用css分离插件 ExtractTextPlugin)

[comment]: <> (    extract: true,)

[comment]: <> (    // 开启 CSS source maps?)

[comment]: <> (    sourceMap: false,)

[comment]: <> (    // css预设器配置项)

[comment]: <> (    loaderOptions: {)

[comment]: <> (      // 如发现 css.modules 报错，请查看这里：http://www.web-jshtml.cn/#/detailed?id=12)

[comment]: <> (      scss: {)

[comment]: <> (        prependData: `@import "./src/styles/main.scss";`,)

[comment]: <> (      },)

[comment]: <> (    },)

[comment]: <> (  },)

[comment]: <> (  // use thread-loader for babel & TS in production build)

[comment]: <> (  // enabled by default if the machine has more than 1 cores)

[comment]: <> (  parallel: require&#40;'os'&#41;.cpus&#40;&#41;.length > 1,)

[comment]: <> (  /**)

[comment]: <> (   *  PWA 插件相关配置,see https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-pwa)

[comment]: <> (   */)

[comment]: <> (  pwa: {},)

[comment]: <> (  // webpack-dev-server 相关配置)

[comment]: <> (  devServer: {)

[comment]: <> (    open: false, // 编译完成是否打开网页)

[comment]: <> (    host: '0.0.0.0', // 指定使用地址，默认localhost,0.0.0.0代表可以被外界访问)

[comment]: <> (    port: 8080, // 访问端口)

[comment]: <> (    https: false, // 编译失败时刷新页面)

[comment]: <> (    hot: true, // 开启热加载)

[comment]: <> (    hotOnly: false,)

[comment]: <> (    proxy: null, // 设置代理，【可选：proxyObj 或 null】，proxyObj可以解决跨域问题)

[comment]: <> (    overlay: {)

[comment]: <> (      // 全屏模式下是否显示脚本错误)

[comment]: <> (      warnings: true,)

[comment]: <> (      errors: true,)

[comment]: <> (    },)

[comment]: <> (    before: &#40;app&#41; => {},)

[comment]: <> (  },)

[comment]: <> (  /**)

[comment]: <> (   * 第三方插件配置)

[comment]: <> (   */)

[comment]: <> (  pluginOptions: {},)

[comment]: <> (})

[comment]: <> (```)

[comment]: <> (## 2.2 使用 模拟数据 完成项目搭建)

[comment]: <> (- `/utils/mock.js` ：模拟数据)

[comment]: <> (```javascript)

[comment]: <> (// ? 内容：模拟数据（测试URL），根据【不同URL】响应【模拟数据】)

[comment]: <> (const Mock = require&#40;'mockjs'&#41;)

[comment]: <> (let Result = {)

[comment]: <> (  code: 200,)

[comment]: <> (  msg: '操作成功',)

[comment]: <> (  data: null,)

[comment]: <> (})

[comment]: <> (// ***************登录/登出/验证码*****************)

[comment]: <> (// 登录)

[comment]: <> (Mock.mock&#40;'/login', 'post', &#40;&#41; => {)

[comment]: <> (  // 此处token并不是真实从【res.headers['authorization']】获取的jwt，只是为了【测试携带token的/login请求】)

[comment]: <> (  Result.data = {)

[comment]: <> (    token: Mock.Random.string&#40;32&#41;,)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 登出)

[comment]: <> (Mock.mock&#40;'/logout', 'post', &#40;&#41; => {)

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 验证码)

[comment]: <> (Mock.mock&#40;'/captcha', 'get', &#40;&#41; => {)

[comment]: <> (  Result.data = {)

[comment]: <> (    token: Mock.Random.string&#40;32&#41;,)

[comment]: <> (    captchaImg: Mock.Random.dataImage&#40;'120x60', 'p7n5w'&#41;,)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// *******************用户信息********************)

[comment]: <> (// 用户信息)

[comment]: <> (Mock.mock&#40;'/sys/userInfo', 'get', &#40;&#41; => {)

[comment]: <> (  Result.data = {)

[comment]: <> (    id: '1',)

[comment]: <> (    username: 'admin',)

[comment]: <> (    avatar:)

[comment]: <> (      'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 动态菜单以及权限接口)

[comment]: <> (Mock.mock&#40;'/sys/menu/nav', 'get', &#40;&#41; => {)

[comment]: <> (  let nav = [)

[comment]: <> (    {)

[comment]: <> (      id: 1,)

[comment]: <> (      parentId: 0,)

[comment]: <> (      name: 'SysManage',)

[comment]: <> (      title: '系统管理',)

[comment]: <> (      path: '',)

[comment]: <> (      icon: 'el-icon-s-operation',)

[comment]: <> (      perms: 'sys:manage',)

[comment]: <> (      component: '',)

[comment]: <> (      sorted: 1,)

[comment]: <> (      type: 0,)

[comment]: <> (      status: 0,)

[comment]: <> (      created: '2021-01-15T18:58:18',)

[comment]: <> (      modified: '2021-01-15T18:58:20',)

[comment]: <> (      children: [)

[comment]: <> (        {)

[comment]: <> (          id: 2,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: 'SysUser',)

[comment]: <> (          title: '用户管理',)

[comment]: <> (          path: '/sys/users',)

[comment]: <> (          icon: 'el-icon-s-custom',)

[comment]: <> (          perms: 'sys:user:list',)

[comment]: <> (          component: 'sys/User',)

[comment]: <> (          sorted: 1,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:03:45',)

[comment]: <> (          modified: '2021-01-15T19:03:48',)

[comment]: <> (          children: [],)

[comment]: <> (        },)

[comment]: <> (        {)

[comment]: <> (          id: 3,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: 'SysRole',)

[comment]: <> (          title: '角色管理',)

[comment]: <> (          path: '/sys/roles',)

[comment]: <> (          icon: 'el-icon-rank',)

[comment]: <> (          perms: 'sys:role:list',)

[comment]: <> (          component: 'sys/Role',)

[comment]: <> (          sorted: 6,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:03:45',)

[comment]: <> (          modified: '2021-01-15T19:03:48',)

[comment]: <> (          children: [],)

[comment]: <> (        },)

[comment]: <> (        {)

[comment]: <> (          id: 4,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: 'SysMenu',)

[comment]: <> (          title: '菜单管理',)

[comment]: <> (          path: '/sys/menus',)

[comment]: <> (          icon: 'el-icon-menu',)

[comment]: <> (          perms: 'sys:menu:list',)

[comment]: <> (          component: 'sys/Menu',)

[comment]: <> (          sorted: 7,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:03:45',)

[comment]: <> (          modified: '2021-01-15T19:03:48',)

[comment]: <> (          children: [],)

[comment]: <> (        },)

[comment]: <> (      ],)

[comment]: <> (    },)

[comment]: <> (    {)

[comment]: <> (      id: 5,)

[comment]: <> (      parentId: 0,)

[comment]: <> (      name: 'SysTools',)

[comment]: <> (      title: '系统工具',)

[comment]: <> (      path: '',)

[comment]: <> (      icon: 'el-icon-s-tools',)

[comment]: <> (      perms: 'sys:tools',)

[comment]: <> (      component: null,)

[comment]: <> (      sorted: 8,)

[comment]: <> (      type: 0,)

[comment]: <> (      status: 0,)

[comment]: <> (      created: '2021-01-15T19:06:11',)

[comment]: <> (      modified: '2021-01-18T16:32:13',)

[comment]: <> (      children: [)

[comment]: <> (        {)

[comment]: <> (          id: 6,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: '数字字典',)

[comment]: <> (          path: '/sys/dicts',)

[comment]: <> (          icon: 'el-icon-s-order',)

[comment]: <> (          perms: 'sys:dict:list',)

[comment]: <> (          component: 'sys/Dict',)

[comment]: <> (          sorted: 9,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:07:18',)

[comment]: <> (          modified: '2021-01-18T16:32:13',)

[comment]: <> (          children: [],)

[comment]: <> (        },)

[comment]: <> (      ],)

[comment]: <> (    },)

[comment]: <> (  ])

[comment]: <> (  let authoritys = ['sys:user:list', 'sys:user:save', 'sys:user:delete'])

[comment]: <> (  Result.data = {)

[comment]: <> (    nav: nav,)

[comment]: <> (    authoritys: authoritys,)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// *******************菜单管理********************)

[comment]: <> (// 查看【全部】菜单 或 搜索【部分】菜单)

[comment]: <> (Mock.mock&#40;'/sys/menu/list', 'get', &#40;&#41; => {)

[comment]: <> (  let menus = [)

[comment]: <> (    {)

[comment]: <> (      id: 1,)

[comment]: <> (      parentId: 0,)

[comment]: <> (      name: 'SysManage',)

[comment]: <> (      title: '系统管理',)

[comment]: <> (      path: '',)

[comment]: <> (      icon: 'el-icon-s-operation',)

[comment]: <> (      perms: 'sys:manage',)

[comment]: <> (      component: '',)

[comment]: <> (      sorted: 1,)

[comment]: <> (      type: 0,)

[comment]: <> (      status: 0,)

[comment]: <> (      created: '2021-01-15T18:58:18',)

[comment]: <> (      modified: '2021-01-15T18:58:20',)

[comment]: <> (      children: [)

[comment]: <> (        {)

[comment]: <> (          id: 2,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: 'SysUser',)

[comment]: <> (          title: '用户管理',)

[comment]: <> (          path: '/sys/users',)

[comment]: <> (          icon: 'el-icon-s-custom',)

[comment]: <> (          perms: 'sys:user:list',)

[comment]: <> (          component: 'sys/User',)

[comment]: <> (          sorted: 1,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:03:45',)

[comment]: <> (          modified: '2021-01-15T19:03:48',)

[comment]: <> (          children: [)

[comment]: <> (            {)

[comment]: <> (              id: 9,)

[comment]: <> (              parentId: 2,)

[comment]: <> (              name: 'SysUserAdd',)

[comment]: <> (              title: '添加用户',)

[comment]: <> (              path: null,)

[comment]: <> (              icon: null,)

[comment]: <> (              perms: 'sys:user:save',)

[comment]: <> (              component: null,)

[comment]: <> (              sorted: 1,)

[comment]: <> (              type: 2,)

[comment]: <> (              status: 0,)

[comment]: <> (              created: '2021-01-17T21:48:32',)

[comment]: <> (              modified: '2021-01-15T19:03:48',)

[comment]: <> (              children: [],)

[comment]: <> (            },)

[comment]: <> (            {)

[comment]: <> (              id: 10,)

[comment]: <> (              parentId: 2,)

[comment]: <> (              name: 'SysUserModify',)

[comment]: <> (              title: '修改用户',)

[comment]: <> (              path: null,)

[comment]: <> (              icon: null,)

[comment]: <> (              perms: 'sys:user:update',)

[comment]: <> (              component: null,)

[comment]: <> (              sorted: 2,)

[comment]: <> (              type: 2,)

[comment]: <> (              status: 0,)

[comment]: <> (              created: '2021-01-17T21:49:03',)

[comment]: <> (              modified: '2021-01-17T21:53:04',)

[comment]: <> (              children: [],)

[comment]: <> (            },)

[comment]: <> (            {)

[comment]: <> (              id: 11,)

[comment]: <> (              parentId: 2,)

[comment]: <> (              name: 'SysUserDelete',)

[comment]: <> (              title: '删除用户',)

[comment]: <> (              path: null,)

[comment]: <> (              icon: null,)

[comment]: <> (              perms: 'sys:user:delete',)

[comment]: <> (              component: null,)

[comment]: <> (              sorted: 3,)

[comment]: <> (              type: 2,)

[comment]: <> (              status: 0,)

[comment]: <> (              created: '2021-01-17T21:49:21',)

[comment]: <> (              modified: null,)

[comment]: <> (              children: [],)

[comment]: <> (            },)

[comment]: <> (            {)

[comment]: <> (              id: 12,)

[comment]: <> (              parentId: 2,)

[comment]: <> (              name: 'SysRoleHandle',)

[comment]: <> (              title: '分配角色',)

[comment]: <> (              path: null,)

[comment]: <> (              icon: null,)

[comment]: <> (              perms: 'sys:user:role',)

[comment]: <> (              component: null,)

[comment]: <> (              sorted: 4,)

[comment]: <> (              type: 2,)

[comment]: <> (              status: 0,)

[comment]: <> (              created: '2021-01-17T21:49:58',)

[comment]: <> (              modified: null,)

[comment]: <> (              children: [],)

[comment]: <> (            },)

[comment]: <> (            {)

[comment]: <> (              id: 13,)

[comment]: <> (              parentId: 2,)

[comment]: <> (              name: 'SysUserPass',)

[comment]: <> (              title: '重置密码',)

[comment]: <> (              path: null,)

[comment]: <> (              icon: null,)

[comment]: <> (              perms: 'sys:user:repass',)

[comment]: <> (              component: null,)

[comment]: <> (              sorted: 5,)

[comment]: <> (              type: 2,)

[comment]: <> (              status: 0,)

[comment]: <> (              created: '2021-01-17T21:50:36',)

[comment]: <> (              modified: null,)

[comment]: <> (              children: [],)

[comment]: <> (            },)

[comment]: <> (          ],)

[comment]: <> (        },)

[comment]: <> (        {)

[comment]: <> (          id: 3,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: 'SysRole',)

[comment]: <> (          title: '角色管理',)

[comment]: <> (          path: '/sys/roles',)

[comment]: <> (          icon: 'el-icon-rank',)

[comment]: <> (          perms: 'sys:role:list',)

[comment]: <> (          component: 'sys/Role',)

[comment]: <> (          sorted: 6,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:03:45',)

[comment]: <> (          modified: '2021-01-15T19:03:48',)

[comment]: <> (          children: [],)

[comment]: <> (        },)

[comment]: <> (        {)

[comment]: <> (          id: 4,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: 'SysMenu',)

[comment]: <> (          title: '菜单管理',)

[comment]: <> (          path: '/sys/menus',)

[comment]: <> (          icon: 'el-icon-menu',)

[comment]: <> (          perms: 'sys:menu:list',)

[comment]: <> (          component: 'sys/Menu',)

[comment]: <> (          sorted: 7,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:03:45',)

[comment]: <> (          modified: '2021-01-15T19:03:48',)

[comment]: <> (          children: [],)

[comment]: <> (        },)

[comment]: <> (      ],)

[comment]: <> (    },)

[comment]: <> (    {)

[comment]: <> (      id: 5,)

[comment]: <> (      parentId: 0,)

[comment]: <> (      name: 'SysTools',)

[comment]: <> (      title: '系统工具',)

[comment]: <> (      path: '',)

[comment]: <> (      icon: 'el-icon-s-tools',)

[comment]: <> (      perms: 'sys:tools',)

[comment]: <> (      component: null,)

[comment]: <> (      sorted: 8,)

[comment]: <> (      type: 0,)

[comment]: <> (      status: 0,)

[comment]: <> (      created: '2021-01-15T19:06:11',)

[comment]: <> (      modified: '2021-01-18T16:32:13',)

[comment]: <> (      children: [)

[comment]: <> (        {)

[comment]: <> (          id: 7,)

[comment]: <> (          parentId: 1,)

[comment]: <> (          name: 'SysDicts',)

[comment]: <> (          title: '数字字典',)

[comment]: <> (          path: '/sys/dicts',)

[comment]: <> (          icon: 'el-icon-s-order',)

[comment]: <> (          perms: 'sys:dict:list',)

[comment]: <> (          component: 'sys/Dict',)

[comment]: <> (          sorted: 9,)

[comment]: <> (          type: 1,)

[comment]: <> (          status: 0,)

[comment]: <> (          created: '2021-01-15T19:07:18',)

[comment]: <> (          modified: '2021-01-18T16:32:13',)

[comment]: <> (          children: [],)

[comment]: <> (        },)

[comment]: <> (      ],)

[comment]: <> (    },)

[comment]: <> (  ])

[comment]: <> (  Result.data = menus)

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 查看【某个】菜单)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/menu/info/*'&#41;, 'get', &#40;&#41; => {)

[comment]: <> (  Result.data = {)

[comment]: <> (    id: 3,)

[comment]: <> (    parentId: 1,)

[comment]: <> (    name: '角色管理',)

[comment]: <> (    path: '/sys/roles',)

[comment]: <> (    icon: 'el-icon-rank',)

[comment]: <> (    perms: 'sys:role:list',)

[comment]: <> (    component: 'sys/Role',)

[comment]: <> (    sorted: 2,)

[comment]: <> (    type: 1,)

[comment]: <> (    status: 0,)

[comment]: <> (    created: '2021-01-15T19:03:45',)

[comment]: <> (    modified: '2021-01-15T19:03:48',)

[comment]: <> (    children: [],)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 添加【某个】菜单 或 更新【某个】菜单 或 删除【某个/多个】菜单)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/menu/*'&#41;, 'post', &#40;&#41; => {)

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// ******************角色管理********************)

[comment]: <> (// 查看【全部】角色 或 搜索【部分】角色)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/role/list*'&#41;, 'get', &#40;&#41; => {)

[comment]: <> (  Result.data = {)

[comment]: <> (    records: [)

[comment]: <> (      {)

[comment]: <> (        id: 1,)

[comment]: <> (        name: '超级管理员',)

[comment]: <> (        code: 'admin',)

[comment]: <> (        remark: '系统默认最高权限，不可以编辑和任意修改',)

[comment]: <> (        status: 0,)

[comment]: <> (        created: '2021-01-16T13:29:03',)

[comment]: <> (        modified: '2021-01-17T15:50:45',)

[comment]: <> (        menuIds: [)

[comment]: <> (          {)

[comment]: <> (            id: 1,)

[comment]: <> (            parentId: 0,)

[comment]: <> (            name: '系统管理',)

[comment]: <> (            path: '',)

[comment]: <> (            icon: 'el-icon-s-operation',)

[comment]: <> (            perms: 'sys:manage',)

[comment]: <> (            component: '',)

[comment]: <> (            sorted: 1,)

[comment]: <> (            type: 0,)

[comment]: <> (            status: 0,)

[comment]: <> (            created: '2021-01-15T18:58:18',)

[comment]: <> (            modified: '2021-01-15T18:58:20',)

[comment]: <> (            children: [)

[comment]: <> (              {)

[comment]: <> (                id: 2,)

[comment]: <> (                parentId: 1,)

[comment]: <> (                name: '用户管理',)

[comment]: <> (                path: '/sys/users',)

[comment]: <> (                icon: 'el-icon-s-custom',)

[comment]: <> (                perms: 'sys:user:list',)

[comment]: <> (                component: 'sys/User',)

[comment]: <> (                sorted: 1,)

[comment]: <> (                type: 1,)

[comment]: <> (                status: 0,)

[comment]: <> (                created: '2021-01-15T19:03:45',)

[comment]: <> (                modified: '2021-01-15T19:03:48',)

[comment]: <> (                children: [)

[comment]: <> (                  {)

[comment]: <> (                    id: 9,)

[comment]: <> (                    parentId: 2,)

[comment]: <> (                    name: '添加用户',)

[comment]: <> (                    path: null,)

[comment]: <> (                    icon: null,)

[comment]: <> (                    perms: 'sys:user:save',)

[comment]: <> (                    component: null,)

[comment]: <> (                    sorted: 1,)

[comment]: <> (                    type: 2,)

[comment]: <> (                    status: 0,)

[comment]: <> (                    created: '2021-01-17T21:48:32',)

[comment]: <> (                    modified: '2021-01-15T19:03:48',)

[comment]: <> (                    children: [],)

[comment]: <> (                  },)

[comment]: <> (                  {)

[comment]: <> (                    id: 10,)

[comment]: <> (                    parentId: 2,)

[comment]: <> (                    name: '修改用户',)

[comment]: <> (                    path: null,)

[comment]: <> (                    icon: null,)

[comment]: <> (                    perms: 'sys:user:update',)

[comment]: <> (                    component: null,)

[comment]: <> (                    sorted: 2,)

[comment]: <> (                    type: 2,)

[comment]: <> (                    status: 0,)

[comment]: <> (                    created: '2021-01-17T21:49:03',)

[comment]: <> (                    modified: '2021-01-17T21:53:04',)

[comment]: <> (                    children: [],)

[comment]: <> (                  },)

[comment]: <> (                  {)

[comment]: <> (                    id: 11,)

[comment]: <> (                    parentId: 2,)

[comment]: <> (                    name: '删除用户',)

[comment]: <> (                    path: null,)

[comment]: <> (                    icon: null,)

[comment]: <> (                    perms: 'sys:user:delete',)

[comment]: <> (                    component: null,)

[comment]: <> (                    sorted: 3,)

[comment]: <> (                    type: 2,)

[comment]: <> (                    status: 0,)

[comment]: <> (                    created: '2021-01-17T21:49:21',)

[comment]: <> (                    modified: null,)

[comment]: <> (                    children: [],)

[comment]: <> (                  },)

[comment]: <> (                  {)

[comment]: <> (                    id: 12,)

[comment]: <> (                    parentId: 2,)

[comment]: <> (                    name: '分配角色',)

[comment]: <> (                    path: null,)

[comment]: <> (                    icon: null,)

[comment]: <> (                    perms: 'sys:user:role',)

[comment]: <> (                    component: null,)

[comment]: <> (                    sorted: 4,)

[comment]: <> (                    type: 2,)

[comment]: <> (                    status: 0,)

[comment]: <> (                    created: '2021-01-17T21:49:58',)

[comment]: <> (                    modified: null,)

[comment]: <> (                    children: [],)

[comment]: <> (                  },)

[comment]: <> (                  {)

[comment]: <> (                    id: 13,)

[comment]: <> (                    parentId: 2,)

[comment]: <> (                    name: '重置密码',)

[comment]: <> (                    path: null,)

[comment]: <> (                    icon: null,)

[comment]: <> (                    perms: 'sys:user:repass',)

[comment]: <> (                    component: null,)

[comment]: <> (                    sorted: 5,)

[comment]: <> (                    type: 2,)

[comment]: <> (                    status: 0,)

[comment]: <> (                    created: '2021-01-17T21:50:36',)

[comment]: <> (                    modified: null,)

[comment]: <> (                    children: [],)

[comment]: <> (                  },)

[comment]: <> (                ],)

[comment]: <> (              },)

[comment]: <> (              {)

[comment]: <> (                id: 3,)

[comment]: <> (                parentId: 1,)

[comment]: <> (                name: '角色管理',)

[comment]: <> (                path: '/sys/roles',)

[comment]: <> (                icon: 'el-icon-rank',)

[comment]: <> (                perms: 'sys:role:list',)

[comment]: <> (                component: 'sys/Role',)

[comment]: <> (                sorted: 2,)

[comment]: <> (                type: 1,)

[comment]: <> (                status: 0,)

[comment]: <> (                created: '2021-01-15T19:03:45',)

[comment]: <> (                modified: '2021-01-15T19:03:48',)

[comment]: <> (                children: [],)

[comment]: <> (              },)

[comment]: <> (            ],)

[comment]: <> (          },)

[comment]: <> (          {)

[comment]: <> (            id: 5,)

[comment]: <> (            parentId: 0,)

[comment]: <> (            name: '系统工具',)

[comment]: <> (            path: '',)

[comment]: <> (            icon: 'el-icon-s-tools',)

[comment]: <> (            perms: 'sys:tools',)

[comment]: <> (            component: null,)

[comment]: <> (            sorted: 2,)

[comment]: <> (            type: 0,)

[comment]: <> (            status: 0,)

[comment]: <> (            created: '2021-01-15T19:06:11',)

[comment]: <> (            modified: null,)

[comment]: <> (            children: [)

[comment]: <> (              {)

[comment]: <> (                id: 6,)

[comment]: <> (                parentId: 5,)

[comment]: <> (                name: '数字字典',)

[comment]: <> (                path: '/sys/dicts',)

[comment]: <> (                icon: 'el-icon-s-order',)

[comment]: <> (                perms: 'sys:dict:list',)

[comment]: <> (                component: 'sys/Dict',)

[comment]: <> (                sorted: 1,)

[comment]: <> (                type: 1,)

[comment]: <> (                status: 0,)

[comment]: <> (                created: '2021-01-15T19:07:18',)

[comment]: <> (                modified: '2021-01-18T16:32:13',)

[comment]: <> (                children: [],)

[comment]: <> (              },)

[comment]: <> (            ],)

[comment]: <> (          },)

[comment]: <> (        ],)

[comment]: <> (      },)

[comment]: <> (      {)

[comment]: <> (        id: 2,)

[comment]: <> (        name: '用户2',)

[comment]: <> (        code: 'normal',)

[comment]: <> (        remark: '只有基本查看功能',)

[comment]: <> (        status: 0,)

[comment]: <> (        created: '2021-01-04T10:09:14',)

[comment]: <> (        modified: '2021-01-30T08:19:52',)

[comment]: <> (        menuIds: [],)

[comment]: <> (      },)

[comment]: <> (      {)

[comment]: <> (        id: 3,)

[comment]: <> (        name: '用户3',)

[comment]: <> (        code: 'normal',)

[comment]: <> (        remark: '只有基本查看功能',)

[comment]: <> (        status: 0,)

[comment]: <> (        created: '2021-01-04T10:09:14',)

[comment]: <> (        modified: '2021-01-30T08:19:52',)

[comment]: <> (        menuIds: [],)

[comment]: <> (      },)

[comment]: <> (      {)

[comment]: <> (        id: 4,)

[comment]: <> (        name: '用户4',)

[comment]: <> (        code: 'normal',)

[comment]: <> (        remark: '只有基本查看功能',)

[comment]: <> (        status: 0,)

[comment]: <> (        created: '2021-01-04T10:09:14',)

[comment]: <> (        modified: '2021-01-30T08:19:52',)

[comment]: <> (        menuIds: [],)

[comment]: <> (      },)

[comment]: <> (    ],)

[comment]: <> (    current: 1,)

[comment]: <> (    size: 10,)

[comment]: <> (    total: 20,)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 编辑【某个】角色)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/role/info/*'&#41;, 'get', &#40;&#41; => {)

[comment]: <> (  Result.data = {)

[comment]: <> (    id: 1,)

[comment]: <> (    name: '超级管理员',)

[comment]: <> (    code: 'admin',)

[comment]: <> (    remark: '系统默认最高权限，不可以编辑和任意修改',)

[comment]: <> (    status: 0,)

[comment]: <> (    created: '2021-01-16T13:29:03',)

[comment]: <> (    modified: '2021-01-17T15:50:45',)

[comment]: <> (    menuIds: [1],)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 添加【某个】角色 或 更新【某个】角色 或 删除【某个/多个】角色)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/role/*'&#41;, 'post', &#40;&#41; => {)

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// ******************用户管理********************)

[comment]: <> (// 查看【全部】用户 或 搜索【部分】用户)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/user/list*'&#41;, 'get', &#40;&#41; => {)

[comment]: <> (  Result.data = {)

[comment]: <> (    records: [)

[comment]: <> (      {)

[comment]: <> (        id: 1,)

[comment]: <> (        username: 'admin',)

[comment]: <> (        password: '123456',)

[comment]: <> (        email: '123456@qq.com',)

[comment]: <> (        mobile: '12345678901',)

[comment]: <> (        avatar:)

[comment]: <> (          'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg',)

[comment]: <> (        status: 0,)

[comment]: <> (        created: '2021-01-12T22:13:53',)

[comment]: <> (        modified: '2021-01-16T16:57:32',)

[comment]: <> (        roleIds: [)

[comment]: <> (          {)

[comment]: <> (            id: 1,)

[comment]: <> (            name: '超级管理员',)

[comment]: <> (            code: 'admin',)

[comment]: <> (            remark: '系统默认最高权限，不可以编辑和任意修改',)

[comment]: <> (            status: 0,)

[comment]: <> (            created: '2021-01-16T13:29:03',)

[comment]: <> (            modified: '2021-01-17T15:50:45',)

[comment]: <> (            menuIds: [],)

[comment]: <> (          },)

[comment]: <> (          {)

[comment]: <> (            id: 2,)

[comment]: <> (            name: '用户2',)

[comment]: <> (            code: 'normal',)

[comment]: <> (            remark: '只有基本查看功能',)

[comment]: <> (            status: 0,)

[comment]: <> (            created: '2021-01-04T10:09:14',)

[comment]: <> (            modified: '2021-01-30T08:19:52',)

[comment]: <> (            menuIds: [],)

[comment]: <> (          },)

[comment]: <> (        ],)

[comment]: <> (      },)

[comment]: <> (      {)

[comment]: <> (        id: 1,)

[comment]: <> (        username: 'admin2',)

[comment]: <> (        password: '123456',)

[comment]: <> (        email: '123456@qq.com',)

[comment]: <> (        mobile: '12345678901',)

[comment]: <> (        avatar:)

[comment]: <> (          'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',)

[comment]: <> (        status: 0,)

[comment]: <> (        created: '2021-01-12T22:13:53',)

[comment]: <> (        modified: '2021-01-16T16:57:32',)

[comment]: <> (        roleIds: [)

[comment]: <> (          {)

[comment]: <> (            id: 2,)

[comment]: <> (            name: '用户2',)

[comment]: <> (            code: 'normal',)

[comment]: <> (            remark: '只有基本查看功能',)

[comment]: <> (            status: 0,)

[comment]: <> (            created: '2021-01-04T10:09:14',)

[comment]: <> (            modified: '2021-01-30T08:19:52',)

[comment]: <> (            menuIds: [],)

[comment]: <> (          },)

[comment]: <> (        ],)

[comment]: <> (      },)

[comment]: <> (    ],)

[comment]: <> (    current: 1,)

[comment]: <> (    size: 10,)

[comment]: <> (    total: 20,)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 编辑【某个】用户)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/user/info/*'&#41;, 'get', &#40;&#41; => {)

[comment]: <> (  Result.data = {)

[comment]: <> (    id: 1,)

[comment]: <> (    username: 'admin',)

[comment]: <> (    password: '123456',)

[comment]: <> (    email: '123456@qq.com',)

[comment]: <> (    mobile: '12345678901',)

[comment]: <> (    avatar:)

[comment]: <> (      'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg',)

[comment]: <> (    status: 1,)

[comment]: <> (    created: '2021-01-12T22:13:53',)

[comment]: <> (    modified: '2021-01-16T16:57:32',)

[comment]: <> (    roleIds: [2],)

[comment]: <> (  })

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (// 添加【某个】用户 或 更新【某个】用户 或 删除【某个/多个】用户 或 重置【密码】用户)

[comment]: <> (Mock.mock&#40;RegExp&#40;'/sys/user/*'&#41;, 'post', &#40;&#41; => {)

[comment]: <> (  return Result)

[comment]: <> (}&#41;)

[comment]: <> (export default Mock)

[comment]: <> (```)

[comment]: <> (## 2.3 使用 全局样式 完成项目搭建)

[comment]: <> (- `App.vue` ：全局样式)

[comment]: <> (```vue)

[comment]: <> (<template>)

[comment]: <> (  <div id="app">)

[comment]: <> (    <router-view />)

[comment]: <> (  </div>)

[comment]: <> (</template>)

[comment]: <> (<script>)

[comment]: <> (export default {)

[comment]: <> (  name: 'App',)

[comment]: <> (})

[comment]: <> (</script>)

[comment]: <> (<style>)

[comment]: <> (/* 初始化浏览器尺寸 */)

[comment]: <> (html,)

[comment]: <> (body,)

[comment]: <> (#app {)

[comment]: <> (  height: 100%;)

[comment]: <> (  padding: 0;)

[comment]: <> (  margin: 0;)

[comment]: <> (  font-size: 15px;)

[comment]: <> (})

[comment]: <> (/* 取消超链接下划线 */)

[comment]: <> (a {)

[comment]: <> (  text-decoration: none;)

[comment]: <> (})

[comment]: <> (</style>)

[comment]: <> (```)

[comment]: <> (- `/styles/main.scss` ：css 预设器)

[comment]: <> (```css)

[comment]: <> (@import './normalize.scss';)

[comment]: <> (```)

[comment]: <> (- `/styles/normalize.scss` ：css 预设器)

[comment]: <> (```css)

[comment]: <> (/*! normalize.css v8.0.1 | MIT License | github.com/necolas/normalize.css */)

[comment]: <> (/* Document)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/**)

[comment]: <> ( * 1. Correct the line height in all browsers.)

[comment]: <> ( * 2. Prevent adjustments of font size after orientation changes in iOS.)

[comment]: <> ( */)

[comment]: <> (/* div的默认样式不存在padding和margin为0的情况*/)

[comment]: <> (html,)

[comment]: <> (body,)

[comment]: <> (div,)

[comment]: <> (span,)

[comment]: <> (applet,)

[comment]: <> (object,)

[comment]: <> (iframe,)

[comment]: <> (h1,)

[comment]: <> (h2,)

[comment]: <> (h3,)

[comment]: <> (h4,)

[comment]: <> (h5,)

[comment]: <> (h6,)

[comment]: <> (p,)

[comment]: <> (blockquote,)

[comment]: <> (pre,)

[comment]: <> (a,)

[comment]: <> (abbr,)

[comment]: <> (acronym,)

[comment]: <> (address,)

[comment]: <> (big,)

[comment]: <> (cite,)

[comment]: <> (code,)

[comment]: <> (del,)

[comment]: <> (dfn,)

[comment]: <> (em,)

[comment]: <> (img,)

[comment]: <> (ins,)

[comment]: <> (kbd,)

[comment]: <> (q,)

[comment]: <> (s,)

[comment]: <> (samp,)

[comment]: <> (small,)

[comment]: <> (strike,)

[comment]: <> (strong,)

[comment]: <> (sub,)

[comment]: <> (sup,)

[comment]: <> (tt,)

[comment]: <> (var,)

[comment]: <> (b,)

[comment]: <> (u,)

[comment]: <> (i,)

[comment]: <> (center,)

[comment]: <> (dl,)

[comment]: <> (dt,)

[comment]: <> (dd,)

[comment]: <> (ol,)

[comment]: <> (ul,)

[comment]: <> (fieldset,)

[comment]: <> (form,)

[comment]: <> (label,)

[comment]: <> (legend,)

[comment]: <> (table,)

[comment]: <> (caption,)

[comment]: <> (tbody,)

[comment]: <> (tfoot,)

[comment]: <> (thead,)

[comment]: <> (tr,)

[comment]: <> (th,)

[comment]: <> (td,)

[comment]: <> (article,)

[comment]: <> (aside,)

[comment]: <> (canvas,)

[comment]: <> (details,)

[comment]: <> (embed,)

[comment]: <> (figure,)

[comment]: <> (figcaption,)

[comment]: <> (footer,)

[comment]: <> (header,)

[comment]: <> (hgroup,)

[comment]: <> (menu,)

[comment]: <> (nav,)

[comment]: <> (output,)

[comment]: <> (ruby,)

[comment]: <> (section,)

[comment]: <> (summary,)

[comment]: <> (time,)

[comment]: <> (mark,)

[comment]: <> (audio,)

[comment]: <> (video {)

[comment]: <> (  margin: 0;)

[comment]: <> (  padding: 0;)

[comment]: <> (  height: 100%;)

[comment]: <> (  font-size: 100%;)

[comment]: <> (  font: inherit;)

[comment]: <> (  vertical-align: baseline;)

[comment]: <> (})

[comment]: <> (/* HTML5 display-role reset for older browsers */)

[comment]: <> (article,)

[comment]: <> (aside,)

[comment]: <> (details,)

[comment]: <> (figcaption,)

[comment]: <> (figure,)

[comment]: <> (footer,)

[comment]: <> (header,)

[comment]: <> (hgroup,)

[comment]: <> (menu,)

[comment]: <> (nav,)

[comment]: <> (section {)

[comment]: <> (  display: block;)

[comment]: <> (})

[comment]: <> (html {)

[comment]: <> (  line-height: 1.15; /* 1 */)

[comment]: <> (  -webkit-text-size-adjust: 100%; /* 2 */)

[comment]: <> (})

[comment]: <> (/* Sections)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/**)

[comment]: <> ( * Remove the margin in all browsers.)

[comment]: <> ( */)

[comment]: <> (body {)

[comment]: <> (  margin: 0;)

[comment]: <> (  background-color: #f7f7f7;)

[comment]: <> (  font-family: 'Microsoft YaHei';)

[comment]: <> (  font-size: 15px;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Render the `main` element consistently in IE.)

[comment]: <> ( */)

[comment]: <> (main {)

[comment]: <> (  display: block;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Correct the font size and margin on `h1` elements within `section` and)

[comment]: <> ( * `article` contexts in Chrome, Firefox, and Safari.)

[comment]: <> ( */)

[comment]: <> (/* Grouping content)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/**)

[comment]: <> ( * 1. Add the correct box sizing in Firefox.)

[comment]: <> ( * 2. Show the overflow in Edge and IE.)

[comment]: <> ( */)

[comment]: <> (hr {)

[comment]: <> (  box-sizing: content-box; /* 1 */)

[comment]: <> (  height: 0; /* 1 */)

[comment]: <> (  overflow: visible; /* 2 */)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * 1. Correct the inheritance and scaling of font size in all browsers.)

[comment]: <> ( * 2. Correct the odd `em` font sizing in all browsers.)

[comment]: <> ( */)

[comment]: <> (pre {)

[comment]: <> (  font-family: monospace, monospace; /* 1 */)

[comment]: <> (  font-size: 1em; /* 2 */)

[comment]: <> (})

[comment]: <> (/* Text-level semantics)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/**)

[comment]: <> ( * Remove the gray background on active links in IE 10.)

[comment]: <> ( */)

[comment]: <> (a {)

[comment]: <> (  background-color: transparent;)

[comment]: <> (  text-decoration: none;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * 1. Remove the bottom border in Chrome 57-)

[comment]: <> ( * 2. Add the correct text decoration in Chrome, Edge, IE, Opera, and Safari.)

[comment]: <> ( */)

[comment]: <> (abbr[title] {)

[comment]: <> (  border-bottom: none; /* 1 */)

[comment]: <> (  text-decoration: underline; /* 2 */)

[comment]: <> (  text-decoration: underline dotted; /* 2 */)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Add the correct font weight in Chrome, Edge, and Safari.)

[comment]: <> ( */)

[comment]: <> (b,)

[comment]: <> (strong {)

[comment]: <> (  font-weight: bolder;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * 1. Correct the inheritance and scaling of font size in all browsers.)

[comment]: <> ( * 2. Correct the odd `em` font sizing in all browsers.)

[comment]: <> ( */)

[comment]: <> (code,)

[comment]: <> (kbd,)

[comment]: <> (samp {)

[comment]: <> (  font-family: monospace, monospace; /* 1 */)

[comment]: <> (  font-size: 1em; /* 2 */)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Add the correct font size in all browsers.)

[comment]: <> ( */)

[comment]: <> (small {)

[comment]: <> (  font-size: 80%;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Prevent `sub` and `sup` elements from affecting the line height in)

[comment]: <> ( * all browsers.)

[comment]: <> ( */)

[comment]: <> (sub,)

[comment]: <> (sup {)

[comment]: <> (  font-size: 75%;)

[comment]: <> (  line-height: 0;)

[comment]: <> (  position: relative;)

[comment]: <> (  vertical-align: baseline;)

[comment]: <> (})

[comment]: <> (sub {)

[comment]: <> (  bottom: -0.25em;)

[comment]: <> (})

[comment]: <> (sup {)

[comment]: <> (  top: -0.5em;)

[comment]: <> (})

[comment]: <> (/* Embedded content)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/**)

[comment]: <> ( * Remove the border on images inside links in IE 10.)

[comment]: <> ( */)

[comment]: <> (img {)

[comment]: <> (  display: block;)

[comment]: <> (  border-style: none;)

[comment]: <> (})

[comment]: <> (/* Forms)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/**)

[comment]: <> ( * 1. Change the font styles in all browsers.)

[comment]: <> ( * 2. Remove the margin in Firefox and Safari.)

[comment]: <> ( */)

[comment]: <> (button,)

[comment]: <> (input,)

[comment]: <> (optgroup,)

[comment]: <> (select,)

[comment]: <> (textarea {)

[comment]: <> (  font-family: inherit; /* 1 */)

[comment]: <> (  font-size: 100%; /* 1 */)

[comment]: <> (  line-height: 1.15; /* 1 */)

[comment]: <> (  margin: 0; /* 2 */)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Show the overflow in IE.)

[comment]: <> ( * 1. Show the overflow in Edge.)

[comment]: <> ( */)

[comment]: <> (button,)

[comment]: <> (input {)

[comment]: <> (  /* 1 */)

[comment]: <> (  overflow: visible;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Remove the inheritance of text transform in Edge, Firefox, and IE.)

[comment]: <> ( * 1. Remove the inheritance of text transform in Firefox.)

[comment]: <> ( */)

[comment]: <> (button,)

[comment]: <> (select {)

[comment]: <> (  /* 1 */)

[comment]: <> (  text-transform: none;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Correct the inability to style clickable types in iOS and Safari.)

[comment]: <> ( */)

[comment]: <> (button,)

[comment]: <> ([type='button'],)

[comment]: <> ([type='reset'],)

[comment]: <> ([type='submit'] {)

[comment]: <> (  -webkit-appearance: button;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Remove the inner border and padding in Firefox.)

[comment]: <> ( */)

[comment]: <> (button::-moz-focus-inner,)

[comment]: <> ([type='button']::-moz-focus-inner,)

[comment]: <> ([type='reset']::-moz-focus-inner,)

[comment]: <> ([type='submit']::-moz-focus-inner {)

[comment]: <> (  border-style: none;)

[comment]: <> (  padding: 0;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Restore the focus styles unset by the previous rule.)

[comment]: <> ( */)

[comment]: <> (button:-moz-focusring,)

[comment]: <> ([type='button']:-moz-focusring,)

[comment]: <> ([type='reset']:-moz-focusring,)

[comment]: <> ([type='submit']:-moz-focusring {)

[comment]: <> (  outline: 1px dotted ButtonText;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Correct the padding in Firefox.)

[comment]: <> ( */)

[comment]: <> (fieldset {)

[comment]: <> (  padding: 0.35em 0.75em 0.625em;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * 1. Correct the text wrapping in Edge and IE.)

[comment]: <> ( * 2. Correct the color inheritance from `fieldset` elements in IE.)

[comment]: <> ( * 3. Remove the padding so developers are not caught out when they zero out)

[comment]: <> ( *    `fieldset` elements in all browsers.)

[comment]: <> ( */)

[comment]: <> (legend {)

[comment]: <> (  box-sizing: border-box; /* 1 */)

[comment]: <> (  color: inherit; /* 2 */)

[comment]: <> (  display: table; /* 1 */)

[comment]: <> (  max-width: 100%; /* 1 */)

[comment]: <> (  padding: 0; /* 3 */)

[comment]: <> (  white-space: normal; /* 1 */)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Add the correct vertical alignment in Chrome, Firefox, and Opera.)

[comment]: <> ( */)

[comment]: <> (progress {)

[comment]: <> (  vertical-align: baseline;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Remove the default vertical scrollbar in IE 10+.)

[comment]: <> ( */)

[comment]: <> (textarea {)

[comment]: <> (  overflow: auto;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * 1. Add the correct box sizing in IE 10.)

[comment]: <> ( * 2. Remove the padding in IE 10.)

[comment]: <> ( */)

[comment]: <> ([type='checkbox'],)

[comment]: <> ([type='radio'] {)

[comment]: <> (  box-sizing: border-box; /* 1 */)

[comment]: <> (  padding: 0; /* 2 */)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Correct the cursor style of increment and decrement buttons in Chrome.)

[comment]: <> ( */)

[comment]: <> ([type='number']::-webkit-inner-spin-button,)

[comment]: <> ([type='number']::-webkit-outer-spin-button {)

[comment]: <> (  height: auto;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * 1. Correct the odd appearance in Chrome and Safari.)

[comment]: <> ( * 2. Correct the outline style in Safari.)

[comment]: <> ( */)

[comment]: <> ([type='search'] {)

[comment]: <> (  -webkit-appearance: textfield; /* 1 */)

[comment]: <> (  outline-offset: -2px; /* 2 */)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Remove the inner padding in Chrome and Safari on macOS.)

[comment]: <> ( */)

[comment]: <> ([type='search']::-webkit-search-decoration {)

[comment]: <> (  -webkit-appearance: none;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * 1. Correct the inability to style clickable types in iOS and Safari.)

[comment]: <> ( * 2. Change font properties to `inherit` in Safari.)

[comment]: <> ( */)

[comment]: <> (::-webkit-file-upload-button {)

[comment]: <> (  -webkit-appearance: button; /* 1 */)

[comment]: <> (  font: inherit; /* 2 */)

[comment]: <> (})

[comment]: <> (/* Interactive)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/*)

[comment]: <> ( * Add the correct display in Edge, IE 10+, and Firefox.)

[comment]: <> ( */)

[comment]: <> (details {)

[comment]: <> (  display: block;)

[comment]: <> (})

[comment]: <> (/*)

[comment]: <> ( * Add the correct display in all browsers.)

[comment]: <> ( */)

[comment]: <> (summary {)

[comment]: <> (  display: list-item;)

[comment]: <> (})

[comment]: <> (/* Misc)

[comment]: <> (   ========================================================================== */)

[comment]: <> (/**)

[comment]: <> ( * Add the correct display in IE 10+.)

[comment]: <> ( */)

[comment]: <> (template {)

[comment]: <> (  display: none;)

[comment]: <> (})

[comment]: <> (/**)

[comment]: <> ( * Add the correct display in IE 10.)

[comment]: <> ( */)

[comment]: <> ([hidden] {)

[comment]: <> (  display: none;)

[comment]: <> (})

[comment]: <> (ul,)

[comment]: <> (li {)

[comment]: <> (  list-style: none;)

[comment]: <> (})

[comment]: <> (```)

[comment]: <> (## 2.4 使用 路由规则 完成项目搭建)

[comment]: <> (- `/router/index.js` ：路由规则)

[comment]: <> (```javascript)

[comment]: <> (import Vue from 'vue')

[comment]: <> (import VueRouter from 'vue-router')

[comment]: <> (import Login from '@/views/Login')

[comment]: <> (import Index from '@/views/Index')

[comment]: <> (Vue.use&#40;VueRouter&#41;)

[comment]: <> (const routes = [)

[comment]: <> (  {)

[comment]: <> (    path: '/login',)

[comment]: <> (    name: 'Login',)

[comment]: <> (    component: Login,)

[comment]: <> (  },)

[comment]: <> (  {)

[comment]: <> (    path: '/',)

[comment]: <> (    name: 'Index',)

[comment]: <> (    component: Index,)

[comment]: <> (    children: [)

[comment]: <> (      {)

[comment]: <> (        path: '/user/center',)

[comment]: <> (        name: 'userCenter',)

[comment]: <> (        component: &#40;&#41; => import&#40;'@/views/user/Center'&#41;,)

[comment]: <> (      },)

[comment]: <> (      {)

[comment]: <> (        path: '/sys/users',)

[comment]: <> (        name: 'SysUser',)

[comment]: <> (        component: &#40;&#41; => import&#40;'@/views/sys/User'&#41;,)

[comment]: <> (      },)

[comment]: <> (      {)

[comment]: <> (        path: '/sys/roles',)

[comment]: <> (        name: 'SysRole',)

[comment]: <> (        component: &#40;&#41; => import&#40;'@/views/sys/Role'&#41;,)

[comment]: <> (      },)

[comment]: <> (      {)

[comment]: <> (        path: '/sys/menus',)

[comment]: <> (        name: 'SysMenu',)

[comment]: <> (        component: &#40;&#41; => import&#40;'@/views/sys/Menu'&#41;,)

[comment]: <> (      },)

[comment]: <> (    ],)

[comment]: <> (  },)

[comment]: <> (])

[comment]: <> (const router = new VueRouter&#40;{)

[comment]: <> (  /* 采用history模式，利用了HTML5 History Interface 解决URL没有 “#” 号的问题 */)

[comment]: <> (  mode: 'history',)

[comment]: <> (  routes,)

[comment]: <> (}&#41;)

[comment]: <> (export default router)

[comment]: <> (```)

[comment]: <> (- `/views/xxx.vue` ：页面渲染)

[comment]: <> (```vue)

[comment]: <> (<template>)

[comment]: <> (  <div>XX管理</div>)

[comment]: <> (</template>)

[comment]: <> (<script>)

[comment]: <> (export default {)

[comment]: <> (  name: 'SysXxxx',)

[comment]: <> (})

[comment]: <> (</script>)

[comment]: <> (```)
