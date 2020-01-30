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
        // 下面这些属性在线聊天模块用到
        stomp: null,
        searchData: {
            name: ''
        }, // 搜索用户姓名
        users: [], // 用户列表
        isDot: {}, // 用户列表中显示小红点
        currentUser: JSON.parse(window.sessionStorage.getItem("user")), // 当前登录用户
        chatUser: null, // 聊天对象
        chatMessages: {} // 聊天消息
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
        initUsers(state) {
            getRequest("/chat/getUserList?name=" + state.searchData.name).then(resp => {
                if (resp) {
                    state.users = resp;
                }
            });
        },
        // 初始化聊天消息
        initChatMessages(state) {
            // 从浏览器本地取
            let data = localStorage.getItem('hr-chat-messages');
            if (data) {
                state.chatMessages = JSON.parse(data);
            }
        },
        // 处理聊天对象，用户列表选择用户时会被调用
        handleChatUser(state, chatUser) {
            // 必须要用 Vue.set 设值，否则不会被 Vue 自动检测到
            Vue.set(state.isDot, state.currentUser.username + '#' + chatUser.username, false);
            state.chatUser = chatUser;
        },
        // 处理聊天框中的消息（当前登录用户 currentUser.username 与聊天消息对象 message.to），发送和接收消息时会被调用
        handleChatMessages(state, message) {
            // console.log("111---" + JSON.stringify(message));
            let key = state.currentUser.username + '#' + message.to;
            let mss = state.chatMessages[key];
            if (!mss) {
                // 必须要用 Vue.set 设值，否则不会被 Vue 自动检测到
                // state.chatMessages[state.currentUser.username+'#'+message.to] = [];
                Vue.set(state.chatMessages, key, []);
            }
            state.chatMessages[key].push({
                self: message.self,
                content: message.content,
                date: message.date
            })
        }
    },
    actions: {
        // 初始化在线聊天的 WebSocket 连接，并开始订阅并接收聊天消息，初始化菜单（initMenu）时会被调用
        initChatConnect(context) {
            context.state.stomp = Stomp.over(new SockJS('/ws/ep'));
            context.state.stomp.connect({}, success => {
                // 通过 /user/queue/chat 订阅消息，默认加了 /user 前缀
                context.state.stomp.subscribe('/user/queue/chat', msg => {
                    let chatMsg = JSON.parse(msg.body);
                    if (!context.state.chatUser || chatMsg.from != context.state.chatUser.username) {
                        Notification.info({
                            title: '【' + chatMsg.fromName + '】发来一条消息',
                            message: chatMsg.content.length > 10 ? chatMsg.content.substr(0, 10) : chatMsg.content,
                            position: 'bottom-right'
                        });
                        // 必须要用 Vue.set 设值，否则不会被 Vue 自动检测到
                        Vue.set(context.state.isDot, context.state.currentUser.username + '#' + chatMsg.from, true);
                    }

                    let message = new Object();
                    message.self = false;
                    message.to = chatMsg.from; // 注意：message.to 是指聊天框中与当前登录用户的聊天消息对象
                    message.content = chatMsg.content;
                    message.date = chatMsg.date;
                    context.commit('handleChatMessages', message);
                })
            }, error => {

            })
        },
        // 初始化在线聊天的相关数据，打开聊天页面时会被调用
        initChatData(context) {
            // 初始化用户列表数据
            context.commit('initUsers');
            // 初始化聊天消息
            context.commit('initChatMessages');
        }
    }
});

// 监听 state.chatMessages 的变化，统一保存到浏览器本地
store.watch(function (state) {
    return state.chatMessages
}, function (val) {
    localStorage.setItem('hr-chat-messages', JSON.stringify(val));
}, {
    deep: true/*这个貌似是开启watch监测的判断,官方说明也比较模糊*/
});

export default store;