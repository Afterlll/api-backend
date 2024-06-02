package com.jxy.apigateway;

import com.jxy.api.clientsdk.utils.SignUtils;
import com.jxy.apicommon.dubbo.InterfaceInfoService;
import com.jxy.apicommon.dubbo.UserInterfaceInfoService;
import com.jxy.apicommon.dubbo.UserService;
import com.jxy.apicommon.model.dto.InterfaceInfoQueryRequest;
import com.jxy.apicommon.model.entity.InterfaceInfo;
import com.jxy.apicommon.model.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.apache.dubbo.config.annotation.DubboReference;
import org.reactivestreams.Publisher;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.core.io.buffer.DataBufferUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.RequestPath;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.http.server.reactive.ServerHttpResponseDecorator;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;


/**
 * 网关全局过滤器
 *
 * @author wangkeyao
 */
@Slf4j
@Component
public class CustomGlobalFilter implements GlobalFilter, Ordered {

    private static final List<String> IP_WHITE_LIST = Arrays.asList("127.0.0.1", "0:0:0:0:0:0:0:1");
    private static ConcurrentHashMap<String, Long> nonceCache = new ConcurrentHashMap<>();
    private final Duration nonceValidity = Duration.ofMinutes(1); // nonce有效期
    private final Duration timestampValidity = Duration.ofMinutes(5); // timestamp有效期

    @DubboReference
    private UserInterfaceInfoService userInterfaceInfoService;
    @DubboReference
    private UserService userService;
    @DubboReference
    private InterfaceInfoService interfaceInfoService;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        // 1. 打印请求日志
        ServerHttpRequest request = exchange.getRequest();
        log.info("请求唯一标识：" + request.getId());
        log.info("请求路径：" + request.getPath().value());
        log.info("请求方法：" + request.getMethod());
        log.info("请求参数：" + request.getQueryParams());
        String sourceAddress = request.getLocalAddress().getHostString();
        log.info("请求来源地址：" + sourceAddress);
        log.info("请求来源地址：" + request.getRemoteAddress());
        // 2. 黑白名单
        ServerHttpResponse response = exchange.getResponse();
        if (!IP_WHITE_LIST.contains(sourceAddress)) {
            // 响应码
            response.setStatusCode(HttpStatus.FORBIDDEN);
            // 返回
            return response.setComplete();
        }
        // 3. 用户鉴权（判断ak、sk是否合法）
        HttpHeaders headers = request.getHeaders();
        String accessKey = headers.getFirst("accessKey");
        String nonce = headers.getFirst("nonce");
        String timestamp = headers.getFirst("timestamp");
        String sign = headers.getFirst("sign");
        String body = headers.getFirst("body");
        long userId = Long.parseLong(Optional.ofNullable(headers.getFirst("userId")).orElse(""));
        long interfaceId = Long.parseLong(Optional.ofNullable(headers.getFirst("interfaceId")).orElse(""));
        // 获取分配给用户的 ak、sk
        User user = userService.queryById(userId);
        if (null == user) {
            return handleNoAuth(response);
        }
        String accessKeyUser = user.getAccessKey();
        String secretKeyUser = user.getSecretKey();
        // 验证 ak
        if (!accessKeyUser.equals(accessKey)) {
            return handleNoAuth(response);
        }
        // 验证timestamp
        long currentTime = Instant.now().getEpochSecond();
        long receivedTimestamp = Long.parseLong(Optional.ofNullable(timestamp).orElse("0"));
        if (Math.abs(currentTime - receivedTimestamp) > timestampValidity.getSeconds()) {
            return handleNoAuth(response);
        }
        // 验证nonce
        if (!isValidNonce(nonce)) {
            return handleNoAuth(response);
        }
        // 验证sk
        if (null == sign || !sign.equals(SignUtils.genSign(body, secretKeyUser))) {
            return handleNoAuth(response);
        }
        // 4. 请求的模拟接口是否存在
        // 直接从内存中读取网关接口是否存在
        Map<String, String> interfaceInfoMap = SaveInterfaceInfo.interfaceInfoMap.get(interfaceId);
        if (null == interfaceInfoMap) {
            // 不存在时读库
            // 从数据库中查询模拟接口是否存在，以及请求方法是否匹配（还可以校验请求参数）
            RequestPath uri = request.getPath();
            HttpMethod method = request.getMethod();
            InterfaceInfoQueryRequest interfaceInfoQueryRequest = new InterfaceInfoQueryRequest();
            interfaceInfoQueryRequest.setId(interfaceId);
            interfaceInfoQueryRequest.setMethod(method.name().toUpperCase());
            interfaceInfoQueryRequest.setUri(uri.value());
            interfaceInfoService.queryByDTO(interfaceInfoQueryRequest);
            InterfaceInfo interfaceInfo = interfaceInfoService.queryByDTO(interfaceInfoQueryRequest);
            if (null == interfaceInfo) {
                response.setStatusCode(HttpStatus.NOT_FOUND);
                return response.setComplete();
            }
        }
        // 5. 请求转发，调用模拟接口
//        Mono<Void> filter = chain.filter(exchange);
        // 6. 响应日志
        return handleResponse(exchange, chain, interfaceId, userId);
    }

    @Override
    public int getOrder() {
        return -1;
    }

    /**
     * 处理响应
     *
     * @param exchange
     * @param chain
     * @return
     */
    public Mono<Void> handleResponse(ServerWebExchange exchange, GatewayFilterChain chain, long interfaceId, long userId) {
        try {
            ServerHttpResponse originalResponse = exchange.getResponse();
            // 缓存数据的工厂
            DataBufferFactory bufferFactory = originalResponse.bufferFactory();
            // 拿到响应码
            HttpStatus statusCode = originalResponse.getStatusCode();
            if (statusCode == HttpStatus.OK) {
                // 装饰器，增强能力
                ServerHttpResponseDecorator decoratedResponse = new ServerHttpResponseDecorator(originalResponse) {
                    // 等调用完转发的接口后才会执行
                    @Override
                    public Mono<Void> writeWith(Publisher<? extends DataBuffer> body) {
                        log.info("body instanceof Flux: {}", (body instanceof Flux));
                        if (body instanceof Flux) {
                            Flux<? extends DataBuffer> fluxBody = Flux.from(body);
                            // 往返回值里写数据
                            // 拼接字符串
                            return super.writeWith(
                                    fluxBody.map(dataBuffer -> {
                                        // 7. 调用成功，接口调用次数 + 1 invokeCount
                                        try {
                                            userInterfaceInfoService.invokeCount(interfaceId, userId);
                                        } catch (Exception e) {
                                            log.error("接口调用次数 调用失败！", e);
                                        }
                                        byte[] content = new byte[dataBuffer.readableByteCount()];
                                        dataBuffer.read(content);
                                        DataBufferUtils.release(dataBuffer);//释放掉内存
                                        // 构建日志
                                        StringBuilder sb2 = new StringBuilder(200);
                                        List<Object> rspArgs = new ArrayList<>();
                                        rspArgs.add(originalResponse.getStatusCode());
                                        String data = new String(content, StandardCharsets.UTF_8); //data
                                        sb2.append(data);
                                        // 打印日志
                                        log.info("响应结果：" + data);
                                        return bufferFactory.wrap(content);
                                    }));
                        } else {
                            // 8. 调用失败，返回一个规范的错误码
                            log.error("<--- {} 响应code异常", getStatusCode());
                        }
                        return super.writeWith(body);
                    }
                };
                // 设置 response 对象为装饰过的
                return chain.filter(exchange.mutate().response(decoratedResponse).build());
            }
            return chain.filter(exchange); // 降级处理返回数据
        } catch (Exception e) {
            log.error("网关处理响应异常" + e);
            return chain.filter(exchange);
        }
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

    public Mono<Void> handleNoAuth(ServerHttpResponse response) {
        response.setStatusCode(HttpStatus.FORBIDDEN);
        return response.setComplete();
    }

    public Mono<Void> handleInvokeError(ServerHttpResponse response) {
        response.setStatusCode(HttpStatus.INTERNAL_SERVER_ERROR);
        return response.setComplete();
    }

}