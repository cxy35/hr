package com.zhengjian.hr.model;

public class MailConstants {
    public static final Integer STATUS_DELIVERING = 0; // 消息投递中
    public static final Integer STATUS_SUCCESS = 1; // 消息投递成功
    public static final Integer STATUS_FAILURE = 2; // 消息投递失败
    public static final Integer MAX_TRY_COUNT = 3; // 最大重试次数
    public static final Integer MSG_TIMEOUT = 1; // 消息超时时间（分钟），超过这个时间才会开始重试
    public static final String QUEUE_NAME = "hr.mail.employee.welcome.queue";
    public static final String EXCHANGE_NAME = "hr.mail.employee.welcome.exchange";
    public static final String ROUTING_KEY_NAME = "hr.mail.employee.welcome.routingKey";
}
