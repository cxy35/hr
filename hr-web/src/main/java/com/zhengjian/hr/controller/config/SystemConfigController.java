package com.zhengjian.hr.controller.config;

import com.zhengjian.hr.model.Menu;
import com.zhengjian.hr.service.system.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @Author cxy35
 * @Date 2019/12/26 12:06
 */
@RestController
@RequestMapping("/system/config")
public class SystemConfigController {
    @Autowired
    private MenuService menuService;

    @GetMapping("/menu")
    public List<Menu> getListForCurUser() {
        return menuService.getListForCurUser();
    }
}
