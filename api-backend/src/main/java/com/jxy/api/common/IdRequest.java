package com.jxy.api.common;

import lombok.Data;

import java.io.Serializable;

/**
 * id通用请求封装类
 *
 * @author jxy
 */
@Data
public class IdRequest implements Serializable {
    /**
     * id
     */
    private Long id;

    private static final long serialVersionUID = 1L;
}