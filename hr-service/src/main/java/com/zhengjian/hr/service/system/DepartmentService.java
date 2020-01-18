package com.zhengjian.hr.service.system;

import com.zhengjian.hr.mapper.DepartmentMapper;
import com.zhengjian.hr.mapper.EmployeeMapper;
import com.zhengjian.hr.model.Department;
import com.zhengjian.hr.model.Employee;
import com.zhengjian.hr.service.employee.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/6 14:38
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    @Transactional
    public int add(Department department) {
        Integer parentId = department.getParentId();
        if (parentId == null) {
            return 0;
        }

        // 新增当前部门
        department.setEnabled(true);
        department.setIsParent(false);
        int r = departmentMapper.insertSelective(department);

        // 更新上级部门的 isParent
        Department departmentParent = departmentMapper.selectByPrimaryKey(parentId);
        departmentParent.setIsParent(true);
        departmentMapper.updateByPrimaryKeySelective(departmentParent);

        // 更新当前部门的 depPath
        department.setDepPath(departmentParent.getDepPath() + "." + department.getId());
        departmentMapper.updateByPrimaryKeySelective(department);

        return r;
    }

    @Transactional
    public int deleteById(Integer id) {
        if (id == null) {
            return 0;
        }

        // 验证是否有子部门
        Department departmentSearch = new Department();
        departmentSearch.setParentId(id);
        Long countChildren = departmentMapper.count(departmentSearch);
        if (countChildren > 0) {
            return -1;
        }

        // 验证是否有员工
        Employee employeeSearch = new Employee();
        employeeSearch.setDepartmentId(id);
        Long countEmployee = employeeMapper.count(employeeSearch, null);
        if (countEmployee > 0) {
            return -2;
        }

        // 删除当前部门
        Department department = departmentMapper.selectByPrimaryKey(id);
        Integer parentId = department.getParentId();
        int r = departmentMapper.deleteByPrimaryKey(id);

        // 更新上级部门的 isParent
        departmentSearch = new Department();
        departmentSearch.setParentId(parentId);
        Long countChildren2 = departmentMapper.count(departmentSearch);
        if (countChildren2 == 0) {
            Department departmentParent = departmentMapper.selectByPrimaryKey(parentId);
            departmentParent.setIsParent(false);
            departmentMapper.updateByPrimaryKeySelective(departmentParent);
        }

        return r;
    }

    public int edit(Department department) {
        return departmentMapper.updateByPrimaryKeySelective(department);
    }

    public List<Department> getListAll() {
        return departmentMapper.getListAll();
    }

    public List<Department> getListAllWithChildren() {
        return departmentMapper.getListWithChildrenByParentId(-1);
    }
}
