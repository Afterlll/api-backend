package com.jxy.apicommon.dubbo;

import com.jxy.apicommon.model.dto.UserInterfaceInfoQueryRequest;
import com.jxy.apicommon.model.entity.UserInterfaceInfo;

/**
* 用户调用接口关系 dubbo公共接口
*/
public interface UserInterfaceInfoService {

    /**
     * 调用接口统计
     * @param interfaceInfoId
     * @param userId
     * @return
     */
    boolean invokeCount(long interfaceInfoId, long userId);

    /**
     * 根据dto查询对应的用户-接口记录信息
     * @return
     */
    UserInterfaceInfo queryByDTO(UserInterfaceInfoQueryRequest dto);

}
