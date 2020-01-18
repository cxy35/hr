package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Employee record);

    int insertSelective(Employee record);

    Employee selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);

    int deleteByPrimaryKeys(@Param("ids") Integer[] ids);

    List<Employee> getListAll();

    List<Employee> getPage(@Param("offset") Integer offset, @Param("rows") Integer rows, @Param("employee") Employee employee, @Param("beginDateScope") Date[] beginDateScope);

    Long count(@Param("employee") Employee employee, @Param("beginDateScope") Date[] beginDateScope);

    Integer getMaxWorkId();

    int inserts(@Param("employeeList") List<Employee> employeeList);
}