package com.jxy.api.model.vo;

import com.jxy.api.model.entity.InterfaceInfo;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 接口信息 VO
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class InterfaceInfoVo extends InterfaceInfo implements Serializable {
    /**
     * 总调用次数
     */
    private Integer totalNum;
    /**
     * 接口剩下的调用次数
     */
    private Integer leftNum;
}