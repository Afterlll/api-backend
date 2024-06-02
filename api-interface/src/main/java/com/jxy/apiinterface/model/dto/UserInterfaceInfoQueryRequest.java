package com.jxy.apiinterface.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 查询请求
 *
 * @author jxy
 */
@Data
public class UserInterfaceInfoQueryRequest implements Serializable {
    private Long id;

    /**
     * 调用用户 id
     */
    private Long userId;

    /**
     * 接口 id
     */
    private Long interfaceInfoId;

    /**
     * 总调用次数
     */
    private Integer totalNum;

    /**
     * 剩余调用次数
     */
    private Integer leftNum;

    /**
     * 0-正常，1-禁用
     */
    private Integer status;

    private static final long serialVersionUID = 1L;
}