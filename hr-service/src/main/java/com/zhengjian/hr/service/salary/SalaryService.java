package com.zhengjian.hr.service.salary;

import com.zhengjian.hr.mapper.SalaryMapper;
import com.zhengjian.hr.model.Salary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/23 15:56
 */
@Service
public class SalaryService {
    @Autowired
    SalaryMapper salaryMapper;

    public int add(Salary salary) {
        salary.setCreateDate(new Date());
        return salaryMapper.insertSelective(salary);
    }

    public int deleteById(Integer id) {
        return salaryMapper.deleteByPrimaryKey(id);
    }

    public int deleteByIds(Integer[] ids) {
        return salaryMapper.deleteByPrimaryKeys(ids);
    }

    public int edit(Salary salary) {
        return salaryMapper.updateByPrimaryKeySelective(salary);
    }

    public List<Salary> getListAll() {
        return salaryMapper.getListAll();
    }
}
