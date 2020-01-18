package com.zhengjian.hr.controller.system;

import com.zhengjian.hr.common.pojo.RespBean;
import com.zhengjian.hr.model.User;
import com.zhengjian.hr.service.system.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/8 15:05
 */
@RestController
@RequestMapping("/system/user")
public class UserController {
    @Autowired
    UserService userService;

    @DeleteMapping("/deleteById/{id}")
    public RespBean deleteById(@PathVariable Integer id) {
        int r = userService.deleteById(id);
        if (r == 1) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @PutMapping("/edit")
    public RespBean edit(@RequestBody User user) {
        int r = userService.edit(user);
        if (r == 1) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @PutMapping("/editUserRole")
    public RespBean editUserRole(Integer uid, Integer[] rids) {
        boolean r = userService.editUserRole(uid, rids);
        if (r) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @GetMapping("/getListWithRoles")
    public List<User> getListWithRoles(User user) {
        return userService.getListWithRoles(user);
    }

}
