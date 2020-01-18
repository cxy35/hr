<template>
    <div>
        <div>
            <el-input
                    class="department-search-name"
                    placeholder="输入部门名称搜索"
                    prefix-icon="el-icon-search"
                    v-model="filterText">
            </el-input>
        </div>
        <div>
            <el-tree
                    class="department-tree"
                    v-loading="loading"
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    :data="departments"
                    :props="defaultProps"
                    :expand-on-click-node="false"
                    :filter-node-method="filterNode"
                    ref="tree">
                <span class="department-tree-node" slot-scope="{ node, data }">
                    <span>{{ data.name }}</span>
                    <span>
                        <el-button
                                class="department-tree-btn"
                                type="primary"
                                size="mini"
                                @click="handleAdd(data)">新增
                            </el-button>
                        <el-button
                                class="department-tree-btn"
                                type="primary"
                                size="mini"
                                @click="handleEdit(data)">编辑
                        </el-button>
                        <el-button
                                class="department-tree-btn"
                                type="danger"
                                size="mini"
                                @click="handleDelete(data)">删除
                        </el-button>
                    </span>
                  </span>
            </el-tree>
        </div>
        <el-dialog
                title="新增部门"
                :visible.sync="addDialogVisible"
                width="30%">
            <div>
                <table class="department-add-table">
                    <tr>
                        <td>
                            <el-tag>上级部门</el-tag>
                        </td>
                        <td>
                            {{this.departmentAdd.parentName}}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>部门名称</el-tag>
                        </td>
                        <td>
                            <el-input v-model="departmentAdd.name" placeholder="请输入部门名称"></el-input>
                        </td>
                    </tr>
                </table>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="addDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleAddConfirm">确 定</el-button>
              </span>
        </el-dialog>
        <el-dialog
                title="编辑部门"
                :visible.sync="editDialogVisible"
                width="30%">
            <div>
                <table class="department-edit-table">
                    <tr>
                        <td>
                            <el-tag>部门名称</el-tag>
                        </td>
                        <td>
                            <el-input v-model="departmentEdit.name" placeholder="请输入部门名称"></el-input>
                        </td>
                    </tr>
                </table>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleEditConfirm">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "Department",
        data() {
            return {
                filterText: '',
                departments: [],
                defaultProps: {
                    children: 'children',
                    label: 'name'
                },
                addDialogVisible: false,
                editDialogVisible: false,
                departmentAdd: {
                    name: '',
                    parentId: -1,
                    parentName: ''
                },
                departmentEdit: {
                    name: ''
                },
                loading: false
            };
        },
        watch: {
            filterText(val) {
                this.$refs.tree.filter(val);
            }
        },
        mounted() {
            this.initDepartments();
        },
        methods: {
            initDepartments() {
                this.loading = true;
                this.getRequest("/system/basic/department/getListAllWithChildren").then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.departments = resp;
                    }
                });
            },
            initDepartmentAdd() {
                this.departmentAdd = {
                    name: '',
                    parentId: -1,
                    parentName: ''
                };
            },
            initDepartmentEdit() {
                this.departmentEdit = {
                    name: ''
                };
            },
            filterNode(value, data) {
                if (!value) return true;
                return data.name.indexOf(value) !== -1;
            },
            handleTreeAdd(departments, addData) {
                // 将 addData 加到 treeData 对应的父节点上
                for (let i = 0; i < departments.length; i++) {
                    let data = departments[i];
                    if (data.id == addData.parentId) {
                        data.children = data.children.concat(addData);
                        if (data.children.length > 0) {
                            data.isParent = true;
                        }
                        return;
                    } else {
                        // 递归处理 children
                        this.handleTreeAdd(data.children, addData);
                    }
                }
            },
            handleTreeEdit(departments, editData) {
                // 将 editData 更新到 departments 对应的节点上
                for (let i = 0; i < departments.length; i++) {
                    let data = departments[i];
                    if (data.id == editData.id) {
                        data.name = editData.name;
                        return;
                    } else {
                        // 递归处理 children
                        this.handleTreeEdit(data.children, editData);
                    }
                }
            },
            handleTreeDelete(dataParent, departments, deleteDataId) {
                // 将 deleteDataId 对应的节点从 departments 中删除
                for (let i = 0; i < departments.length; i++) {
                    let data = departments[i];
                    if (data.id == deleteDataId) {
                        departments.splice(i, 1);
                        if (departments.length == 0) {
                            dataParent.isParent = false;
                        }
                        return;
                    } else {
                        this.handleTreeDelete(data, data.children, deleteDataId);
                    }
                }
            },
            handleAdd(data) {
                this.departmentAdd.parentId = data.id;
                this.departmentAdd.parentName = data.name;
                this.addDialogVisible = true;
            },
            handleAddConfirm() {
                if (this.departmentAdd.name && this.departmentAdd.parentId) {
                    this.postRequest("/system/basic/department/add", this.departmentAdd).then(resp => {
                        if (resp) {
                            // 只处理当前新增的数据，不初始化整个 departments
                            this.handleTreeAdd(this.departments, resp.obj);
                            this.initDepartmentAdd();
                            this.addDialogVisible = false;
                        }
                    });
                } else {
                    this.$message.error('部门名称和上级部门不能为空');
                }
            },
            handleEdit(data) {
                Object.assign(this.departmentEdit, data);// 数据复制一份
                this.editDialogVisible = true;
            },
            handleEditConfirm() {
                if (this.departmentEdit.name) {
                    this.putRequest("/system/basic/department/edit", this.departmentEdit).then(resp => {
                        if (resp) {
                            // 只处理当前编辑的数据，不初始化整个 departments
                            this.handleTreeEdit(this.departments, this.departmentEdit);
                            this.initDepartmentEdit();
                            this.editDialogVisible = false;
                        }
                    });
                } else {
                    this.$message.error('部门名称不能为空');
                }
            },
            handleDelete(data) {
                if (data.isParent) {
                    this.$message.error("删除失败，父部门不能删除");
                } else {
                    this.$confirm('此操作将永久删除【' + data.name + '】部门, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        this.deleteRequest("/system/basic/department/deleteById/" + data.id).then(resp => {
                            if (resp) {
                                // 只处理当前删除的数据，不初始化整个 departments
                                this.handleTreeDelete(null, this.departments, data.id);
                            }
                        });
                    }).catch(() => {
                        this.$message({
                            type: 'info',
                            message: '已取消删除'
                        });
                    });
                }
            }
        }
    }
</script>

<style scoped>
    .department-search-name {
        width: 30%;
    }

    .department-tree {
        width: 60%;
        margin-top: 10px;
    }

    .department-tree-node {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-size: 14px;
        padding-right: 8px;
    }

    .department-tree-btn {
        padding: 2px 10px;
    }

    .department-add-table td, .department-edit-table td {
        padding: 10px 10px 0px 0px;
    }
</style>