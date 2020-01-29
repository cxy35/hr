package com.zhengjian.hr.controller.chat;

import com.zhengjian.hr.common.pojo.ChatMsg;
import com.zhengjian.hr.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;

import java.util.Date;

@Controller
public class WsController {
    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;

    @MessageMapping("/ws/chat") // 通过 /ws/chat 发消息进来
    public void handleMsg(Authentication authentication, ChatMsg chatMsg) {
        // 将收到的消息发送给指定的人，如果他有订阅就能收到，需要当前连接上，后面连接上的收不到之前的消息
        User user = (User) authentication.getPrincipal();
        chatMsg.setFrom(user.getUsername());
        chatMsg.setFromNickname(user.getName());
        chatMsg.setDate(new Date());
        simpMessagingTemplate.convertAndSendToUser(chatMsg.getTo(), "/queue/chat", chatMsg);
    }
}
