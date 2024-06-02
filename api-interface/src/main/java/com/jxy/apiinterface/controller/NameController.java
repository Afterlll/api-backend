package com.jxy.apiinterface.controller;

import com.jxy.api.clientsdk.model.User;
import com.jxy.api.clientsdk.utils.SignUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.Duration;
import java.time.Instant;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 名称 API
 * @author wangkeyao
 */
@RestController
@RequestMapping("/name")
public class NameController {
    @GetMapping("/")
    public String getNameByGet(String name) {
        return "GET 你的名字是" + name;
    }

    @PostMapping("/")
    public String getNameByPost(@RequestParam String name) {
        return "POST 你的名字是" + name;
    }

    // todo 需要从数据库中获取
    private String accessKeyUser = "jxy";
    private String secretKeyUSer = "1234";
    // nonceCache是一个全局的ConcurrentHashMap<String, Long>
    private static ConcurrentHashMap<String, Long> nonceCache = new ConcurrentHashMap<>();
    private final Duration nonceValidity = Duration.ofMinutes(1); // nonce有效期
    private final Duration timestampValidity = Duration.ofMinutes(5); // timestamp有效期
    @PostMapping("/user")
    public String getUsernameByPost(@RequestBody User user, HttpServletRequest request) {
        String accessKey = request.getHeader("accessKey");
        String nonce = request.getHeader("nonce");
        String body = request.getHeader("body");
        String timestamp = request.getHeader("timestamp");
        String sign = request.getHeader("sign");
        // 验证 ak
        if (!accessKeyUser.equals(accessKey)) {
            throw new RuntimeException("无权限");
        }
        // 验证timestamp
        long currentTime = Instant.now().getEpochSecond();
        long receivedTimestamp = Long.parseLong(timestamp);
        if (Math.abs(currentTime - receivedTimestamp) > timestampValidity.getSeconds()) {
            throw new RuntimeException("请求已过期");
        }
        // 验证nonce
        if (!isValidNonce(nonce)) {
            throw new RuntimeException("无效的nonce");
        }
        // 验证sk
        if (!sign.equals(SignUtils.genSign(body, secretKeyUSer))) {
            throw new RuntimeException("无权限");
        }
        String result = "POST user.name = " + user.getName();
        return result;
    }

    // 存储nonce并验证其有效性
    private synchronized boolean isValidNonce(String nonce) {
        if (nonce == null) {
            return false;
        }
        Instant now = Instant.now();
        if (nonceCache.containsKey(nonce)) {
            Instant cachedInstant = Instant.ofEpochMilli(nonceCache.get(nonce));
            return !now.minus(nonceValidity).isAfter(cachedInstant); // nonce已过期
        } else {
            nonceCache.put(nonce, now.toEpochMilli()); // 存储新的nonce
        }
        return true;
    }
}
