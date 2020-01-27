import Vue from 'vue'
import Vuex from 'vuex'
import {Notification} from 'element-ui';
import {getRequest} from "../utils/api";
import '../utils/stomp';
import '../utils/sockjs';

Vue.use(Vuex)

const now = new Date();

const store = new Vuex.Store({
    state: {
        routes: [], // 菜单
        sessions: {},
        hrs: [],
        currentSession: null,
        currentHr: JSON.parse(window.sessionStorage.getItem("user")), // 当前登录用户
        filterKey: '',
        stomp: null,
        isDot: {}
    },
    mutations: {
        // 初始化菜单（initMenu）时会被调用
        initRoutes(state, data) {
            state.routes = data;
        },
        // 登录成功之后会被调用
        /*initCurrentUser(state, user) {
            state.currentUser = user;
        },*/
        INIT_CURRENTHR(state, hr) {
            state.currentHr = hr;
        },
        changeCurrentSession(state, currentSession) {
            Vue.set(state.isDot, state.currentHr.username + '#' + currentSession.username, false);
            state.currentSession = currentSession;
        },
        addMessage(state, msg) {
            let mss = state.sessions[state.currentHr.username + '#' + msg.to];
            if (!mss) {
                // state.sessions[state.currentHr.username+'#'+msg.to] = [];
                Vue.set(state.sessions, state.currentHr.username + '#' + msg.to, []);
            }
            state.sessions[state.currentHr.username + '#' + msg.to].push({
                content: msg.content,
                date: new Date(),
                self: !msg.notSelf
            })
        },
        INIT_DATA(state) {
            // 浏览器本地的历史聊天记录可以在这里完成
            let data = localStorage.getItem('vue-chat-session');
            if (data) {
                state.sessions = JSON.parse(data);
            }
        },
        INIT_HR(state, data) {
            state.hrs = data;
        }
    },
    actions: {
        // 初始化在线聊天的 WebSocket 连接，并开始接收消息
        initChatConnect(context) {
            context.state.stomp = Stomp.over(new SockJS('/ws/ep'));
            context.state.stomp.connect({}, success => {
                // 订阅消息，默认加了/user前缀
                context.state.stomp.subscribe('/user/queue/chat', msg => {
                    let receiveMsg = JSON.parse(msg.body);
                    if (!context.state.currentSession || receiveMsg.from != context.state.currentSession.username) {
                        Notification.info({
                            title: '【' + receiveMsg.fromNickname + '】发来一条消息',
                            message: receiveMsg.content.length > 10 ? receiveMsg.content.substr(0, 10) : receiveMsg.content,
                            position: 'bottom-right'
                        })
                        Vue.set(context.state.isDot, context.state.currentHr.username + '#' + receiveMsg.from, true);
                    }
                    receiveMsg.notSelf = true;
                    receiveMsg.to = receiveMsg.from;
                    context.commit('addMessage', receiveMsg);
                })
            }, error => {

            })
        },
        // 初始化在线聊天的相关数据
        initChatData(context) {
            // 初始化聊天记录数据
            context.commit('INIT_DATA');
            // 初始化用户列表数据
            getRequest("/chat/getUserList").then(resp => {
                if (resp) {
                    context.commit('INIT_HR', resp);
                }
            });
        }
    }
})

store.watch(function (state) {
    return state.sessions
}, function (val) {
    localStorage.setItem('vue-chat-session', JSON.stringify(val));
}, {
    deep: true/*这个貌似是开启watch监测的判断,官方说明也比较模糊*/
})

export default store;