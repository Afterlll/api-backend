package com.jxy.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jxy.apiinterface.model.entity.InterfaceInfo;

/**
 *
 */
public interface InterfaceInfoService extends IService<InterfaceInfo> {

    void validInterfaceInfo(InterfaceInfo interfaceInfo, boolean add);
}
