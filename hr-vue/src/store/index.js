import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
    state: {
        // 菜单
        routes: []/*,
        // 当前用户
        currentUser: JSON.parse(window.sessionStorage.getItem("user")),
        sessions: {},
        hrs: [],
        currentSession: null,
        filterKey: '',
        stomp: null,
        isDot: {}*/
    },
    mutations: {
        // 初始化菜单（initMenu）时会被调用
        initRoutes(state, data) {
            state.routes = data;
        }/*,
        // 登录成功之后会被调用
        initCurrentUser(state, user) {
            state.currentUser = user;
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
            //浏览器本地的历史聊天记录可以在这里完成
            let data = localStorage.getItem('vue-chat-session');
            if (data) {
                state.sessions = JSON.parse(data);
            }
        },
        INIT_HR(state, data) {
            state.hrs = data;
        }*/
    },
    actions: {
        /*connect(context) {
            context.state.stomp = Stomp.over(new SockJS('/ws/ep'));
            context.state.stomp.connect({}, success => {
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
        initData(context) {
            context.commit('INIT_DATA')
            getRequest("/chat/hrs").then(resp => {
                if (resp) {
                    context.commit('INIT_HR', resp);
                }
            })
        }*/
    }
})

export default store;