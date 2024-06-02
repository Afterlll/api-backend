package com.jxy.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jxy.api.model.vo.InterfaceInfoVo;
import com.jxy.apicommon.model.entity.InterfaceInfo;

import java.util.List;

/**
 *
 */
public interface InterfaceInfoService extends IService<InterfaceInfo> {

    void validInterfaceInfo(InterfaceInfo interfaceInfo, boolean add);

    /**
     * 获取接口总调用次数前TOP limit
     * @return
     */
    List<InterfaceInfoVo> listInvokeCount(int limit);
}
