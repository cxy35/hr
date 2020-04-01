package com.zhengjian.hr.controller.salary;

import com.zhengjian.hr.common.pojo.RespBean;
import com.zhengjian.hr.model.Salary;
import com.zhengjian.hr.service.salary.SalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author cxy35
 * @Date 2020/1/23 15:57
 */
@RestController
@RequestMapping("/salary/sob")
public class SalaryController {
    @Autowired
    SalaryService salaryService;

    @PostMapping("/add")
    public RespBean add(@RequestBody Salary salary) {
        int r = salaryService.add(salary);
        if (r == 1) {
            return RespBean.ok("新增成功");
        } else {
            return RespBean.error("新增失败");
        }
    }

    @DeleteMapping("/deleteById/{id}")
    public RespBean deleteById(@PathVariable Integer id) {
        int r = salaryService.deleteById(id);
        if (r == 1) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @DeleteMapping("/deleteByIds")
    public RespBean deleteByIds(Integer[] ids) {
        int r = salaryService.deleteByIds(ids);
        if (r == ids.length) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @PutMapping("/edit")
    public RespBean edit(@RequestBody Salary salary) {
        int r = salaryService.edit(salary);
        if (r == 1) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @GetMapping("/getListAll")
    public List<Salary> getListAll() {
        return salaryService.getListAll();
    }

}
