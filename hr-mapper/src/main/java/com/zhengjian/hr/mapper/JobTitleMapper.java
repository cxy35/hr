package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.JobTitle;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface JobTitleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(JobTitle record);

    int insertSelective(JobTitle record);

    JobTitle selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(JobTitle record);

    int updateByPrimaryKey(JobTitle record);

    int deleteByPrimaryKeys(@Param("ids") Integer[] ids);

    List<JobTitle> getListAll();
}