package com.zhengjian.hr.mail.activemq.config;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.jms.Queue;

@Configuration
public class ActiveMQConfig {
    public final static String QUEUE_NAME = "employee.welcome";

    @Bean
    Queue queue() {
        return new ActiveMQQueue(ActiveMQConfig.QUEUE_NAME);
    }
}
