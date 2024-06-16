package com.jxy.api.mapper;

import com.jxy.api.model.entity.LoveQuotes;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
* @author 13547
* @description 针对表【love_quotes】的数据库操作Mapper
* @createDate 2024-06-03 14:00:58
* @Entity com.jxy.api.model.entity.LoveQuotes
*/
public interface LoveQuotesMapper extends BaseMapper<LoveQuotes> {
    /**
     * 随机返回一条土味情话
     * @return
     */
    LoveQuotes randomQuotes();
}




