package com.jxy.apicommon.dubbo;

import com.jxy.apicommon.model.entity.User;

/**
 * 用户服务dubbo 接口
 *
 * @author jxy
 */
public interface UserService {
    /**
     * 根据用户id查询出用户信息
     * @param userId
     * @return
     */
    User queryById(long userId);
}
