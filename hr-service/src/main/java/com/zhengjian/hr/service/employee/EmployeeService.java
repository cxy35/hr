package com.zhengjian.hr.service.employee;

import com.zhengjian.hr.common.pojo.RespPageBean;
import com.zhengjian.hr.mapper.EmployeeMapper;
import com.zhengjian.hr.model.Employee;
import com.zhengjian.hr.model.MailConstants;
import com.zhengjian.hr.model.MailSendLog;
import com.zhengjian.hr.service.mail.MailSendLogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @Author cxy35
 * @Date 2020/1/10 9:59
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    //    @Autowired
//    JmsMessagingTemplate jmsMessagingTemplate;
    @Autowired
    RabbitTemplate rabbitTemplate; // RabbitMQConfig 中自定义过，增加了消息发送回调，提高消息发送可靠性
    @Autowired
    MailSendLogService mailSendLogService;

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

            // jmsMessagingTemplate.convertAndSend(MailConstants.QUEUE_NAME, employeeWithAll);

            // 生成消息的唯一id
            String msgId = UUID.randomUUID().toString();
            MailSendLog mailSendLog = new MailSendLog();
            mailSendLog.setMsgId(msgId);
            Date date = new Date();
            mailSendLog.setCreateTime(date);
            mailSendLog.setUpdateTime(date);
            mailSendLog.setExchange(MailConstants.EXCHANGE_NAME);
            mailSendLog.setRouteKey(MailConstants.ROUTING_KEY_NAME);
            mailSendLog.setEmpId(employeeWithAll.getId());
            mailSendLog.setTryTime(new Date(System.currentTimeMillis() + 1000 * 60 * MailConstants.MSG_TIMEOUT));
            mailSendLogService.insert(mailSendLog);
            rabbitTemplate.convertAndSend(MailConstants.EXCHANGE_NAME, MailConstants.ROUTING_KEY_NAME, employeeWithAll, new CorrelationData(msgId));
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
