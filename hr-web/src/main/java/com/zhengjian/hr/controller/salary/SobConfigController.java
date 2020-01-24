package com.zhengjian.hr.controller.salary;

import com.zhengjian.hr.common.pojo.RespBean;
import com.zhengjian.hr.common.pojo.RespPageBean;
import com.zhengjian.hr.model.Employee;
import com.zhengjian.hr.model.Salary;
import com.zhengjian.hr.service.employee.EmployeeService;
import com.zhengjian.hr.service.salary.SalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/24 14:20
 */
@RestController
@RequestMapping("/salary/sobcfg")
public class SobConfigController {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    SalaryService salaryService;

    @PutMapping("/editSalaryId")
    public RespBean editSalaryId(Integer id, Integer salaryId) {
        boolean r = employeeService.editSalaryId(id, salaryId);
        if (r) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @GetMapping("/getPage")
    public RespPageBean getPage(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size, Employee employee) {
        return employeeService.getPage(page, size, employee, null);
    }

    @GetMapping("/getSalaryListAll")
    public List<Salary> getSalaryListAll() {
        return salaryService.getListAll();
    }

}
