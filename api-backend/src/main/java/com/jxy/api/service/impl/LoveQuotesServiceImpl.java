package com.jxy.api.service.impl;

import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jxy.api.model.entity.LoveQuotes;
import com.jxy.api.service.LoveQuotesService;
import com.jxy.api.mapper.LoveQuotesMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Set;

/**
* @author 13547
* @description 针对表【love_quotes】的数据库操作Service实现
* @createDate 2024-06-03 14:00:58
*/
@Service
public class LoveQuotesServiceImpl extends ServiceImpl<LoveQuotesMapper, LoveQuotes>
    implements LoveQuotesService{
    @Resource
    private LoveQuotesMapper loveQuotesMapper;
    @Override
    public LoveQuotes randomQuotes() {
        return loveQuotesMapper.randomQuotes();
    }

    public static void main(String[] args) {
        Set<String> set = new HashSet<>();
        for (int i = 0; i < 10000; i++) {
            String result = HttpUtil.get("https://api.uomg.com/api/rand.qinghua");
            JSONObject jsonObject = JSONObject.parseObject(result);
            String o = String.valueOf(jsonObject.get("content"));
            set.add(o);
        }
        for (String s : set) {
            System.out.println("insert into api.love_quotes(quote) values ('"+ s +"');");
        }
    }
}




