<template>
    <div>
        <div class="salary-toolbar-container">
            <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增工资账套</el-button>
            <el-button type="success" icon="el-icon-refresh" @click="handleRefresh">刷新</el-button>
        </div>
        <div>
            <el-table
                    class="salary-table"
                    v-loading="loading"
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    :data="salaries"
                    stripe
                    border
                    @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column prop="name" label="账套名称" width="120"></el-table-column>
                <el-table-column prop="basicSalary" label="基本工资" width="80"></el-table-column>
                <el-table-column prop="trafficSalary" label="交通补助" width="80"></el-table-column>
                <el-table-column prop="lunchSalary" label="午餐补助" width="80"></el-table-column>
                <el-table-column prop="bonus" label="奖金" width="60"></el-table-column>
                <el-table-column prop="createDate" label="创建时间" width="140"></el-table-column>
                <el-table-column label="养老金" align="center">
                    <el-table-column prop="pensionPer" label="比率" width="60"></el-table-column>
                    <el-table-column prop="pensionBase" label="基数" width="60"></el-table-column>
                </el-table-column>
                <el-table-column label="医疗保险" align="center">
                    <el-table-column prop="medicalPer" label="比率" width="60"></el-table-column>
                    <el-table-column prop="medicalBase" label="基数" width="60"></el-table-column>
                </el-table-column>
                <el-table-column label="公积金" align="center">
                    <el-table-column prop="accumulationFundPer" label="比率" width="60"></el-table-column>
                    <el-table-column prop="accumulationFundBase" label="基数" width="60"></el-table-column>
                </el-table-column>
                <el-table-column label="操作" align="center">
                    <template slot-scope="scope">
                        <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
                        <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-button
                    class="salary-deletemulti-btn"
                    type="danger"
                    :disabled="this.multipleSelection.length == 0"
                    @click="handleDeleteMulti">批量删除
            </el-button>
        </div>
        <el-dialog
                :title="dialogTitle"
                :visible.sync="dialogVisible"
                width="50%">
            <div class="salary-steps-container">
                <el-steps direction="vertical" :active="activeStepIndex">
                    <el-step :title="name" v-for="(name,index) in salaryLabel" :key="index"></el-step>
                </el-steps>
                <el-input v-model="salary[title]" :placeholder="'请输入'+salaryLabel[index]+'...'"
                          v-for="(value,title,index) in salary"
                          :key="index" v-show="activeStepIndex==index" style="width: 50%"></el-input>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" v-show="btnPreVisible" @click="handlePreStep">上一步</el-button>
                <el-button type="primary" v-show="btnNextVisible" @click="handleNextStep">下一步</el-button>
                <el-button type="primary" v-show="btnConfirmVisible" @click="handleAddEditConfirm">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "SalSob",
        data() {
            return {
                salaries: [],
                multipleSelection: [],
                dialogTitle: '',
                dialogVisible: false,
                salary: {
                    // 顺序需要与 salaryLabel 对应
                    name: '',
                    basicSalary: 0,
                    trafficSalary: 0,
                    lunchSalary: 0,
                    bonus: 0,
                    pensionPer: 0,
                    pensionBase: 0,
                    medicalPer: 0,
                    medicalBase: 0,
                    accumulationFundPer: 0,
                    accumulationFundBase: 0
                },
                salaryLabel: [
                    // 顺序需要与 salary 对应
                    '账套名称',
                    '基本工资',
                    '交通补助',
                    '午餐补助',
                    '奖金',
                    '养老金比率',
                    '养老金基数',
                    '医疗保险比率',
                    '医疗保险基数',
                    '公积金比率',
                    '公积金基数'
                ],
                activeStepIndex: 0,
                btnConfirmVisible: false,
                btnPreVisible: false,
                btnNextVisible: true,
                loading: false
            }
        },
        watch: {
            activeStepIndex(val) {
                if (val == 0) {
                    this.btnConfirmVisible = false;
                    this.btnPreVisible = false;
                    this.btnNextVisible = true;
                } else if (val == 10) {
                    this.btnConfirmVisible = true;
                    this.btnPreVisible = true;
                    this.btnNextVisible = false;
                } else {
                    this.btnConfirmVisible = false;
                    this.btnPreVisible = true;
                    this.btnNextVisible = true;
                }
            }
        },
        mounted() {
            this.initSalaries();
        },
        methods: {
            initSalaries() {
                this.loading = true;
                this.getRequest("/salary/sob/getListAll").then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.salaries = resp;
                    }
                });
            },
            initSalary() {
                this.salary = {
                    // 顺序需要与 salaryLabel 对应
                    name: '',
                    basicSalary: 0,
                    trafficSalary: 0,
                    lunchSalary: 0,
                    bonus: 0,
                    pensionPer: 0,
                    pensionBase: 0,
                    medicalPer: 0,
                    medicalBase: 0,
                    accumulationFundPer: 0,
                    accumulationFundBase: 0
                };
            },
            initSalaryTest() {
                this.salary = {
                    // 顺序需要与 salaryLabel 对应
                    name: '测试工资账套',
                    basicSalary: 8888,
                    trafficSalary: 500,
                    lunchSalary: 600,
                    bonus: 700,
                    pensionPer: 0.05,
                    pensionBase: 5000,
                    medicalPer: 0.06,
                    medicalBase: 6000,
                    accumulationFundPer: 0.07,
                    accumulationFundBase: 7000
                };
            },
            handleRefresh() {
                this.initSalaries();
            },
            handleAdd() {
                this.initSalary();
                // this.initSalaryTest();
                this.dialogTitle = '新增工资账套';
                this.activeStepIndex = 0;
                this.dialogVisible = true;
            },
            handleEdit(data) {
                this.initSalary();
                // 因为要求按顺序，所以不能用 Object.assign，需要手动设置
                // Object.assign(this.salary, data);// 数据复制一份
                this.salary.name = data.name;
                this.salary.basicSalary = data.basicSalary;
                this.salary.trafficSalary = data.trafficSalary;
                this.salary.lunchSalary = data.lunchSalary;
                this.salary.bonus = data.bonus;
                this.salary.pensionPer = data.pensionPer;
                this.salary.pensionBase = data.pensionBase;
                this.salary.medicalPer = data.medicalPer;
                this.salary.medicalBase = data.medicalBase;
                this.salary.accumulationFundPer = data.accumulationFundPer;
                this.salary.accumulationFundBase = data.accumulationFundBase;
                this.salary.id = data.id;
                this.dialogTitle = '编辑工资账套';
                this.activeStepIndex = 0;
                this.dialogVisible = true;
            },
            handlePreStep() {
                if (this.activeStepIndex != 0) {
                    this.activeStepIndex--;
                }
            },
            handleNextStep() {
                if (this.activeStepIndex != 10) {
                    this.activeStepIndex++;
                }
            },
            handleAddEditConfirm() {
                // TODO 未加表单验证
                if (this.salary.id) {
                    this.putRequest("/salary/sob/edit", this.salary).then(resp => {
                        if (resp) {
                            this.dialogVisible = false;
                            this.initSalaries();
                        }
                    });
                } else {
                    this.postRequest("/salary/sob/add", this.salary).then(resp => {
                        if (resp) {
                            this.dialogVisible = false;
                            this.initSalaries();
                        }
                    });
                }
            },
            handleDelete(data) {
                this.$confirm('此操作将永久删除【' + data.name + '】工资账套, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/salary/sob/deleteById/" + data.id).then(resp => {
                        if (resp) {
                            this.initSalaries();
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
                    this.deleteRequest("/salary/sob/deleteByIds?" + ids).then(resp => {
                        if (resp) {
                            this.initSalaries();
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
            },
        }
    }
</script>

<style scoped>
    .salary-toolbar-container {
        display: flex;
        justify-content: space-between;
    }

    .salary-table {
        width: 100%;
        margin-top: 10px;
    }

    .salary-deletemulti-btn {
        margin-top: 10px;
    }

    .salary-steps-container {
        display: flex;
        justify-content: space-around;
        align-items: center;
    }
</style>