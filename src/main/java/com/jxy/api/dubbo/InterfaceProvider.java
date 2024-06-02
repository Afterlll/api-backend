package com.jxy.api.dubbo;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jxy.api.mapper.InterfaceInfoMapper;
import com.jxy.apicommon.dubbo.InterfaceInfoService;
import com.jxy.apicommon.model.dto.InterfaceInfoQueryRequest;
import com.jxy.apicommon.model.entity.InterfaceInfo;
import org.apache.dubbo.config.annotation.DubboService;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 13547
* @description 针对表【interface_info(接口信息)】的数据库操作Service实现
* @createDate 2024-05-26 21:54:18
*/
@DubboService
public class InterfaceProvider implements InterfaceInfoService {

    @Resource
    private com.jxy.api.service.InterfaceInfoService interfaceInfoService;
    @Resource
    private InterfaceInfoMapper interfaceInfoMapper;

    @Override
    public InterfaceInfo queryByDTO(InterfaceInfoQueryRequest dto) {
        Long id = dto.getId();
        String url = dto.getUri();
        String method = dto.getMethod();
        QueryWrapper<InterfaceInfo> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", id)
                    .like("url", url)
                    .eq("status", 1)
                    .eq("method", method.toUpperCase());
        return interfaceInfoService.getOne(queryWrapper);
    }

    @Override
    public List<InterfaceInfo> queryList() {
        return interfaceInfoMapper.selectList(null);
    }
}
