package com.jxy.apicommon.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 查询请求
 *
 * @author jxy
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class InterfaceInfoQueryRequest implements Serializable {

    /**
     * 主键
     */
    private Long id;

    /**
     * 名称
     */
    private String name;

    /**
     * 描述
     */
    private String description;
    /**
     * 接口协议
     */
    private String protocol;
    /**
     * 接口服务器地址
     */
    private String host;
    /**
     * 接口uri地址
     */
    private String uri;

    /**
     * 请求参数
     */
    private String requestParams;

    /**
     * 请求头
     */
    private String requestHeader;

    /**
     * 响应头
     */
    private String responseHeader;

    /**
     * 接口状态（0-关闭，1-开启）
     */
    private Integer status;

    /**
     * 请求类型
     */
    private String method;

    /**
     * 创建人
     */
    private Long userId;

}