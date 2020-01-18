<template>
    <div
            v-loading="addLoading"
            element-loading-text="正在新增..."
            element-loading-spinner="el-icon-loading"
            element-loading-background="rgba(0, 0, 0, 0.8)">
        <div>
            <el-input class="role-add-name" placeholder="请输入角色名称"
                      v-model="role.name">
                <template slot="prepend">ROLE_</template>
            </el-input>
            <el-input class="role-add-nameZh" placeholder="请输入角色中文名称" v-model="role.nameZh"
                      @keydown.enter.native="handleAdd"></el-input>
            <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增角色</el-button>
        </div>
        <div>
            <el-collapse
                    class="role-collapse"
                    v-loading="loading"
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    v-model="activeName"
                    accordion
                    @change="handleChange">
                <el-collapse-item :title="role.nameZh" :name="role.id" v-for="(role,index) in roles" :key="index">
                    <el-card>
                        <div slot="header">
                            <span>可访问的菜单</span>
                            <el-button class="role-delete-btn" size="medium" type="text" icon="el-icon-delete"
                                       @click="handleDelete(role)"></el-button>
                        </div>
                        <div>
                            <el-tree
                                    show-checkbox
                                    node-key="id"
                                    ref="tree"
                                    :key="index"
                                    :data="menus"
                                    :default-checked-keys="defaultCheckedKeys"
                                    :props="defaultProps">
                            </el-tree>
                            <div class="role-edit-div">
                                <el-button size="mini" @click="activeName = -1">取 消</el-button>
                                <el-button size="mini" type="primary" @click="handleEditRoleMenu(role.id, index)">确 定
                                </el-button>
                            </div>
                        </div>
                    </el-card>
                </el-collapse-item>
            </el-collapse>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Role",
        data() {
            return {
                role: {
                    name: '',
                    nameZh: ''
                },
                activeName: -1, // 不展开任何面板
                roles: [],
                menus: [],
                defaultCheckedKeys: [],
                defaultProps: {
                    children: 'children',
                    label: 'name'
                },
                loading: false,
                addLoading: false
            }
        },
        mounted() {
            this.initRoles();
        },
        methods: {
            initRoles() {
                this.loading = true;
                this.getRequest("/system/basic/role/getListAll").then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.roles = resp;
                    }
                });
            },
            initRole() {
                this.role = {
                    name: '',
                    nameZh: ''
                };
            },
            initMenus() {
                this.getRequest("/system/basic/role/getMenuListAllWithChildren").then(resp => {
                    if (resp) {
                        this.menus = resp;
                    }
                });
            },
            initCheckedKeys(rid) {
                this.getRequest("/system/basic/role/getMidsByRid/" + rid).then(resp => {
                    if (resp) {
                        this.defaultCheckedKeys = resp;
                    }
                });
            },
            handleAdd() {
                if (this.role.name && this.role.nameZh) {
                    this.addLoading = true;
                    this.postRequest("/system/basic/role/add", this.role).then(resp => {
                        this.addLoading = false;
                        if (resp) {
                            this.initRoles();
                            this.initRole();
                        }
                    });
                } else {
                    this.$message.error('角色名称和角色中文名称不能为空');
                }
            },
            handleEditRoleMenu(rid, index) {
                if (rid) {
                    let tree = this.$refs.tree[index];
                    let checkedKeys = tree.getCheckedKeys(tree);
                    let url = "/system/basic/role/editRoleMenu?rid=" + rid;
                    checkedKeys.forEach(key => {
                        url += "&mids=" + key;
                    });
                    this.putRequest(url).then(resp => {
                        if (resp) {
                            this.activeName = -1;
                        }
                    });
                } else {
                    this.$message.error('角色不能为空');
                }
            },
            handleDelete(role) {
                this.$confirm('此操作将永久删除【' + role.nameZh + '】角色, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/role/deleteById/" + role.id).then(resp => {
                        if (resp) {
                            this.initRoles();
                            this.initRole();
                        }
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            handleChange(rid) {
                if (rid) {
                    //  TODO BUG:不同折叠面板点击切换时，树中的 defaultCheckedKeys 值会错乱，感觉有缓存
                    this.initMenus();
                    this.initCheckedKeys(rid);
                }

            }
        }
    }
</script>

<style scoped>
    .role-add-name {
        width: 25%;
    }

    .role-add-nameZh {
        width: 25%;
        margin-left: 10px;
        margin-right: 10px;
    }

    .role-collapse {
        width: 60%;
        margin-top: 10px;
    }

    .role-delete-btn {
        float: right;
        padding: 3px 0;
        color: red;
    }

    .role-edit-div {
        display: flex;
        justify-content: flex-end;
        margin-top: 10px;
    }
</style>