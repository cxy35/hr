package com.zhengjian.hr.controller.system;

import com.zhengjian.hr.common.pojo.RespBean;
import com.zhengjian.hr.model.JobTitle;
import com.zhengjian.hr.service.system.JobTitleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author cxy35
 * @Date 2020/1/2 11:50
 */
@RequestMapping("/system/basic/jobTitle")
@RestController
public class JobTitleController {
    @Autowired
    JobTitleService jobTitleService;

    @PostMapping("/add")
    public RespBean add(@RequestBody JobTitle jobTitle) {
        int r = jobTitleService.add(jobTitle);
        if (r == 1) {
            return RespBean.ok("新增成功");
        } else {
            return RespBean.error("新增失败");
        }
    }

    @DeleteMapping("/deleteById/{id}")
    public RespBean deleteById(@PathVariable Integer id) {
        int r = jobTitleService.deleteById(id);
        if (r == 1) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @DeleteMapping("/deleteByIds")
    public RespBean deleteByIds(Integer[] ids) {
        int r = jobTitleService.deleteByIds(ids);
        if (r == ids.length) {
            return RespBean.ok("删除成功");
        } else {
            return RespBean.error("删除失败");
        }
    }

    @PutMapping("/edit")
    public RespBean edit(@RequestBody JobTitle jobTitle) {
        int r = jobTitleService.edit(jobTitle);
        if (r == 1) {
            return RespBean.ok("编辑成功");
        } else {
            return RespBean.error("编辑失败");
        }
    }

    @GetMapping("/getListAll")
    public List<JobTitle> getListAll() {
        return jobTitleService.getListAll();
    }

}
