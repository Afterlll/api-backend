package com.jxy.apiinterface.client;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONUtil;
import com.jxy.apiinterface.model.User;
import com.jxy.apiinterface.utils.SignUtils;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

/**
 * 名称 API 客户端
 * @author wangkeyao
 */
@NoArgsConstructor
@AllArgsConstructor
public class ApiClient {

    private String accessKey;

    private String secretKey;

    public String getNameByGet(String name) {
        //可以单独传入http参数，这样参数会自动做URL编码，拼接在URL中
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("name", name);
        String result = HttpUtil.get("http://localhost:8123/api/name/", paramMap);
        System.out.println(result);
        return result;
    }

    public String getNameByPost(String name) {
        //可以单独传入http参数，这样参数会自动做URL编码，拼接在URL中
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("name", name);
        String result = HttpUtil.post("http://localhost:8123/api/name/", paramMap);
        System.out.println(result);
        return result;
    }

    private Map<String, String> getHeaderMap(String body) {
        Map<String, String> hashMap = new HashMap<>();
        hashMap.put("accessKey", accessKey);
        // 一定不能直接发送
//        hashMap.put("secretKey", secretKey); // 密钥
        hashMap.put("nonce", RandomUtil.randomNumbers(4)); // 随机数
        hashMap.put("body", body); // 用户参数
        hashMap.put("timestamp", String.valueOf(System.currentTimeMillis() / 1000)); // 时间戳
        hashMap.put("sign", SignUtils.genSign(body, secretKey)); // 用户参数 + 密钥 => 签名生成算法 => 不可解密的值
        return hashMap;
    }


    /**
     * 使用 API 签名认证
     * @param user
     * @return
     */
    public String getUsernameByPost(User user) {
        HttpResponse httpResponse = HttpRequest.post("http://localhost:8123/api/name/user")
                .addHeaders(getHeaderMap(user.getName())) // 给post请求添加请求头进行签名认证
                .body(JSONUtil.toJsonStr(user))
                .execute();
        System.out.println(httpResponse.getStatus());
        String result = httpResponse.body();
        System.out.println(result);
        return result;
    }

    public static void main(String[] args) {
        new ApiClient().getNameByGet("江喜原");
        new ApiClient().getNameByPost("江喜原");
        User user = new User();
        user.setName("jxy");
        new ApiClient("jxy", "1234").getUsernameByPost(user);
    }
}
