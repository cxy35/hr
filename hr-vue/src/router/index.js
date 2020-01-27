import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "../views/Login";
import Home from "../views/Home";
import Chat from "../views/chat/Chat";

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: 'Login',
        component: Login,
        // lazy-loaded when the route is visited.
        // component: () => import(/* webpackChunkName: "login" */ '../views/Login.vue'),
        hidden: true
    }, {
        path: '/home',
        name: 'Home',
        component: Home,
        hidden: true,
        meta: {
            roles: ['admin', 'user']
        },
        children: [
            {
                path: '/chat',
                name: '在线聊天',
                component: Chat,
                hidden: true
            }
        ]
    }
]

const router = new VueRouter({
    routes
})

export default router
