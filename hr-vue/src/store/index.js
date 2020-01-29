import Vue from 'vue'
import Vuex from 'vuex'
import {Notification} from 'element-ui';
import {getRequest} from "../utils/api";
import '../utils/stomp';
// import '../utils/sockjs';
import SockJS from '../utils/sockjs';
// import Stomp from 'stompjs'; // 需要先 npm install
// import SockJS from 'sockjs-client'; // 需要先 npm install

Vue.use(Vuex);

const now = new Date();

const store = new Vuex.Store({
    state: {
        routes: [], // 菜单
        users: [], // 用户列表
        currentUser: JSON.parse(window.sessionStorage.getItem("user")), // 当前登录用户
        chatUser: null, // 聊天对象
        chatMessages: {}, // 聊天消息
        filterKey: '',
        stomp: null,
        isDot: {}
    },
    mutations: {
        // 初始化菜单（initMenu）时会被调用
        initRoutes(state, data) {
            state.routes = data;
        },
        // 初始化当前登录用户，登录成功之后会被调用
        initCurrentUser(state, user) {
            state.currentUser = user;
        },
        // 初始化用户列表数据
        initUsers(state, data) {
            state.users = data;
        },
        // 初始化聊天消息
        initChatMessages(state) {
            // 从浏览器本地取
            let data = localStorage.getItem('vue-chat-session');
            if (data) {
                state.chatMessages = JSON.parse(data);
            }
        },
        handleChatUser(state, chatUser) {
            // 必须要用 Vue.set 设值，否则不会被 Vue 自动检测到
            Vue.set(state.isDot, state.currentUser.username + '#' + chatUser.username, false);
            state.chatUser = chatUser;
        },
        handleChatMessages(state, msg) {
            let key = state.currentUser.username + '#' + msg.to;
            let mss = state.chatMessages[key];
            if (!mss) {
                // 必须要用 Vue.set 设值，否则不会被 Vue 自动检测到
                // state.chatMessages[state.currentUser.username+'#'+msg.to] = [];
                Vue.set(state.chatMessages, key, []);
            }
            state.chatMessages[key].push({
                self: msg.self,
                content: msg.content,
                date: new Date()
            })
        }
    },
    actions: {
        // 初始化在线聊天的 WebSocket 连接，并开始接收消息，初始化菜单（initMenu）时会被调用
        initChatConnect(context) {
            context.state.stomp = Stomp.over(new SockJS('/ws/ep'));
            context.state.stomp.connect({}, success => {
                // 订阅消息，默认加了/user前缀
                context.state.stomp.subscribe('/user/queue/chat', msg => {
                    let receiveMsg = JSON.parse(msg.body);
                    if (!context.state.chatUser || receiveMsg.from != context.state.chatUser.username) {
                        Notification.info({
                            title: '【' + receiveMsg.fromNickname + '】发来一条消息',
                            message: receiveMsg.content.length > 10 ? receiveMsg.content.substr(0, 10) : receiveMsg.content,
                            position: 'bottom-right'
                        });
                        Vue.set(context.state.isDot, context.state.currentUser.username + '#' + receiveMsg.from, true);
                    }
                    receiveMsg.self = false;
                    receiveMsg.to = receiveMsg.from;
                    context.commit('handleChatMessages', receiveMsg);
                })
            }, error => {

            })
        },
        // 初始化在线聊天的相关数据，打开聊天页面时会被调用
        initChatData(context) {
            // 初始化用户列表数据
            getRequest("/chat/getUserList").then(resp => {
                if (resp) {
                    context.commit('initUsers', resp);
                }
            });
            // 初始化聊天消息
            context.commit('initChatMessages');
        }
    }
});

// 监听 state.chatMessages 的变化，统一保存到浏览器本地
store.watch(function (state) {
    return state.chatMessages
}, function (val) {
    localStorage.setItem('vue-chat-session', JSON.stringify(val));
}, {
    deep: true/*这个貌似是开启watch监测的判断,官方说明也比较模糊*/
});

export default store;