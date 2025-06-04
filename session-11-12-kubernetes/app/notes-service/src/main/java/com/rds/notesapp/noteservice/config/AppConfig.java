package com.rds.notesapp.noteservice.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AppConfig {

    @Bean(name = "restTemplateLoadBalanced")
    public RestTemplate restTemplateLoadBalanced() {
        return new RestTemplate();
    }

    @Bean(name = "restTemplate")
    @Primary
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

}
