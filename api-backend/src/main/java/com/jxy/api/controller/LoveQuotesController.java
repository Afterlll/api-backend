package com.jxy.api.controller;

import com.jxy.api.common.BaseResponse;
import com.jxy.api.common.ResultUtils;
import com.jxy.api.service.LoveQuotesService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.TimeUnit;

/**
 * 土味情话接口
 * @author wangkeyao
 */
@RestController
@RequestMapping("/loveQuotes")
public class LoveQuotesController {
    @Resource
    private LoveQuotesService loveQuotesService;
    @GetMapping("/random")
    public BaseResponse<Object> random(HttpServletResponse response) {
        return ResultUtils.success(loveQuotesService.randomQuotes());
    }

}
