package com.zhengjian.hr.mail.rabbitmq.config;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {
    public final static String QUEUE_NAME = "employee.welcome2";

    @Bean
    Queue queue2() {
        return new Queue(RabbitMQConfig.QUEUE_NAME);
    }

}
