<template>
    <div>
        <div>
            <div class="employee-toolbar-container">
                <div>
                    <el-input
                            class="employee-search-name"
                            placeholder="输入姓名搜索"
                            prefix-icon="el-icon-search"
                            clearable
                            @clear="handleSearch"
                            :disabled="searchAdvViewVisible"
                            v-model="searchData.name"
                            @keydown.enter.native="handleSearch">
                    </el-input>
                    <el-button type="primary" icon="el-icon-search" :disabled="searchAdvViewVisible"
                               @click="handleSearch">
                        搜索
                    </el-button>
                    <el-button type="primary" icon="el-icon-search" @click="handleSearchAdv">
                        <i :class="searchAdvViewVisible?'fa fa-angle-double-up':'fa fa-angle-double-down'"
                           aria-hidden="true"></i>
                        高级搜索
                    </el-button>
                </div>
                <div>
                    <el-upload
                            :show-file-list="false"
                            :before-upload="handleBeforeUpload"
                            :on-success="handleSuccess"
                            :on-error="handleError"
                            :disabled="importBtnDisabled"
                            style="display: inline-flex;margin-right: 8px"
                            action="/employee/basic/import">
                        <el-button :disabled="importBtnDisabled" type="success" :icon="importBtnIcon">
                            {{importBtnText}}
                        </el-button>
                    </el-upload>
                    <el-button type="success" icon="el-icon-upload2" @click="handleExport">导出</el-button>
                    <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增员工</el-button>
                </div>
            </div>
            <transition name="slide-fade">
                <div class="employee-searchadv" v-show="searchAdvViewVisible">
                    <el-row>
                        <el-col :span="5">
                            政治面貌:
                            <el-select v-model="searchAdvData.politicsStatusId" placeholder="政治面貌" size="mini"
                                       style="width: 130px;">
                                <el-option
                                        v-for="item in politicsStatuses"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="4">
                            民族:
                            <el-select v-model="searchAdvData.nationId" placeholder="民族" size="mini"
                                       style="width: 130px;">
                                <el-option
                                        v-for="item in nations"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="4">
                            职位:
                            <el-select v-model="searchAdvData.positionId" placeholder="职位" size="mini"
                                       style="width: 130px;">
                                <el-option
                                        v-for="item in positions"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="4">
                            职称:
                            <el-select v-model="searchAdvData.jobTitleId" placeholder="职称" size="mini"
                                       style="width: 130px;">
                                <el-option
                                        v-for="item in jobTitles"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="7">
                            聘用形式:
                            <el-radio-group v-model="searchAdvData.engageForm">
                                <el-radio label="劳动合同">劳动合同</el-radio>
                                <el-radio label="劳务合同">劳务合同</el-radio>
                            </el-radio-group>
                        </el-col>
                    </el-row>
                    <el-row style="margin-top: 10px">
                        <el-col :span="5">
                            所属部门:
                            <el-popover
                                    placement="right"
                                    title="请选择部门"
                                    width="200"
                                    trigger="manual"
                                    v-model="popoverVisibleSearchAdv">
                                <el-tree default-expand-all :data="departments" :props="defaultProps"
                                         @node-click="handleNodeClickSearchAdv"></el-tree>
                                <div slot="reference" class="employee-searchadv-department"
                                     @click="handleSelectDepartmentSearchAdv">{{departmentNameSearchAdv}}
                                </div>
                            </el-popover>
                        </el-col>
                        <el-col :span="10">
                            入职日期:
                            <el-date-picker
                                    v-model="searchAdvData.beginDateScope"
                                    type="daterange"
                                    size="mini"
                                    unlink-panels
                                    value-format="yyyy-MM-dd"
                                    range-separator="至"
                                    start-placeholder="开始日期"
                                    end-placeholder="结束日期">
                            </el-date-picker>
                        </el-col>
                        <el-col :span="5" :offset="4">
                            <el-button size="mini" @click="searchAdvViewVisible = !searchAdvViewVisible">取消</el-button>
                            <el-button size="mini" icon="el-icon-search" type="primary" @click="handleSearchAdvConfirm">
                                搜索
                            </el-button>
                        </el-col>
                    </el-row>
                </div>
            </transition>
        </div>
        <div>
            <el-table
                    class="employee-table"
                    v-loading="loading"
                    element-loading-text="正在加载..."
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    :data="employees"
                    stripe
                    border
                    @selection-change="handleSelectionChange">
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column
                        fixed
                        prop="name"
                        label="姓名"
                        width="90">
                </el-table-column>
                <el-table-column
                        prop="workId"
                        label="工号"
                        width="85">
                </el-table-column>
                <el-table-column
                        prop="gender"
                        label="性别"
                        width="60"
                        align="center">
                </el-table-column>
                <el-table-column
                        prop="birthday"
                        width="95"
                        label="出生日期">
                </el-table-column>
                <el-table-column
                        prop="idCard"
                        width="150"
                        label="身份证号码">
                </el-table-column>
                <el-table-column
                        prop="wedlock"
                        width="70"
                        label="婚姻状况"
                        align="center">
                </el-table-column>
                <el-table-column
                        prop="nation.name"
                        width="60"
                        label="民族"
                        align="center">
                </el-table-column>
                <el-table-column
                        prop="nativePlace"
                        width="80"
                        label="籍贯"
                        align="center">
                </el-table-column>
                <el-table-column
                        prop="politicsStatus.name"
                        label="政治面貌"
                        align="center">
                </el-table-column>
                <el-table-column
                        prop="email"
                        width="180"
                        label="电子邮箱">
                </el-table-column>
                <el-table-column
                        prop="phone"
                        width="100"
                        label="电话号码">
                </el-table-column>
                <el-table-column
                        prop="address"
                        width="220"
                        label="联系地址">
                </el-table-column>
                <el-table-column
                        prop="department.name"
                        width="100"
                        label="所属部门">
                </el-table-column>
                <el-table-column
                        prop="position.name"
                        width="100"
                        label="职位">
                </el-table-column>
                <el-table-column
                        prop="jobTitle.name"
                        width="100"
                        label="职称">
                </el-table-column>
                <el-table-column
                        prop="engageForm"
                        width="100"
                        label="聘用形式">
                </el-table-column>
                <el-table-column
                        prop="tiptopDegree"
                        width="80"
                        label="最高学历">
                </el-table-column>
                <el-table-column
                        prop="specialty"
                        width="150"
                        label="专业">
                </el-table-column>
                <el-table-column
                        prop="school"
                        width="150"
                        label="毕业院校">
                </el-table-column>
                <el-table-column
                        prop="beginDate"
                        width="95"
                        label="入职日期">
                </el-table-column>
                <el-table-column
                        prop="conversionTime"
                        width="95"
                        label="转正日期">
                </el-table-column>
                <el-table-column
                        prop="beginContract"
                        width="95"
                        label="合同起始日期">
                </el-table-column>
                <el-table-column
                        prop="endContract"
                        width="95"
                        label="合同截止日期">
                </el-table-column>
                <el-table-column
                        width="100"
                        label="合同期限">
                    <template slot-scope="scope">
                        <span>{{scope.row.contractTerm}}</span>年
                    </template>
                </el-table-column>
                <el-table-column
                        fixed="right"
                        align="center"
                        width="150"
                        label="操作">
                    <template slot-scope="scope">
                        <el-button class="employee-table-btn" size="mini" @click="handleEdit(scope.row)">编辑</el-button>
                        <el-button class="employee-table-btn" size="mini" type="danger"
                                   @click="handleDelete(scope.row)">删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div class="employee-pagination-container">
                <el-button
                        type="danger"
                        :disabled="this.multipleSelection.length == 0"
                        @click="handleDeleteMulti">批量删除
                </el-button>
                <el-pagination
                        background
                        layout="sizes, prev, pager, next, jumper, ->, total, slot"
                        :total="total"
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange">
                </el-pagination>
            </div>
        </div>
        <el-dialog
                :title="dialogTitle"
                :visible.sync="dialogVisible"
                width="80%">
            <div>
                <el-form :model="employee" :rules="rules" ref="employeeForm">
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="姓名:" prop="name">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-edit"
                                          v-model="employee.name"
                                          placeholder="请输入员工姓名"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="性别:" prop="gender">
                                <el-radio-group v-model="employee.gender">
                                    <el-radio label="男">男</el-radio>
                                    <el-radio label="女">女</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="出生日期:" prop="birthday">
                                <el-date-picker
                                        v-model="employee.birthday"
                                        size="mini"
                                        type="date"
                                        value-format="yyyy-MM-dd"
                                        style="width: 150px;"
                                        placeholder="请输入出生日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="政治面貌:" prop="politicsStatusId">
                                <el-select v-model="employee.politicsStatusId" placeholder="请选择政治面貌" size="mini"
                                           style="width: 200px;">
                                    <el-option
                                            v-for="item in politicsStatuses"
                                            :key="item.id"
                                            :label="item.name"
                                            :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="民族:" prop="nationId">
                                <el-select v-model="employee.nationId" placeholder="民族" size="mini"
                                           style="width: 150px;">
                                    <el-option
                                            v-for="item in nations"
                                            :key="item.id"
                                            :label="item.name"
                                            :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="籍贯:" prop="nativePlace">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-edit"
                                          v-model="employee.nativePlace" placeholder="请输入籍贯"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="电子邮箱:" prop="email">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-message"
                                          v-model="employee.email" placeholder="请输入电子邮箱"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="联系地址:" prop="address">
                                <el-input size="mini" style="width: 200px" prefix-icon="el-icon-edit"
                                          v-model="employee.address" placeholder="请输入联系地址"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="职位:" prop="positionId">
                                <el-select v-model="employee.positionId" placeholder="请选择职位" size="mini"
                                           style="width: 150px;">
                                    <el-option
                                            v-for="item in positions"
                                            :key="item.id"
                                            :label="item.name"
                                            :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="职称:" prop="jobTitleId">
                                <el-select v-model="employee.jobTitleId" placeholder="请选择职称" size="mini"
                                           style="width: 150px;">
                                    <el-option
                                            v-for="item in jobTitles"
                                            :key="item.id"
                                            :label="item.name"
                                            :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="所属部门:" prop="departmentId">
                                <el-popover
                                        placement="right"
                                        title="请选择部门"
                                        width="200"
                                        trigger="manual"
                                        v-model="popoverVisible">
                                    <el-tree default-expand-all :data="departments" :props="defaultProps"
                                             @node-click="handleNodeClick"></el-tree>
                                    <div slot="reference" class="employee-add-edit-department"
                                         @click="handleSelectDepartment">{{departmentName}}
                                    </div>
                                </el-popover>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="电话号码:" prop="phone">
                                <el-input size="mini" style="width: 200px" prefix-icon="el-icon-phone"
                                          v-model="employee.phone" placeholder="电话号码"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="工号:" prop="workId">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-edit"
                                          v-model="employee.workId" placeholder="工号" disabled></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="最高学历:" prop="tiptopDegree">
                                <el-select v-model="employee.tiptopDegree" placeholder="学历" size="mini"
                                           style="width: 120px;">
                                    <el-option
                                            v-for="item in tiptopDegrees"
                                            :key="item"
                                            :label="item"
                                            :value="item">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="毕业院校:" prop="school">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-edit"
                                          v-model="employee.school" placeholder="毕业院校名称"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="专业名称:" prop="specialty">
                                <el-input size="mini" style="width: 200px" prefix-icon="el-icon-edit"
                                          v-model="employee.specialty" placeholder="请输入专业名称"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="入职日期:" prop="beginDate">
                                <el-date-picker
                                        v-model="employee.beginDate"
                                        size="mini"
                                        type="date"
                                        value-format="yyyy-MM-dd"
                                        style="width: 130px;"
                                        placeholder="入职日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="转正日期:" prop="conversionTime">
                                <el-date-picker
                                        v-model="employee.conversionTime"
                                        size="mini"
                                        type="date"
                                        value-format="yyyy-MM-dd"
                                        style="width: 130px;"
                                        placeholder="转正日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="合同起始日期:" prop="beginContract">
                                <el-date-picker
                                        v-model="employee.beginContract"
                                        size="mini"
                                        type="date"
                                        value-format="yyyy-MM-dd"
                                        style="width: 130px;"
                                        placeholder="合同起始日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="合同终止日期:" prop="endContract">
                                <el-date-picker
                                        v-model="employee.endContract"
                                        size="mini"
                                        type="date"
                                        value-format="yyyy-MM-dd"
                                        style="width: 130px;"
                                        placeholder="合同终止日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="8">
                            <el-form-item label="身份证号码:" prop="idCard">
                                <el-input size="mini" style="width: 180px" prefix-icon="el-icon-edit"
                                          v-model="employee.idCard" placeholder="请输入身份证号码"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="聘用形式:" prop="engageForm">
                                <el-radio-group v-model="employee.engageForm">
                                    <el-radio label="劳动合同">劳动合同</el-radio>
                                    <el-radio label="劳务合同">劳务合同</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="婚姻状况:" prop="wedlock">
                                <el-radio-group v-model="employee.wedlock">
                                    <el-radio label="已婚">已婚</el-radio>
                                    <el-radio label="未婚">未婚</el-radio>
                                    <el-radio label="离异">离异</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleAddEditConfirm">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "EmpBasic",
        data() {
            return {
                searchData: {
                    name: ''
                },
                searchAdvData: {
                    politicsStatusId: null,
                    nationId: null,
                    jobTitleId: null,
                    positionId: null,
                    engageForm: null,
                    departmentId: null,
                    beginDateScope: null
                },
                departmentNameSearchAdv: '所属部门',
                searchAdvViewVisible: false,
                importBtnText: '导入数据',
                importBtnIcon: 'el-icon-download',
                importBtnDisabled: false,
                employees: [],
                page: 1,
                size: 10,
                total: 0,
                multipleSelection: [],
                dialogTitle: '',
                dialogVisible: false,
                employee: {
                    name: "",
                    gender: "",
                    birthday: "",
                    idCard: "",
                    wedlock: "",
                    nationId: 1,
                    nativePlace: "",
                    politicsStatusId: "",
                    email: "",
                    phone: "",
                    address: "",
                    departmentId: null,
                    jobTitleId: null,
                    positionId: null,
                    engageForm: "",
                    tiptopDegree: "",
                    specialty: "",
                    school: "",
                    beginDate: "",
                    workId: "",
                    contractTerm: "",
                    conversionTime: "",
                    notworkDate: null,
                    beginContract: "",
                    endContract: "",
                    workAge: null
                },
                departmentName: '所属部门',
                nations: [],
                politicsStatuses: [],
                departments: [],
                jobTitles: [],
                positions: [],
                tiptopDegrees: ['本科', '大专', '硕士', '博士', '高中', '初中', '小学', '其他'],
                rules: {
                    name: [{required: true, message: '请输入姓名', trigger: 'blur'}],
                    gender: [{required: true, message: '请输入性别', trigger: 'blur'}],
                    birthday: [{required: true, message: '请输入出生日期', trigger: 'blur'}],
                    idCard: [{required: true, message: '请输入身份证号码', trigger: 'blur'}, {
                        pattern: /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/,
                        message: '身份证号码格式不正确',
                        trigger: 'blur'
                    }],
                    wedlock: [{required: true, message: '请输入婚姻状况', trigger: 'blur'}],
                    nationId: [{required: true, message: '请输入民族', trigger: 'blur'}],
                    nativePlace: [{required: true, message: '请输入籍贯', trigger: 'blur'}],
                    politicsStatusId: [{required: true, message: '请输入政治面貌', trigger: 'blur'}],
                    email: [{required: true, message: '请输入电子邮箱', trigger: 'blur'}, {
                        type: 'email',
                        message: '电子邮箱格式不正确',
                        trigger: 'blur'
                    }],
                    phone: [{required: true, message: '请输入电话号码', trigger: 'blur'}],
                    address: [{required: true, message: '请输入联系地址', trigger: 'blur'}],
                    departmentId: [{required: true, message: '请选择部门', trigger: 'blur'}],
                    jobTitleId: [{required: true, message: '请输入职称', trigger: 'blur'}],
                    positionId: [{required: true, message: '请输入职位', trigger: 'blur'}],
                    engageForm: [{required: true, message: '请输入聘用形式', trigger: 'blur'}],
                    tiptopDegree: [{required: true, message: '请输入最高学历', trigger: 'blur'}],
                    specialty: [{required: true, message: '请输入专业', trigger: 'blur'}],
                    school: [{required: true, message: '请输入毕业院校', trigger: 'blur'}],
                    beginDate: [{required: true, message: '请输入入职日期', trigger: 'blur'}],
                    workId: [{required: true, message: '请输入工号', trigger: 'blur'}],
                    contractTerm: [{required: true, message: '请输入合同期限', trigger: 'blur'}],
                    conversionTime: [{required: true, message: '请输入转正日期', trigger: 'blur'}],
                    notworkDate: [{required: true, message: '请输入离职日期', trigger: 'blur'}],
                    beginContract: [{required: true, message: '请输入合同起始日期', trigger: 'blur'}],
                    endContract: [{required: true, message: '请输入合同结束日期', trigger: 'blur'}],
                    workAge: [{required: true, message: '请输入工龄', trigger: 'blur'}],
                },
                popoverVisible: false,
                popoverVisibleSearchAdv: false,
                defaultProps: {
                    children: 'children',
                    label: 'name'
                },
                loading: false
            }
        },
        mounted() {
            this.initEmployees();
        },
        methods: {
            initEmployees() {
                this.loading = true;
                let url = "/employee/basic/getPage?page=" + this.page + "&size=" + this.size;
                if (this.searchAdvViewVisible) {
                    if (this.searchAdvData.politicsStatusId) {
                        url += '&politicsStatusId=' + this.searchAdvData.politicsStatusId;
                    }
                    if (this.searchAdvData.nationId) {
                        url += '&nationId=' + this.searchAdvData.nationId;
                    }
                    if (this.searchAdvData.jobTitleId) {
                        url += '&jobTitleId=' + this.searchAdvData.jobTitleId;
                    }
                    if (this.searchAdvData.positionId) {
                        url += '&positionId=' + this.searchAdvData.positionId;
                    }
                    if (this.searchAdvData.engageForm) {
                        url += '&engageForm=' + this.searchAdvData.engageForm;
                    }
                    if (this.searchAdvData.departmentId) {
                        url += '&departmentId=' + this.searchAdvData.departmentId;
                    }
                    if (this.searchAdvData.beginDateScope) {
                        url += '&beginDateScope=' + this.searchAdvData.beginDateScope[0];
                        url += '&beginDateScope=' + this.searchAdvData.beginDateScope[1];
                    }
                } else {
                    url += "&name=" + this.searchData.name;
                }

                this.getRequest(url).then(resp => {
                    this.loading = false;
                    if (resp) {
                        this.employees = resp.data;
                        this.total = resp.total;
                    }
                });
            },
            initEmployee() {
                this.employee = {
                    name: "",
                    gender: "",
                    birthday: "",
                    idCard: "",
                    wedlock: "",
                    nationId: 1,
                    nativePlace: "",
                    politicsStatusId: "",
                    email: "",
                    phone: "",
                    address: "",
                    departmentId: null,
                    jobTitleId: null,
                    positionId: null,
                    engageForm: "",
                    tiptopDegree: "",
                    specialty: "",
                    school: "",
                    beginDate: "",
                    workId: "",
                    contractTerm: "",
                    conversionTime: "",
                    notworkDate: null,
                    beginContract: "",
                    endContract: "",
                    workAge: null
                };
                this.departmentName = '所属部门';
            },
            initEmployeeTest() {
                this.employee = {
                    name: "测试员工",
                    gender: "男",
                    birthday: "1989-12-31",
                    idCard: "610122199001011256",
                    wedlock: "已婚",
                    nationId: 1,
                    nativePlace: "陕西",
                    politicsStatusId: 13,
                    email: "laowang@qq.com",
                    phone: "18565558897",
                    address: "深圳市南山区",
                    departmentId: null,
                    jobTitleId: 9,
                    positionId: 29,
                    engageForm: "劳务合同",
                    tiptopDegree: "本科",
                    specialty: "信息管理与信息系统",
                    school: "深圳大学",
                    beginDate: "2017-12-31",
                    workId: "00000057",
                    contractTerm: 2,
                    conversionTime: "2018-03-31",
                    notworkDate: null,
                    beginContract: "2017-12-31",
                    endContract: "2019-12-31",
                    workAge: null
                };
                this.departmentName = '';
            },
            initSearchAdvData() {
                this.searchAdvData = {
                    politicsStatusId: null,
                    nationId: null,
                    jobTitleId: null,
                    positionId: null,
                    engageForm: null,
                    departmentId: null,
                    beginDateScope: null
                };
                this.departmentNameSearchAdv = '所属部门';
            },
            initNations() {
                if (!window.sessionStorage.getItem("nations")) {
                    this.getRequest('/employee/basic/getNationListAll').then(resp => {
                            if (resp) {
                            this.nations = resp;
                            window.sessionStorage.setItem("nations", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.nations = JSON.parse(window.sessionStorage.getItem("nations"));
                }
            },
            initPoliticsStatuses() {
                if (!window.sessionStorage.getItem("politicsStatuses")) {
                    this.getRequest('/employee/basic/getPoliticsStatusListAll').then(resp => {
                        if (resp) {
                            this.politicsStatuses = resp;
                            window.sessionStorage.setItem("politicsStatuses", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.politicsStatuses = JSON.parse(window.sessionStorage.getItem("politicsStatuses"));
                }
            },
            initDepartments() {
                if (!window.sessionStorage.getItem("departments")) {
                    this.getRequest('/employee/basic/getDepartmentListAll').then(resp => {
                        if (resp) {
                            this.departments = resp;
                            window.sessionStorage.setItem("departments", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.departments = JSON.parse(window.sessionStorage.getItem("departments"));
                }
            },
            initJobTitles() {
                if (!window.sessionStorage.getItem("jobTitles")) {
                    this.getRequest('/employee/basic/getJobTitleListAll').then(resp => {
                        if (resp) {
                            this.jobTitles = resp;
                            window.sessionStorage.setItem("jobTitles", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.jobTitles = JSON.parse(window.sessionStorage.getItem("jobTitles"));
                }
            },
            initPositions() {
                this.getRequest('/employee/basic/getPositionListAll').then(resp => {
                    if (resp) {
                        this.positions = resp;
                    }
                })
            },
            initWorkId() {
                this.getRequest('/employee/basic/getNextWorkId').then(resp => {
                    if (resp) {
                        this.employee.workId = resp.obj;
                    }
                })
            },
            handleSizeChange(pageSize) {
                this.size = pageSize;
                this.initEmployees();
            },
            handleCurrentChange(currentPage) {
                this.page = currentPage;
                this.initEmployees();
            },
            handleSearch() {
                this.initEmployees();
            },
            handleSearchAdv() {
                this.searchAdvViewVisible = !this.searchAdvViewVisible;
                if (this.searchAdvViewVisible) {
                    this.initSearchAdvData();
                    this.initNations();
                    this.initPoliticsStatuses();
                    this.initDepartments();
                    this.initJobTitles();
                    this.initPositions();
                }
            },
            handleSearchAdvConfirm() {
                this.initEmployees();
            },
            handleBeforeUpload() {
                this.importBtnText = '正在导入';
                this.importBtnIcon = 'el-icon-loading';
                this.importBtnDisabled = true;
            },
            handleSuccess(response, file, fileList) {
                this.importBtnText = '导入数据';
                this.importBtnIcon = 'el-icon-download';
                this.importBtnDisabled = false;
                this.initEmployees();
            },
            handleError(err, file, fileList) {
                this.importBtnText = '导入数据';
                this.importBtnIcon = 'el-icon-download';
                this.importBtnDisabled = false;
            },
            handleExport() {
                window.open('/employee/basic/export', '_parent');
            },
            handleAdd() {
                this.initEmployee();
                // this.initEmployeeTest();
                this.initNations();
                this.initPoliticsStatuses();
                this.initDepartments();
                this.initJobTitles();
                this.initPositions();
                this.initWorkId();
                this.dialogTitle = '新增员工';
                this.dialogVisible = true;
            },
            handleEdit(data) {
                this.initEmployee();
                this.initNations();
                this.initPoliticsStatuses();
                this.initDepartments();
                this.initJobTitles();
                this.initPositions();
                Object.assign(this.employee, data);// 数据复制一份
                this.departmentName = data.department.name;
                this.dialogTitle = '编辑员工';
                this.dialogVisible = true;
            },
            handleAddEditConfirm() {
                if (this.employee.id) {
                    this.$refs['employeeForm'].validate((valid) => {
                        if (valid) {
                            this.putRequest('/employee/basic/edit', this.employee).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initEmployees();
                                }
                            });
                        } else {
                            this.$message.error('表单验证错误');
                            return false;
                        }
                    });
                } else {
                    this.$refs['employeeForm'].validate((valid) => {
                        if (valid) {
                            this.postRequest('/employee/basic/add', this.employee).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initEmployees();
                                }
                            });
                        } else {
                            this.$message.error('表单验证错误');
                            return false;
                        }
                    });
                }
            },
            handleDelete(data) {
                this.$confirm('此操作将永久删除【' + data.name + '】员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/employee/basic/deleteById/" + data.id).then(resp => {
                        if (resp) {
                            this.initEmployees();
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
                    this.deleteRequest("/employee/basic/deleteByIds?" + ids).then(resp => {
                        if (resp) {
                            this.initEmployees();
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
            handleNodeClick(data) {
                this.employee.departmentId = data.id;
                this.departmentName = data.name;
                this.popoverVisible = !this.popoverVisible;
            },
            handleNodeClickSearchAdv(data) {
                this.searchAdvData.departmentId = data.id;
                this.departmentNameSearchAdv = data.name;
                this.popoverVisibleSearchAdv = !this.popoverVisibleSearchAdv;
            },
            handleSelectDepartment() {
                this.popoverVisible = !this.popoverVisible;
            },
            handleSelectDepartmentSearchAdv() {
                this.popoverVisibleSearchAdv = !this.popoverVisibleSearchAdv;
            }
        }
    }
</script>

<style scoped>
    .employee-toolbar-container {
        display: flex;
        justify-content: space-between;
    }

    .employee-search-name {
        width: 50%;
        margin-right: 10px;
    }

    .employee-searchadv {
        border: 1px solid #409eff;
        border-radius: 5px;
        box-sizing: border-box;
        padding: 5px 10px;
        margin: 10px 0px;
        font-size: 13px;
    }

    .employee-searchadv-department {
        width: 130px;
        display: inline-flex;
        font-size: 13px;
        border: 1px solid #dedede;
        height: 26px;
        border-radius: 5px;
        cursor: pointer;
        align-items: center;
        padding-left: 12px;
        box-sizing: border-box;
        color: #999;
    }

    .employee-table {
        width: 100%;
        margin-top: 10px;
    }

    .employee-table-btn {
        padding: 2px 10px;
    }

    .employee-pagination-container {
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
    }

    .employee-add-edit-department {
        width: 150px;
        display: inline-flex;
        font-size: 13px;
        border: 1px solid #dedede;
        height: 26px;
        border-radius: 5px;
        cursor: pointer;
        align-items: center;
        padding-left: 12px;
        box-sizing: border-box;
        color: #999;
    }

    /* 可以设置不同的进入和离开动画 */
    /* 设置持续时间和动画函数 */
    .slide-fade-enter-active {
        transition: all .5s ease;
    }

    .slide-fade-leave-active {
        transition: all .5s cubic-bezier(1.0, 0.5, 0.8, 1.0);
    }

    .slide-fade-enter, .slide-fade-leave-to
        /* .slide-fade-leave-active for below version 2.1.8 */
    {
        transform: translateX(10px);
        opacity: 0;
    }

</style>