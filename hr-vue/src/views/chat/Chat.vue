<template>
    <!-- 基于 https://github.com/is-liyiwei/vue-Chat-demo 改造 -->
    <div id="app">
        <div class="sidebar">
            <card></card>
            <list></list>
        </div>
        <div class="main">
            <message></message>
            <usertext></usertext>
        </div>
    </div>
</template>

<script>
    import card from "../../components/chat/card";
    import list from "../../components/chat/list";
    import message from "../../components/chat/message";
    import usertext from "../../components/chat/usertext";

    export default {
        name: "Chat",
        data() {
            return {}
        },
        mounted() {
            this.$store.dispatch('initChatData'); // 初始化在线聊天的相关数据
        },
        components: {
            card,
            list,
            message,
            usertext
        }
    }
</script>

<style lang="scss" scoped>
    #app {
        margin: 20px auto;
        width: 800px;
        height: 600px;
        overflow: hidden;
        border-radius: 5px;

        .sidebar, .main {
            height: 100%;
        }

        .sidebar {
            float: left;
            color: #f4f4f4;
            background-color: #2e3238;
            width: 200px;
        }

        .main {
            position: relative;
            overflow: hidden;
            background-color: #eee;
            border: solid 1px #DDD;
            box-sizing: border-box;
        }
    }
</style>