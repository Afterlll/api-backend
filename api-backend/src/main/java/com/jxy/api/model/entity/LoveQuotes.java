package com.jxy.api.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 
 * @TableName love_quotes
 */
@TableName(value ="love_quotes")
@Data
public class LoveQuotes implements Serializable {
    /**
     * 自增 ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 情话内容
     */
    private String quote;

    /**
     * 情话分类
     */
    private String category;

    /**
     * 情感倾向
     */
    private String sentiment;

    /**
     * 情感标签
     */
    private String emotion;

    /**
     * 作者
     */
    private String author;

    /**
     * 点赞数
     */
    private Integer likes;

    /**
     * 收藏数
     */
    private Integer favorites;

    /**
     * 创建时间
     */
    private Date createtime;

    /**
     * 更新时间
     */
    private Date updatetime;

    /**
     * 是否删除(0-未删, 1-已删)
     */
    private Integer isdelete;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}