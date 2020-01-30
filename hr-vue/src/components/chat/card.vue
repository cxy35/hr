<template>
    <div id="card">
        <header>
            <img class="avatar" v-bind:src="user.userface" v-bind:alt="user.name">
            <p class="name">{{user.name}}</p>
        </header>
        <footer>
            <input class="search" type="text" placeholder="输入姓名搜索" v-model="$store.state.searchData.name"
                   v-on:keydown.enter="handleSearch">
        </footer>
    </div>
</template>

<script>
    export default {
        name: 'card',
        data() {
            return {
                user: JSON.parse(window.sessionStorage.getItem("user"))
            }
        },
        methods: {
            handleSearch() {
                this.$store.commit('initUsers');
            }
        }
    }
</script>

<style lang="scss" scoped>
    #card {
        padding: 0px 10px;

        .avatar {
            width: 40px;
            height: 40px;
            vertical-align: middle; /*这个是图片和文字居中对齐*/
        }

        .name {
            display: inline-block;
            padding: 10px;
            font-size: 16px;
        }

        .search {
            background: #26292E;
            height: 30px;
            line-height: 30px;
            padding: 0 10px;
            border: 1px solid #3a3a3a;
            border-radius: 4px;
            outline: none; /*鼠标点击后不会出现蓝色边框*/
            color: #FFF;
            width: 100%;
            box-sizing: border-box;
        }
    }
</style>
