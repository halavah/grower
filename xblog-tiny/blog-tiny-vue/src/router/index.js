import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "@/views/Login";
import PostList from "@/views/PostList";
import PostDetail from "@/views/PostDetail";
import PostEdit from "@/views/PostEdit";

Vue.use(VueRouter);

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/',
    name: 'Index',
    redirect: {name: "PostList"}   /*重定向至 Blogs 组件*/
  },
  {
    path: '/post/list',
    name: 'PostList',
    component: PostList           /*主页【查看全部文章】*/
  },
  {
    path: '/post/add',
    name: 'PostAdd',
    component: PostEdit,          /*发表【新建一篇文章】*/
    meta: {
      requireAuth: true           /*对应【权限拦截】自定义规则*/
    }
  },
  {
    path: '/post/:postId',
    name: 'PostDetail',
    component: PostDetail         /*详情【查看某篇文章】*/
  },
  {
    path: '/post/:postId/edit',
    name: 'PostEdit',
    component: PostEdit,          /*编辑【编辑某篇文章】*/
    meta: {
      requireAuth: true           /*对应【权限拦截】自定义规则*/
    }
  }
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
