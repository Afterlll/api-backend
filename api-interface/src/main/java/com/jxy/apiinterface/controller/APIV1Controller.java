package com.jxy.apiinterface.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.jxy.api.clientsdk.client.ApiClient;
import com.jxy.api.clientsdk.model.*;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

import java.util.Map;

import static com.jxy.api.clientsdk.model.ResponseUtils.baseResponse;
import static com.jxy.api.clientsdk.model.ResponseUtils.responseToMap;
import static com.jxy.api.clientsdk.utils.RequestUtils.buildUrl;
import static com.jxy.api.clientsdk.utils.RequestUtils.get;

/**
 * 提供 API 接口调用
 * @author wangkeyao
 */
@RestController
@RequestMapping("/v1")
public class APIV1Controller {
    @Resource
    private ApiClient apiClient;

    /**
     * 随机土味情话API
     * @return
     */
    @GetMapping("/loveQuotes/random")
    public Object liveQuoteRandom() {
        return apiClient.loveQuotesRandom();
    }

    /**
     * 毒鸡汤API
     * @return
     */
    @GetMapping("/poisonousChickenSoup")
    public String getPoisonousChickenSoup() {
        return get("https://api.btstu.cn/yan/api.php?charset=utf-8&encode=json");
    }

    /**
     * 随机壁纸API
     * @param randomWallpaperParams
     * @return
     */
    @GetMapping("/randomWallpaper")
    public RandomWallpaperResponse randomWallpaper(RandomWallpaperParams randomWallpaperParams) throws Exception {
        String baseUrl = "https://api.btstu.cn/sjbz/api.php";
        String url = buildUrl(baseUrl, randomWallpaperParams);
        if (StrUtil.isAllBlank(randomWallpaperParams.getLx(), randomWallpaperParams.getMethod())) {
            url = url + "?format=json";
        } else {
            url = url + "&format=json";
        }
        return JSONUtil.toBean(get(url), RandomWallpaperResponse.class);
    }

    @GetMapping("/horoscope")
    public ResultResponse getHoroscope(HoroscopeParams horoscopeParams) throws Exception {
        String response = get("https://api.vvhan.com/api/horoscope", horoscopeParams);
        Map<String, Object> fromResponse = responseToMap(response);
        boolean success = (boolean) fromResponse.get("success");
        if (!success) {
            ResultResponse baseResponse = new ResultResponse();
            baseResponse.setData(fromResponse);
            return baseResponse;
        }
        return JSONUtil.toBean(response, ResultResponse.class);
    }

    /**
     * IP API
     * @param ipInfoParams
     * @return
     */
    @GetMapping("/ipInfo")
    public ResultResponse getIpInfo(IpInfoParams ipInfoParams) {
        return baseResponse("https://api.vvhan.com/api/ipInfo", ipInfoParams);
    }

    /**
     * 天气 API
     * @param weatherParams
     * @return
     */
    @GetMapping("/weather")
    public ResultResponse getWeatherInfo(WeatherParams weatherParams) {
        return baseResponse("https://api.vvhan.com/api/weather", weatherParams);
    }

}
