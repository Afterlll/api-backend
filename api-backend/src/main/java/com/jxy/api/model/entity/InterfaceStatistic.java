package com.jxy.api.model.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 接口统计
 *
 * @author wangkeyao
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class InterfaceStatistic extends UserInterfaceInfo implements Serializable {
    /**
     * 总调用次数
     */
    private Integer totalNum;
    /**
     * 接口剩下的调用次数
     */
    private Integer leftNum;
}
