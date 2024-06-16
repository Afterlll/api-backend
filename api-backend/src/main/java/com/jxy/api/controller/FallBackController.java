package com.jxy.api.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author wangkeyao
 */
@RestController
public class FallBackController {
    @RequestMapping("/fallback")
    public String fallback() {
        return "降级处理";
    }
}
