package com.jxy.api.service;

import com.jxy.api.model.entity.LoveQuotes;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 13547
* @description 针对表【love_quotes】的数据库操作Service
* @createDate 2024-06-03 14:00:58
*/
public interface LoveQuotesService extends IService<LoveQuotes> {
    /**
     * 随机返回一条土味情话
     * @return
     */
    LoveQuotes randomQuotes();
}
