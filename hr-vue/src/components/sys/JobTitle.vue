<template>
    <div>
        <div>
            <el-input
                    class="jobtitle-add-name"
                    placeholder="请输入职称名称"
                    prefix-icon="el-icon-plus"
                    v-model="jobTitleAdd.name"
                    @keydown.enter.native="handleAdd">
            </el-input>
            <el-select class="jobtitle-add-level" v-model="jobTitleAdd.level" placeholder="请选择职称等级">
                <el-option
                        v-for="item in levels"
                        :key="item"
                        :label="item"
                        :value="item">
                </el-option>
            </el-select>
            <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增职称</el-button>
        </div>
        <div>
            <el-table
                    class="jobtitle-table"
                    v-loading="loading"
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    :data="jobTitles"
                    stripe
                    border
                    @selection-change="handleSelectionChange">
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column
                        prop="id"
                        label="编号"
                        width="60">
                </el-table-column>
                <el-table-column
                        prop="name"
                        label="职称名称"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="level"
                        label="职称等级"
                        width="100">
                </el-table-column>
                <el-table-column
                        prop="createDate"
                        label="创建时间"
                        width="180">
                </el-table-column>
                <el-table-column
                        label="是否启用"
                        width="100">
                    <template slot-scope="scope">
                        <el-tag type="success" v-if="scope.row.enabled">已启用</el-tag>
                        <el-tag type="danger" v-else>未启用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button
                                size="mini"
                                @click="handleEdit(scope.$index, scope.row)">编辑
                        </el-button>
                        <el-button
                                size="mini"
                                type="danger"
                                @click="handleDelete(scope.$index, scope.row)">删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-button
                    class="jobtitle-deletemulti-btn"
                    type="danger"
                    :disabled="this.multipleSelection.length == 0"
                    @click="handleDeleteMulti">批量删除
            </el-button>
        </div>
        <el-dialog
                title="编辑职称"
                :visible.sync="dialogVisible"
                width="30%">
            <div>
                <table class="jobtitle-edit-table">
                    <tr>
                        <td>
                            <el-tag>职称名称</el-tag>
                        </td>
                        <td>
                            <el-input v-model="jobTitleEdit.name" placeholder="请输入职称名称"></el-input>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>职称等级</el-tag>
                        </td>
                        <td>
                            <el-select v-model="jobTitleEdit.level" placeholder="请选择职称等级">
                                <el-option
                                        v-for="item in levels"
                                        :key="item"
                                        :label="item"
                                        :value="item">
                                </el-option>
                            </el-select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>是否启用</el-tag>
                        </td>
                        <td>
                            <el-switch
                                    v-model="jobTitleEdit.enabled"
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
        name: "JobTitle",
        data() {
            return {
                levels: [
                    '正高级',
                    '副高级',
                    '中级',
                    '初级',
                    '员级',
                ],
                jobTitleAdd: {
                    name: '',
                    level: ''
                },
                jobTitleEdit: {
                    name: '',
                    level: '',
                    enabled: false
                },
                jobTitles: [],
                multipleSelection: [],
                dialogVisible: false,
                loading: false
            }
        },
        mounted() {
            this.initJobTitles();
        },
        methods: {
            initJobTitles() {
                this.loading = true;
                this.getRequest("/system/basic/jobTitle/getListAll").then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.jobTitles = resp;
                    }
                });
            },
            initJobTitleAdd() {
                this.jobTitleAdd = {
                    name: '',
                    level: ''
                };
            },
            initJobTitleEdit() {
                this.jobTitleEdit = {
                    name: '',
                    level: '',
                    enabled: false
                };
            },
            handleAdd() {
                if (this.jobTitleAdd.name && this.jobTitleAdd.level) {
                    this.postRequest("/system/basic/jobTitle/add", this.jobTitleAdd).then(resp => {
                        if (resp) {
                            this.initJobTitles();
                            this.initJobTitleAdd();
                        }
                    });
                } else {
                    this.$message.error('职称名称和职称等级不能为空');
                }
            },
            handleEdit(index, data) {
                Object.assign(this.jobTitleEdit, data);// 数据复制一份
                this.dialogVisible = true;
            },
            handleEditConfirm() {
                if (this.jobTitleEdit.name && this.jobTitleEdit.level) {
                    this.putRequest("/system/basic/jobTitle/edit", this.jobTitleEdit).then(resp => {
                        if (resp) {
                            this.initJobTitles();
                            this.initJobTitleEdit();
                            this.dialogVisible = false;
                        }
                    });
                } else {
                    this.$message.error('职称名称和职称等级不能为空');
                }
            },
            handleDelete(index, data) {
                this.$confirm('此操作将永久删除【' + data.name + '】职称, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/jobTitle/deleteById/" + data.id).then(resp => {
                        if (resp) {
                            this.initJobTitles();
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
                    this.deleteRequest("/system/basic/jobTitle/deleteByIds?" + ids).then(resp => {
                        if (resp) {
                            this.initJobTitles();
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
    .jobtitle-add-name {
        width: 30%;
    }

    .jobtitle-add-level {
        margin-left: 10px;
        margin-right: 10px;
    }

    .jobtitle-table {
        width: 80%;
        margin-top: 10px;
    }

    .jobtitle-edit-table td {
        padding: 10px 10px 0px 0px;
    }

    .jobtitle-deletemulti-btn {
        margin-top: 10px;
    }
</style>