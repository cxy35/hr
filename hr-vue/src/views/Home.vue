<template>
    <div>
        <el-container>
            <el-header class="home-header">
                <div class="home-header-title">HR 管理系统</div>
                <div>
                    <el-button class="home-header-chat" type="text" icon="el-icon-message" size="normal" @click="handleChat"></el-button>
                    <el-dropdown class="home-header-user" @command="commandHandler">
                        <span class="home-header-user-name">
                            {{user.name}}<i><img :src="user.userface" alt=""></i>
                        </span>
                        <el-dropdown-menu slot="dropdown">
                            <el-dropdown-item command="userinfo">个人中心</el-dropdown-item>
                            <el-dropdown-item command="setting">设置</el-dropdown-item>
                            <el-dropdown-item command="logout" divided>注销</el-dropdown-item>
                        </el-dropdown-menu>
                    </el-dropdown>
                </div>
            </el-header>
            <el-container>
                <el-aside width="200px">
                    <el-menu router unique-opened>
                        <el-submenu :index="index+''" v-for="(item,index) in routes" :key="index" v-if="!item.hidden">
                            <template slot="title">
                                <!--<i class="el-icon-location"></i>-->
                                <i class="home-aside-menu-icon" :class="item.iconCls"></i>
                                <span>{{item.name}}</span>
                            </template>
                            <el-menu-item :index="child.path" v-for="(child,indexj) in item.children" :key="indexj">
                                {{child.name}}
                            </el-menu-item>
                        </el-submenu>
                    </el-menu>
                </el-aside>
                <el-main>
                    <el-breadcrumb separator-class="el-icon-arrow-right" v-if="this.$router.currentRoute.path!='/home'">
                        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
                        <el-breadcrumb-item>{{this.$router.currentRoute.name}}</el-breadcrumb-item>
                    </el-breadcrumb>
                    <div class="home-main-welcome" v-if="this.$router.currentRoute.path=='/home'">
                        欢迎来到 HR 管理系统
                    </div>
                    <router-view class="home-main-router-view"/>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script>
    export default {
        name: "Home",
        data() {
            return {
                user: JSON.parse(window.sessionStorage.getItem("user"))
                // ,routes: this.$router.options.routes // 方式1：菜单写死在router/index.js的router中
            }
        },
        computed: {
            routes() {
                return this.$store.state.routes; // 方式2：菜单由后台动态获取，初始化菜单（initMenu）时写入store/index.js的store中
            }
        },
        methods: {
            handleChat() {
                this.$router.push("/chat");
            },
            commandHandler(command) {
                if (command == 'logout') {
                    this.$confirm('此操作将注销登录, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        this.getRequest("/logout");
                        window.sessionStorage.removeItem("user");
                        this.$store.commit('initRoutes', []);
                        this.$router.replace("/");
                    }).catch(() => {
                        this.$message({
                            type: 'info',
                            message: '已取消操作'
                        });
                    });
                }
            }
        }
    }
</script>

<style scoped>
    .home-header {
        background-color: #409eff;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0px 15px;
        box-sizing: border-box;
    }

    .home-header-title {
        font-size: 30px;
        font-family: 华文行楷;
        color: #ffffff;
    }

    .home-header-chat{
        margin-right: 10px;
        color: #ffffff;
    }

    .home-header-user {
        cursor: pointer;
    }

    .home-header-user-name {
        display: flex;
        align-items: center;
        color: #ffffff;
    }

    .home-header-user-name img {
        width: 48px;
        height: 48px;
        border-radius: 24px;
        margin-left: 8px;
    }

    /*.home-aside {
        background-color: #ECECEC;
    }*/

    /*.home-aside-menu {
        display: flex;
        justify-content: flex-start;
        width: 200px;
        text-align: left;
        background: #ececec;
    }*/

    .home-aside-menu-icon {
        color: #409eff;
        margin-right: 5px;
    }

    /*.home-aside-menu-item {
        width: 200px;
        padding-left: 30px;
        padding-right: 0px;
        margin-left: 0px;
        text-align: left
    }*/

    .home-main-welcome {
        text-align: center;
        font-size: 30px;
        font-family: 华文行楷;
        color: #409eff;
        padding-top: 50px;
    }

    .home-main-router-view {
        margin-top: 10px;
    }
</style>
