package com.zhengjian.hr.controller.chat;

import com.zhengjian.hr.model.User;
import com.zhengjian.hr.service.system.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/chat")
public class ChatController {
    @Autowired
    UserService userService;

    @GetMapping("/getUserList")
    public List<User> getUserList(User user) {
        return userService.getList(user);
    }
}
