<template>
    <div>
        <el-form
                class="login-form"
                v-loading="loading"
                element-loading-text="正在登录..."
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(0, 0, 0, 0.8)"
                :model="loginForm"
                :rules="loginRules"
                ref="loginForm">
            <h3 class="login-title">HR 管理系统 - 登录</h3>
            <el-form-item prop="username">
                <el-input size="normal" type="text" v-model="loginForm.username" auto-complete="off"
                          placeholder="请输入用户名"></el-input>
            </el-form-item>
            <el-form-item prop="password">
                <el-input size="normal" type="password" v-model="loginForm.password" auto-complete="off"
                          placeholder="请输入密码" @keydown.enter.native="submitForm('loginForm')"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button size="normal" class="login-btn" type="primary" @click="submitForm('loginForm')">登录
                </el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
    export default {
        name: "Login",
        data() {
            return {
                loginForm: {
                    username: 'admin',
                    password: '123'
                },
                loginRules: {
                    username: [{required: true, message: '请输入用户名', trigger: 'blur'}],
                    password: [{required: true, message: '请输入密码', trigger: 'blur'}]
                },
                loading: false
            }
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.loading = true;
                        this.postKeyValueRequest('/doLogin', this.loginForm).then(resp => {
                            this.loading = false;
                            if (resp) {
                                this.$store.commit('INIT_CURRENTHR', resp.obj);
                                window.sessionStorage.setItem("user", JSON.stringify(resp.obj));
                                // 登录时如果有需要跳转的目标地址，则登录成功后直接到该地址，否则到 home 页
                                let redirect = this.$route.query.redirect;
                                this.$router.replace((redirect == '/' || redirect == undefined) ? '/home' : redirect);
                            }
                        });
                    } else {
                        this.$message.error('表单验证错误！');
                        return false;
                    }
                });
            }
        }
    }
</script>

<style scoped>
    .login-form {
        border-radius: 15px;
        background-clip: padding-box;
        margin: 160px auto;
        width: 350px;
        padding: 10px 35px;
        background: #fff;
        border: 1px solid #eaeaea;
        box-shadow: 0 0 25px #cac6c6;
    }

    .login-title {
        margin: 20px auto 30px auto;
        text-align: center;
        color: #505458;
    }

    .login-btn {
        width: 100%;
        margin-top: 10px;
    }
</style>
