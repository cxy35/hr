package com.zhengjian.hr.mail.rabbitmq.config;

import com.zhengjian.hr.model.MailConstants;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {
    @Bean
    Queue queue() {
        return new Queue(MailConstants.QUEUE_NAME);
    }

}
