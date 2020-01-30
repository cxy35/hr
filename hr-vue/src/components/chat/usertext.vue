<template>
    <div id="uesrtext">
        <textarea placeholder="按 Ctrl + Enter 发送" v-model="content"
                  v-on:keyup.ctrl.enter="handleChatMessages"></textarea>
    </div>
</template>

<script>
    import {mapState} from 'vuex'

    export default {
        name: 'uesrtext',
        data() {
            return {
                content: ''
            }
        },
        computed: mapState([
            'chatUser',
            'chatMessages'
        ]),
        methods: {
            handleChatMessages() {
                if (!this.chatUser) {
                    this.$message.error('请先选择聊天对象');
                    return;
                }
                if (!this.content || this.content.trim().length == 0) {
                    this.$message.error('不能发送空白信息');
                    return;
                }

                let message = new Object();
                message.self = true;
                message.to = this.chatUser.username;
                message.content = this.content;
                message.date = new Date();
                // 通过 /ws/chat 向后台发送聊天消息
                this.$store.state.stomp.send('/ws/chat', {}, JSON.stringify(message));
                // 前台处理聊天框中的消息
                this.$store.commit('handleChatMessages', message);
                this.content = '';
            }
        }
    }
</script>

<style lang="scss" scoped>
    #uesrtext {
        position: absolute;
        bottom: 0;
        right: 0;
        width: 100%;
        height: 30%;
        border-top: solid 1px #DDD;

        > textarea {
            padding: 10px;
            width: 100%;
            height: 100%;
            border: none;
            outline: none;
            resize: none;
        }
    }
</style>
