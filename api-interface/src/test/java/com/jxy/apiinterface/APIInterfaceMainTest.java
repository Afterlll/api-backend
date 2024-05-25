package com.jxy.apiinterface;

import com.jxy.api.clientsdk.client.ApiClient;
import com.jxy.api.clientsdk.model.User;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

/**
 * @author wangkeyao
 */
@SpringBootTest
class APIInterfaceMainTest {
    @Resource
    private ApiClient apiClient;
    @Test
    void contextLoads() {
        apiClient.getNameByGet("wangkeyao");
        apiClient.getNameByPost("wangkeyao");
        User user = new User();
        user.setName("wangkeyao");
        apiClient.getUsernameByPost(user);
    }
}