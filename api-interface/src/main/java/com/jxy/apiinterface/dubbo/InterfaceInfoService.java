package com.jxy.apiinterface.dubbo;


import com.jxy.apiinterface.model.dto.InterfaceInfoQueryRequest;
import com.jxy.apiinterface.model.entity.InterfaceInfo;

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
}
