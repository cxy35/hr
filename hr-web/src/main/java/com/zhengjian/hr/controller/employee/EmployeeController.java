package com.zhengjian.hr.controller.employee;

import com.zhengjian.hr.common.pojo.RespBean;
import com.zhengjian.hr.common.pojo.RespPageBean;
import com.zhengjian.hr.common.util.POIUtils;
import com.zhengjian.hr.model.*;
import com.zhengjian.hr.service.employee.EmployeeService;
import com.zhengjian.hr.service.employee.NationService;
import com.zhengjian.hr.service.employee.PoliticsStatusService;
import com.zhengjian.hr.service.system.DepartmentService;
import com.zhengjian.hr.service.system.JobTitleService;
import com.zhengjian.hr.service.system.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * @Author cxy35
 * @Date 2020/1/10 9:59
 */
@RestController
@RequestMapping("/employee/basic")
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    NationService nationService;
    @Autowired
    PoliticsStatusService politicsStatusService;
    @Autowired
    JobTitleService jobTitleService;
    @Autowired
    PositionService positionService;
    @Autowired
    DepartmentService departmentService;

    @PostMapping("/add")
    public RespBean add(@RequestBody Employee employee) {
        int r = employeeService.add(employee);
        if (r == 1) {
            return RespBean.ok("新增成功");
        } else {
            return RespBean.error("新增失败");
        }
    }

    @DeleteMapping("/deleteById/{id}")
    public RespBean deleteById(@PathVariable Integer id) {
        int r = employeeService.deleteById(id);
        if (r == 1) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @DeleteMapping("/deleteByIds")
    public RespBean deleteByIds(Integer[] ids) {
        int r = employeeService.deleteByIds(ids);
        if (r == ids.length) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @PutMapping("/edit")
    public RespBean edit(@RequestBody Employee employee) {
        int r = employeeService.edit(employee);
        if (r == 1) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @GetMapping("/getPage")
    public RespPageBean getPage(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size, Employee employee, Date[] beginDateScope) {
        // Date 需要 DateConverter 才能传过来
        return employeeService.getPage(page, size, employee, beginDateScope);
    }

    @GetMapping("/getNationListAll")
    public List<Nation> getNationListAll() {
        return nationService.getListAll();
    }

    @GetMapping("/getPoliticsStatusListAll")
    public List<PoliticsStatus> getPoliticsStatusListAll() {
        return politicsStatusService.getListAll();
    }

    @GetMapping("/getJobTitleListAll")
    public List<JobTitle> getJobTitleListAll() {
        return jobTitleService.getListAll();
    }

    @GetMapping("/getPositionListAll")
    public List<Position> getPositionListAll() {
        return positionService.getListAll();
    }

    @GetMapping("/getDepartmentListAll")
    public List<Department> getDepartmentListAll() {
        return departmentService.getListAllWithChildren();
    }

    @GetMapping("/getNextWorkId")
    public RespBean getNextWorkId() {
        RespBean respBean = RespBean.build().setStatus(200)
                .setObj(String.format("%08d", employeeService.getMaxWorkId() + 1));
        return respBean;
    }

    @GetMapping("/export")
    public ResponseEntity<byte[]> doExport() {
        List<Employee> employeeList = (List<Employee>) employeeService.getPage(null, null, null, null).getData();
        return POIUtils.employee2Excel(employeeList);
    }

    @PostMapping("/import")
    public RespBean doImport(MultipartFile file) throws IOException {
        List<Employee> employeeList = POIUtils.excel2Employee(file, nationService.getListAll(), politicsStatusService.getListAll(), departmentService.getListAll(), positionService.getListAll(), jobTitleService.getListAll());
        if (employeeService.add(employeeList) == employeeList.size()) {
            return RespBean.ok("导入成功");
        }
        return RespBean.error("导入失败");
    }
}
