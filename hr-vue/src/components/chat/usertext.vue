<template>
    <div id="uesrtext">
        <textarea placeholder="按 Ctrl + Enter 发送" v-model="content" v-on:keyup.ctrl.enter="handleChatMessages"></textarea>
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
                if (this.chatUser && this.content.length) {
                    let msg = new Object();
                    msg.self = true;
                    msg.to = this.chatUser.username;
                    msg.content = this.content;
                    // console.log("send >>>>>> "+JSON.stringify(msg));
                    this.$store.state.stomp.send('/ws/chat', {}, JSON.stringify(msg)); // 通过 WebSocket 发送消息
                    this.$store.commit('handleChatMessages', msg); // 处理聊天消息
                    this.content = '';
                }
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
        box-sizing: border-box;

        > textarea {
            padding: 10px;
            width: 100%;
            height: 100%;
            border: none;
            outline: none;
            resize: none;
            box-sizing: border-box;
        }
    }
</style>
