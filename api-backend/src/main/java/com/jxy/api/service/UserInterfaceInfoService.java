package com.jxy.api.service;

import com.jxy.api.model.entity.InterfaceStatistic;
import com.jxy.api.model.vo.InterfaceInfoVo;
import com.jxy.apicommon.model.entity.UserInterfaceInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author 13547
* @description 针对表【user_interface_info(用户调用接口关系)】的数据库操作Service
* @createDate 2024-05-26 21:54:18
*/
public interface UserInterfaceInfoService extends IService<UserInterfaceInfo> {

    void validUserInterfaceInfo(UserInterfaceInfo userInterfaceInfo, boolean add);

    /**
     * 调用接口统计
     * @param interfaceInfoId
     * @param userId
     * @return
     */
    boolean invokeCount(long interfaceInfoId, long userId);

    /**
     * 获取接口总调用次数前TOP limit
     * @return
     */
    List<InterfaceStatistic> listInvokeCount(int limit);

}
