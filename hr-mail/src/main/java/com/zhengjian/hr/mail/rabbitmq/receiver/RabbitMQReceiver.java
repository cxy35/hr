package com.zhengjian.hr.mail.rabbitmq.receiver;

import com.zhengjian.hr.mail.rabbitmq.config.RabbitMQConfig;
import com.zhengjian.hr.model.Employee;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Date;

@Component
public class RabbitMQReceiver {
    @Autowired
    JavaMailSender javaMailSender;
    @Autowired
    MailProperties mailProperties;
    @Autowired
    TemplateEngine templateEngine;

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    // 监听队列
    // @RabbitListener(queues = RabbitMQConfig.QUEUE_NAME)
    public void employeeWelcome(Employee employee) {
        logger.info(employee.toString());
        // 收到消息，发送邮件
        MimeMessage msg = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg);
        try {
            helper.setSubject("入职通知");
            helper.setFrom(mailProperties.getUsername());
            helper.setTo(employee.getEmail());
            helper.setSentDate(new Date());

            Context context = new Context();
            context.setVariable("name", employee.getName());
            context.setVariable("positionName", employee.getPosition().getName());
            context.setVariable("jobTitlelName", employee.getJobTitle().getName());
            context.setVariable("departmentName", employee.getDepartment().getName());
            String process = templateEngine.process("employee/welcome", context);
            helper.setText(process, true);
            javaMailSender.send(msg);
        } catch (MessagingException e) {
            e.printStackTrace();
            logger.error("邮件发送失败：" + e.getMessage());
        }
    }
}
