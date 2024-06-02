package com.jxy.apigateway;

import org.apache.dubbo.config.spring.context.annotation.EnableDubbo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.gateway.config.GatewayMetricsAutoConfiguration;

/**
 * @author wangkeyao
 */
@SpringBootApplication
@EnableDubbo
public class ApiGateMain {
    public static void main(String[] args) {
        SpringApplication.run(ApiGateMain.class, args);
    }
}
