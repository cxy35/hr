<template>
    <div>
        <div class="user-search-container">
            <el-input
                    class="user-search-name"
                    placeholder="输入姓名搜索"
                    prefix-icon="el-icon-search"
                    v-model="searchData.name"
                    @keydown.enter.native="handleSearch">
            </el-input>
            <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
        </div>
        <div
                class="user-container"
                v-loading="loading"
                element-loading-text="正在加载..."
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(0, 0, 0, 0.8)">
            <el-card class="user-card" v-for="(user, index) in users" :key="index">
                <div slot="header">
                    <span>{{user.name}}</span>
                    <el-button class="user-card-delete-btn" size="medium" type="text" icon="el-icon-delete"
                               @click="handleDelete(user)"></el-button>
                </div>
                <div>
                    <div class="user-card-userface-container">
                        <img class="user-card-userface" :src="user.userface" :alt="user.name" :title="user.name">
                    </div>
                    <div class="user-card-userinfo-container">
                        <div>用户名：{{user.username}}</div>
                        <div>手机号码：{{user.phone}}</div>
                        <div>电话号码：{{user.telephone}}</div>
                        <div>地址：{{user.address}}</div>
                        <div>是否启用：
                            <el-switch
                                    v-model="user.enabled"
                                    active-color="#13ce66"
                                    inactive-color="#ff4949"
                                    active-text="启用"
                                    inactive-text="禁用"
                                    @change="handleEditEnabled(user)">
                            </el-switch>
                        </div>
                        <div>用户角色：
                            <el-tag class="user-card-userinfo-role" type="success" v-for="(role, index2) in user.roles"
                                    :key="index2">{{role.nameZh}}
                            </el-tag>
                            <el-popover
                                    placement="right"
                                    title="角色列表"
                                    width="200"
                                    trigger="click"
                                    @show="handleShow(user)"
                                    @hide="handleHide(user)">
                                <el-select v-model="selectedRoleIds" multiple placeholder="请选择">
                                    <el-option
                                            v-for="(r, index3) in roles"
                                            :key="index3"
                                            :label="r.nameZh"
                                            :value="r.id">
                                    </el-option>
                                </el-select>
                                <el-button slot="reference" icon="el-icon-more" type="text"></el-button>
                            </el-popover>
                        </div>
                        <div>备注：{{user.remark}}</div>
                    </div>
                </div>
            </el-card>
        </div>
    </div>
</template>

<script>
    export default {
        name: "SysUser",
        data() {
            return {
                searchData: {
                    name: ''
                },
                users: [],
                roles: [],
                selectedRoleIds: [],
                loading: false
            }
        },
        mounted() {
            this.initUsers();
        },
        methods: {
            initUsers() {
                this.loading = true;
                this.getRequest("/system/user/getListWithRoles?name=" + this.searchData.name).then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.users = resp;
                    }
                });
            },
            initRoles() {
                this.getRequest("/system/basic/role/getListAll").then(resp => {
                    if (resp) {
                        this.roles = resp;
                    }
                });
            },
            handleSearch() {
                this.initUsers();
            },
            handleEditEnabled(user) {
                delete user.roles; // 请求时列表映射有问题，所以这里先删除
                this.putRequest("/system/user/edit", user).then(resp => {
                    if (resp) {
                        this.initUsers();
                    }
                });
            },
            handleDelete(user) {
                this.$confirm('此操作将永久删除【' + user.name + '】用户, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/user/deleteById/" + user.id).then(resp => {
                        if (resp) {
                            this.initUsers();
                        }
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            handleShow(user) {
                this.initRoles();
                let roles = user.roles;
                this.selectedRoleIds = [];
                roles.forEach(role => {
                    this.selectedRoleIds.push(role.id);
                })
            },
            handleHide(user) {
                let uid = user.id;
                if (!uid) {
                    this.$message.error('用户不能为空');
                    return;
                }

                let flag = false;// 是否需要更新
                let roles = [];
                Object.assign(roles, user.roles);// 数据复制一份
                if (roles.length != this.selectedRoleIds.length) {
                    flag = true;
                } else {
                    for (let i = 0; i < roles.length; i++) {
                        let role = roles[i];
                        for (let j = 0; j < this.selectedRoleIds.length; j++) {
                            let sr = this.selectedRoleIds[j];
                            if (role.id == sr) {
                                roles.splice(i, 1);// 移除重复的
                                i--;
                                break;
                            }
                        }
                    }
                    if (roles.length != 0) {
                        flag = true;
                    }
                }

                if (flag) {
                    let url = "/system/user/editUserRole?uid=" + uid;
                    this.selectedRoleIds.forEach(rid => {
                        url += "&rids=" + rid;
                    });
                    this.putRequest(url).then(resp => {
                        if (resp) {
                            this.initUsers();
                        }
                    });
                }
            }
        }
    }
</script>

<style scoped>
    .user-search-container {
        display: flex;
        justify-content: center;
    }

    .user-search-name {
        width: 30%;
        padding-right: 10px;
    }

    .user-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
        margin-top: 10px;
    }

    .user-card {
        width: 30%;
        margin-top: 10px;
    }

    .user-card-delete-btn {
        float: right;
        padding: 3px 0;
        color: red;
    }

    .user-card-userface-container {
        width: 100%;
        display: flex;
        justify-content: center;
    }

    .user-card-userface {
        width: 72px;
        height: 72px;
        border-radius: 72px;
    }

    .user-card-userinfo-container {
        margin-top: 10px;
    }

    .user-card-userinfo-container > div {
        font-size: 14px;
        color: #409eff;
        margin-top: 5px;
    }

    .user-card-userinfo-role {
        margin-right: 5px;
    }
</style>