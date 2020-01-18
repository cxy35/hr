package com.zhengjian.hr.controller.system;

import com.zhengjian.hr.common.pojo.RespBean;
import com.zhengjian.hr.model.Menu;
import com.zhengjian.hr.model.Role;
import com.zhengjian.hr.service.system.MenuService;
import com.zhengjian.hr.service.system.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/2 14:10
 */
@RequestMapping("/system/basic/role")
@RestController
public class RoleController {
    @Autowired
    RoleService roleService;
    @Autowired
    MenuService menuService;

    @PostMapping("/add")
    public RespBean add(@RequestBody Role role) {
        int r = roleService.add(role);
        if (r == 1) {
            return RespBean.ok("新增成功");
        } else {
            return RespBean.error("新增失败");
        }
    }

    @DeleteMapping("/deleteById/{id}")
    public RespBean deleteById(@PathVariable Integer id) {
        int r = roleService.deleteById(id);
        if (r == 1) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @PutMapping("/editRoleMenu")
    public RespBean editRoleMenu(Integer rid, Integer[] mids) {
        boolean r = roleService.editRoleMenu(rid, mids);
        if (r) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @GetMapping("/getListAll")
    public List<Role> getListAll() {
        return roleService.getListAll();
    }

    @GetMapping("/getMenuListAllWithChildren")
    public List<Menu> getMenuListAllWithChildren() {
        return menuService.getListAllWithChildren();
    }

    @GetMapping("/getMidsByRid/{rid}")
    public List<Integer> getMidsByRid(@PathVariable Integer rid) {
        return roleService.getMidsByRid(rid);
    }
}
