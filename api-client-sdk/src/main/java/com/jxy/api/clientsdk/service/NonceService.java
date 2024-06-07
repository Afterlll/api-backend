package com.jxy.api.clientsdk.service;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.concurrent.TimeUnit;

/**
 * 使用滑动窗口机制和分布式锁来处理并发请求中可能出现的相同nonce
 */
@Service
public class NonceService {

    private final RedisTemplate<String, String> redisTemplate;
    private final Duration nonceWindow = Duration.ofMinutes(1);
    private final int nonceWindowLimit = 100; // 在窗口内允许的最大nonce数量

    public NonceService(RedisTemplate<String, String> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public boolean isValidNonce(String nonce) {
        String key = "nonce:" + nonce;
        long currentTime = System.currentTimeMillis();

        // 检查nonce是否在有效期内
        String storedTimeStr = redisTemplate.opsForValue().get(key);
        if (storedTimeStr == null || currentTime - Long.parseLong(storedTimeStr) > nonceWindow.toMillis()) {
            return false;
        }

        // 使用分布式锁防止并发冲突
        String lockKey = "nonce_lock:" + nonce;
        if (redisTemplate.opsForValue().setIfAbsent(lockKey, "locked", 5, TimeUnit.SECONDS)) {
            try {
                // 同步执行自增操作
                Long incrementedValue = redisTemplate.opsForValue().increment(key);
                // 检查自增后的值是否超过了窗口限制
                return incrementedValue <= nonceWindowLimit;
            } finally {
                // 释放锁
                redisTemplate.delete(lockKey);
            }
        } else {
            // 锁已被其他线程获取，可以选择重试或直接返回失败
            return false;
        }
    }
}
