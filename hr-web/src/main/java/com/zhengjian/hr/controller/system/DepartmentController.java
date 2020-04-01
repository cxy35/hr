package com.zhengjian.hr.controller.system;

import com.zhengjian.hr.common.pojo.RespBean;
import com.zhengjian.hr.model.Department;
import com.zhengjian.hr.service.system.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author cxy35
 * @Date 2020/1/6 14:37
 */
@RequestMapping("/system/basic/department")
@RestController
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @PostMapping("/add")
    public RespBean add(@RequestBody Department department) {
        int r = departmentService.add(department);
        if (r == 1) {
            return RespBean.ok("新增成功", department);
        } else {
            return RespBean.error("新增失败");
        }
    }

    @DeleteMapping("/deleteById/{id}")
    public RespBean deleteById(@PathVariable Integer id) {
        int r = departmentService.deleteById(id);
        if (r == 1) {
            return RespBean.ok("删除成功");
        } else if (r == -1) {
            return RespBean.error("删除失败，该部门下有子部门");
        } else if (r == -2) {
            return RespBean.error("删除失败，该部门下有员工");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @PutMapping("/edit")
    public RespBean edit(@RequestBody Department department) {
        int r = departmentService.edit(department);
        if (r == 1) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @GetMapping("/getListAllWithChildren")
    public List<Department> getListAllWithChildren() {
        return departmentService.getListAllWithChildren();
    }
}
