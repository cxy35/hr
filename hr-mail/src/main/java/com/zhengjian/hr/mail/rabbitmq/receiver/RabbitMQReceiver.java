package com.zhengjian.hr.mail.rabbitmq.receiver;

import com.rabbitmq.client.Channel;
import com.zhengjian.hr.model.Employee;
import com.zhengjian.hr.model.MailConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Date;

@Component
public class RabbitMQReceiver {
    @Autowired
    JavaMailSender javaMailSender;
    @Autowired
    MailProperties mailProperties;
    @Autowired
    TemplateEngine templateEngine;
    @Autowired
    StringRedisTemplate stringRedisTemplate;

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    // 监听队列
    @RabbitListener(queues = MailConstants.QUEUE_NAME)
    public void employeeWelcome(Message message, Channel channel) throws IOException {
        Employee employee = (Employee) message.getPayload();
        MessageHeaders headers = message.getHeaders();
        Long tag = (Long) headers.get(AmqpHeaders.DELIVERY_TAG);
        String msgId = (String) headers.get("spring_returned_message_correlation");
        if (stringRedisTemplate.opsForHash().entries("mail_log").containsKey(msgId)) {
            // redis 中包含该 key，说明该消息已经被消费过
            logger.info("消息已经被消费：" + msgId);
            channel.basicAck(tag, false); // 手动确认消息已消费
            return;
        }
        logger.info(employee.toString());

        // 发送邮件
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

            stringRedisTemplate.opsForHash().put("mail_log", msgId, "cxy35");
            channel.basicAck(tag, false); // 手动确认消息已消费
            logger.info("邮件发送成功：" + msgId);
        } catch (MessagingException e) {
            channel.basicNack(tag, false, true); // 消息消费失败，重回队列
            e.printStackTrace();
            logger.error("邮件发送失败：" + e.getMessage());
        }
    }
}
