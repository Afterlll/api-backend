package com.jxy.api.clientsdk;

import com.jxy.api.clientsdk.client.ApiClient;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * 客户端sdk入口配置
 * @author wangkeyao
 */
@Configuration
@ConfigurationProperties(prefix = "api.client")
@ComponentScan
@Data
public class ApiClientConfig {
    /**
     * ak密钥
     */
    private String accessKey;
    /**
     * sk密钥
     */
    private String secretKey;

    @Bean
    public ApiClient getApiClient() {
        return new ApiClient(accessKey, secretKey);
    }
}
