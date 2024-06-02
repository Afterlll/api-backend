package com.jxy.api.dubbo;

import com.jxy.apicommon.dubbo.UserService;
import com.jxy.apicommon.model.entity.User;
import org.apache.dubbo.config.annotation.DubboService;

import javax.annotation.Resource;

/**
* @author 13547
* @description 针对表【user(用户调用接口关系)】的数据库操作Service实现
* @createDate 2024-05-26 21:54:18
*/
@DubboService
public class UserProvider implements UserService {

    @Resource
    private com.jxy.api.service.UserService userService;

    @Override
    public User queryById(long userId) {
        return userService.getById(userId);
    }
}
