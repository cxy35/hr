package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.Department;
import com.zhengjian.hr.model.Nation;

import java.util.List;

public interface DepartmentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);

    List<Department> getListAll();

    List<Department> getListWithChildrenByParentId(Integer parentId);

    /**
     * 根据 departmentSearch（ id 除外）查询记录数
     * @param department 作为查询条件的对象（ id 除外），为 null 则查询对象总数
     * @return 记录数
     */
    Long count(Department department);

    /**
     * 通过调用存储过程。
     * 未使用，已经改成service实现
     * @param department
     */
    void add(Department department);

    /**
     * 通过调用存储过程。
     * 未使用，已经改成service实现
     * @param department
     */
    void deleteById(Department department);
}