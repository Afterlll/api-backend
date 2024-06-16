package com.jxy.api.mapper;

import com.jxy.api.model.entity.InterfaceStatistic;
import com.jxy.apicommon.model.entity.UserInterfaceInfo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author 13547
* @description 针对表【user_interface_info(用户调用接口关系)】的数据库操作Mapper
* @createDate 2024-05-26 21:54:18
* @Entity com.jxy.api.model.entity.UserInterfaceInfo
*/
public interface UserInterfaceInfoMapper extends BaseMapper<UserInterfaceInfo> {
    /**
     * 获取接口总调用次数前TOP limit
     * @return
     */
    List<InterfaceStatistic> listInvokeCount(int limit);
}




