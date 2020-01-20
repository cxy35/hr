package com.zhengjian.hr.mail;

import com.zhengjian.hr.mail.activemq.config.ActiveMQConfig;
import com.zhengjian.hr.model.Employee;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jms.core.JmsMessagingTemplate;

import java.util.Date;

@SpringBootTest
class HrMailApplicationTests {

    @Autowired
    JmsMessagingTemplate jmsMessagingTemplate;

    @Test
    void contextLoads() {
        Employee employee = new Employee();
        employee.setName("张三");
        employee.setGender("男");
        employee.setAddress("杭州市西湖区");
        employee.setBeginDate(new Date());
        jmsMessagingTemplate.convertAndSend(ActiveMQConfig.QUEUE_NAME, employee);
    }

}
