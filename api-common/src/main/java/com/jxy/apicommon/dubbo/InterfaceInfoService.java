package com.jxy.apicommon.dubbo;


import com.jxy.apicommon.model.dto.InterfaceInfoQueryRequest;
import com.jxy.apicommon.model.entity.InterfaceInfo;

import java.util.List;

/**
 * 接口 dubbo公共接口
 */
public interface InterfaceInfoService {

    /**
     * 根据 dto 查询出对应的接口信息
     * @param dto
     * @return
     */
    InterfaceInfo queryByDTO(InterfaceInfoQueryRequest dto);

    /**
     * 查询出所有的接口数据
     * @return
     */
    List<InterfaceInfo> queryList();
}
