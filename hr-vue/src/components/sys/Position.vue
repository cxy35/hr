<template>
    <div>
        <div>
            <el-input
                    class="position-add-name"
                    placeholder="请输入职位名称"
                    prefix-icon="el-icon-plus"
                    v-model="positionAdd.name"
                    @keydown.enter.native="handleAdd">
            </el-input>
            <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增职位</el-button>
        </div>
        <div>
            <el-table
                    class="position-table"
                    v-loading="loading"
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    :data="positions"
                    stripe
                    border
                    size="mini"
                    @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column prop="id" label="编号" width="60"></el-table-column>
                <el-table-column prop="name" label="职位名称" width="180"></el-table-column>
                <el-table-column prop="createDate" label="创建时间" width="180"></el-table-column>
                <el-table-column label="是否启用" width="100">
                    <template slot-scope="scope">
                        <el-tag type="success" v-if="scope.row.enabled">已启用</el-tag>
                        <el-tag type="danger" v-else>未启用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="操作" align="center">
                    <template slot-scope="scope">
                        <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-button
                    class="position-deletemulti-btn"
                    type="danger"
                    :disabled="this.multipleSelection.length == 0"
                    @click="handleDeleteMulti">批量删除
            </el-button>
        </div>
        <el-dialog
                title="编辑职位"
                :visible.sync="dialogVisible"
                width="30%">
            <div>
                <table class="position-edit-table">
                    <tr>
                        <td>
                            <el-tag>职位名称</el-tag>
                        </td>
                        <td>
                            <el-input v-model="positionEdit.name" placeholder="请输入职位名称"></el-input>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>是否启用</el-tag>
                        </td>
                        <td>
                            <el-switch
                                    v-model="positionEdit.enabled"
                                    active-text="启用"
                                    inactive-text="禁用">
                            </el-switch>
                        </td>
                    </tr>
                </table>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleEditConfirm">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "Position",
        data() {
            return {
                positionAdd: {
                    name: ''
                },
                positionEdit: {
                    name: '',
                    enabled: false
                },
                positions: [],
                multipleSelection: [],
                dialogVisible: false,
                loading: false
            }
        },
        mounted() {
            this.initPositions();
        },
        methods: {
            initPositions() {
                this.loading = true;
                this.getRequest("/system/basic/position/getListAll").then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.positions = resp;
                    }
                });
            },
            initPositionAdd() {
                this.positionAdd = {
                    name: ''
                };
            },
            initPositionEdit() {
                this.positionEdit = {
                    name: '',
                    enabled: false
                };
            },
            handleAdd() {
                if (this.positionAdd.name) {
                    this.postRequest("/system/basic/position/add", this.positionAdd).then(resp => {
                        if (resp) {
                            this.initPositions();
                            this.initPositionAdd();
                        }
                    });
                } else {
                    this.$message.error('职位名称不能为空');
                }
            },
            handleEdit(index, data) {
                Object.assign(this.positionEdit, data);// 数据复制一份
                this.dialogVisible = true;
            },
            handleEditConfirm() {
                if (this.positionEdit.name) {
                    this.putRequest("/system/basic/position/edit", this.positionEdit).then(resp => {
                        if (resp) {
                            this.initPositions();
                            this.initPositionEdit();
                            this.dialogVisible = false;
                        }
                    });
                } else {
                    this.$message.error('职位名称不能为空');
                }
            },
            handleDelete(index, data) {
                this.$confirm('此操作将永久删除【' + data.name + '】职位, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/position/deleteById/" + data.id).then(resp => {
                        if (resp) {
                            this.initPositions();
                        }
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            handleDeleteMulti() {
                this.$confirm('此操作将永久删除【' + this.multipleSelection.length + '】条记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    let ids = "";
                    this.multipleSelection.forEach(item => {
                        if (ids != "") {
                            ids += "&";
                        }
                        ids += "ids=" + item.id;
                    });
                    this.deleteRequest("/system/basic/position/deleteByIds?" + ids).then(resp => {
                        if (resp) {
                            this.initPositions();
                        }
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            }
        }
    }
</script>

<style scoped>
    .position-add-name {
        width: 30%;
        margin-right: 10px;
    }

    .position-table {
        width: 80%;
        margin-top: 10px;
    }

    .position-edit-table td {
        padding: 10px 10px 0px 0px;
    }

    .position-deletemulti-btn {
        margin-top: 10px;
    }
</style>