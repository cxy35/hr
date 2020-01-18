package com.zhengjian.hr.service.system;

import com.zhengjian.hr.mapper.JobTitleMapper;
import com.zhengjian.hr.model.JobTitle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/2 11:52
 */
@Service
public class JobTitleService {
    @Autowired
    JobTitleMapper jobTitleMapper;

    public int add(JobTitle jobTitle) {
        jobTitle.setCreateDate(new Date());
        jobTitle.setEnabled(true);
        return jobTitleMapper.insertSelective(jobTitle);
    }

    public int deleteById(Integer id) {
        return jobTitleMapper.deleteByPrimaryKey(id);
    }

    public int deleteByIds(Integer[] ids) {
        return jobTitleMapper.deleteByPrimaryKeys(ids);
    }

    public int edit(JobTitle jobTitle) {
        return jobTitleMapper.updateByPrimaryKeySelective(jobTitle);
    }

    public List<JobTitle> getListAll() {
        return jobTitleMapper.getListAll();
    }
}
