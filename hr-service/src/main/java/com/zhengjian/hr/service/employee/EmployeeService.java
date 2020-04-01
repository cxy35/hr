package com.zhengjian.hr.service.employee;

import com.zhengjian.hr.common.pojo.RespPageBean;
import com.zhengjian.hr.mapper.EmployeeMapper;
import com.zhengjian.hr.model.Employee;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @Author cxy35
 * @Date 2020/1/10 9:59
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    JmsMessagingTemplate jmsMessagingTemplate;

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    private SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    private SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
    private DecimalFormat decimalFormat = new DecimalFormat("##.00");

    public int add(Employee employee) {
        handleContractTerm(employee);
        int r = employeeMapper.insertSelective(employee);
        if (r == 1) {
            // 获取关联信息
            Employee employeeWithAll = employeeMapper.selectWithAllByPrimaryKey(employee.getId());
            jmsMessagingTemplate.convertAndSend("employee.welcome", employeeWithAll);
        }
        return r;
    }

    public int add(List<Employee> employeeList) {
        return employeeMapper.inserts(employeeList);
    }

    public int deleteById(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }

    public int deleteByIds(Integer[] ids) {
        return employeeMapper.deleteByPrimaryKeys(ids);
    }

    public int edit(Employee employee) {
        handleContractTerm(employee);
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public boolean editSalaryId(Integer id, Integer salaryId) {
        if (id == null) {
            return false;
        }
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        if (employee == null) {
            return false;
        }
        employee.setSalaryId(salaryId);
        int r = employeeMapper.updateByPrimaryKeySelective(employee);
        return r == 1;
    }

    public List<Employee> getListAll() {
        return employeeMapper.getListAll();
    }

    public RespPageBean getPage(Integer page, Integer size, Employee employee, Date[] beginDateScope) {
        Integer offset = 0;
        if (page != null && size != null) {
            offset = (page - 1) * size;
        }

        List<Employee> employeeList = employeeMapper.getPage(offset, size, employee, beginDateScope);
        Long count = employeeMapper.count(employee, beginDateScope);

        RespPageBean bean = new RespPageBean();
        bean.setData(employeeList);
        bean.setTotal(count);
        return bean;
    }

    public Integer getMaxWorkId() {
        return employeeMapper.getMaxWorkId();
    }

    /**
     * 处理合同期限
     *
     * @param employee
     */
    private void handleContractTerm(Employee employee) {
        Date beginContract = employee.getBeginContract();
        Date endContract = employee.getEndContract();
        double month = (Double.parseDouble(yearFormat.format(endContract)) - Double.parseDouble(yearFormat.format(beginContract))) * 12 + (Double.parseDouble(monthFormat.format(endContract)) - Double.parseDouble(monthFormat.format(beginContract)));
        employee.setContractTerm(Double.parseDouble(decimalFormat.format(month / 12)));
    }
}
