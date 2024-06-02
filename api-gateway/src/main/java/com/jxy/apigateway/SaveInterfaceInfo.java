package com.jxy.apigateway;

import com.jxy.apicommon.dubbo.InterfaceInfoService;
import com.jxy.apicommon.model.entity.InterfaceInfo;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 网关启动时，获取所有的接口信息，维护到内存的 hashmap 中;
 * 有请求时，根据请求的 uri 路径或者其他参数(比如 host 请求头)来判断应该转发到哪台服务器、以及用于校验接口是否存在
 * @author wangkeyao
 */
@Component
public class SaveInterfaceInfo {
    @DubboReference
    private InterfaceInfoService interfaceInfoService;
    // 存放接口id 和 url 的映射关系
    public static Map<Long, Map<String, String>> interfaceInfoMap = new HashMap<>();
    @PostConstruct
    public void initData() {
        List<InterfaceInfo> interfaceInfos = interfaceInfoService.queryList();
        interfaceInfoMap = interfaceInfos.stream()
                .collect(Collectors.toMap(
                        InterfaceInfo::getId,
                        interfaceInfo -> {
                            Map<String, String> map = new HashMap<>();
                            map.put("protocol", interfaceInfo.getProtocol());
                            map.put("host", interfaceInfo.getHost());
                            map.put("uri", interfaceInfo.getUri());
                            map.put("method", interfaceInfo.getMethod());
                            return map;
                        }
                ));
    }
}
