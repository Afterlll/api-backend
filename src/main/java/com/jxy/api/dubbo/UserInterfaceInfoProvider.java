package com.jxy.api.dubbo;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jxy.apiinterface.dubbo.UserInterfaceInfoService;
import com.jxy.apiinterface.model.dto.UserInterfaceInfoQueryRequest;
import com.jxy.apiinterface.model.entity.UserInterfaceInfo;
import org.apache.dubbo.config.annotation.DubboService;

import javax.annotation.Resource;

/**
* @author 13547
* @description 针对表【user_interface_info(用户调用接口关系)】的数据库操作Service实现
* @createDate 2024-05-26 21:54:18
*/
@DubboService
public class UserInterfaceInfoProvider implements UserInterfaceInfoService {

    @Resource
    private com.jxy.api.service.UserInterfaceInfoService userInterfaceInfoService;

    /**
     * 调用接口统计
     * @param interfaceInfoId
     * @param userId
     * @return
     */
    public boolean invokeCount(long interfaceInfoId, long userId) {
        return userInterfaceInfoService.invokeCount(interfaceInfoId, userId);
    }

    @Override
    public UserInterfaceInfo queryByDTO(UserInterfaceInfoQueryRequest dto) {
        Long userId = dto.getUserId();
        Long interfaceInfoId = dto.getInterfaceInfoId();
        QueryWrapper<UserInterfaceInfo> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("userId", userId)
                        .eq("interfaceInfoId", interfaceInfoId)
                        .eq("status", 1);
        return userInterfaceInfoService.getOne(queryWrapper);
    }

}
