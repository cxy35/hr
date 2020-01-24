package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.Salary;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SalaryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Salary record);

    int insertSelective(Salary record);

    Salary selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Salary record);

    int updateByPrimaryKey(Salary record);

    int deleteByPrimaryKeys(@Param("ids") Integer[] ids);

    List<Salary> getListAll();
}