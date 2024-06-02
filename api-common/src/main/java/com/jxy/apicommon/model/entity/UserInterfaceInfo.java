package com.jxy.apicommon.model.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户调用接口关系
 * @TableName user_interface_info
 */
@Data
@NoArgsConstructor
public class UserInterfaceInfo implements Serializable {
    /**
     * 主键
     */
    private Long id;

    public UserInterfaceInfo(Long userId, Long interfaceInfoId) {
        this.userId = userId;
        this.interfaceInfoId = interfaceInfoId;
    }

    public UserInterfaceInfo(Long userId, Long interfaceInfoId, Integer totalNum, Integer leftNum) {
        this.userId = userId;
        this.interfaceInfoId = interfaceInfoId;
        this.totalNum = totalNum;
        this.leftNum = leftNum;
    }

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

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 是否删除(0-未删, 1-已删)
     */
    private Integer isDelete;

    private static final long serialVersionUID = 1L;
}