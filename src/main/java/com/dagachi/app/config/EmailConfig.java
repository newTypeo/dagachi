package com.dagachi.app.config;

import java.util.Properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
@ConfigurationProperties(prefix = "spring.mail")
public class EmailConfig {
    private String host;
    private int port;
    private String username;
    private String password;
    private boolean auth;
    private boolean starttlsEnable;
    private boolean starttlsRequired;
    private int connectionTimeout;
    private int timeout;
    private int writeTimeout;

    // Getter and Setter methods

    @Bean
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setUsername("khsso102649@gmail.com");
        mailSender.setPassword("yjuikbjezgbyosyw");
        mailSender.setDefaultEncoding("UTF-8");
        mailSender.setJavaMailProperties(getMailProperties());
        return mailSender;
    }

    private Properties getMailProperties() {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true"); // 이 부분 추가
        properties.put("mail.smtp.starttls.required", "true");
        properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        properties.put("mail.smtp.connectiontimeout", "500");
        properties.put("mail.smtp.timeout", "5000");
        properties.put("mail.smtp.writetimeout", "5000");

        return properties;
    }
}