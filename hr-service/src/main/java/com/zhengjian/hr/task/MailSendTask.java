package com.zhengjian.hr.task;

import com.zhengjian.hr.mapper.EmployeeMapper;
import com.zhengjian.hr.model.Employee;
import com.zhengjian.hr.model.MailConstants;
import com.zhengjian.hr.model.MailSendLog;
import com.zhengjian.hr.service.mail.MailSendLogService;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
public class MailSendTask {
    @Autowired
    MailSendLogService mailSendLogService;
    @Autowired
    RabbitTemplate rabbitTemplate;
    @Autowired
    EmployeeMapper employeeMapper;

    @Scheduled(cron = "0/10 * * * * ?")
    public void mailResendTask() {
        List<MailSendLog> logs = mailSendLogService.getMailSendLogsByStatus();
        if (logs == null || logs.size() == 0) {
            return;
        }
        logs.forEach(mailSendLog -> {
            if (mailSendLog.getCount() >= MailConstants.MAX_TRY_COUNT) {
                // 设置该条消息发送失败
                mailSendLogService.updateMailSendLogStatus(mailSendLog.getMsgId(), MailConstants.STATUS_FAILURE);
            } else {
                mailSendLogService.updateCount(mailSendLog.getMsgId(), new Date());
                Employee emp = employeeMapper.selectWithAllByPrimaryKey(mailSendLog.getEmpId());
                rabbitTemplate.convertAndSend(MailConstants.EXCHANGE_NAME, MailConstants.ROUTING_KEY_NAME, emp, new CorrelationData(mailSendLog.getMsgId()));
            }
        });
    }
}
