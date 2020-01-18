<template>
    <div>
        <el-tabs v-model="activeName" type="card">
            <el-tab-pane label="部门管理" name="department"><Department></Department></el-tab-pane>
            <el-tab-pane label="角色管理" name="role"><Role></Role></el-tab-pane>
            <el-tab-pane label="职位管理" name="position"><Position></Position></el-tab-pane>
            <el-tab-pane label="职称管理" name="jobTitle"><JobTitle></JobTitle></el-tab-pane>
            <el-tab-pane label="奖惩规则" name="4"><EcMana></EcMana></el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
    import Department from "../../components/sys/Department";
    import Role from "../../components/sys/Role";
    import Position from "../../components/sys/Position";
    import JobTitle from "../../components/sys/JobTitle";
    import EcMana from "../../components/sys/EcMana";

    export default {
        name: "SysBasic",
        data() {
            return {
                activeName: 'department'
            }
        },
        components: {
            Department,
            Role,
            Position,
            JobTitle,
            EcMana
        }
    }
</script>

<style scoped>

</style>