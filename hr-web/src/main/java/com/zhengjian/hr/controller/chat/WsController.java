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

    @MessageMapping("/ws/chat")
    public void handleMsg(Authentication authentication, ChatMsg chatMsg) {
        User user = (User) authentication.getPrincipal();
        chatMsg.setFrom(user.getUsername());
        chatMsg.setFromNickname(user.getName());
        chatMsg.setDate(new Date());
        simpMessagingTemplate.convertAndSendToUser(chatMsg.getTo(), "/queue/chat", chatMsg);
    }
}
