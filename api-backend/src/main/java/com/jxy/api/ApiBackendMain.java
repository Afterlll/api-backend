package com.jxy.api;

import org.apache.dubbo.config.spring.context.annotation.EnableDubbo;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.jxy.api.mapper")
@EnableDubbo
public class ApiBackendMain {

    public static void main(String[] args) {
        SpringApplication.run(ApiBackendMain.class, args);
    }

}
