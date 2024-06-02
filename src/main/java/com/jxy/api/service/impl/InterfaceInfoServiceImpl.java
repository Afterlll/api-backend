package com.jxy.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jxy.api.common.ErrorCode;
import com.jxy.api.exception.BusinessException;
import com.jxy.api.mapper.InterfaceInfoMapper;
import com.jxy.api.model.entity.InterfaceStatistic;
import com.jxy.api.model.vo.InterfaceInfoVo;
import com.jxy.api.service.UserInterfaceInfoService;
import com.jxy.apicommon.model.entity.InterfaceInfo;
import com.jxy.api.service.InterfaceInfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 接口服务详情
 * @author wangkeyao
 */
@Service
public class InterfaceInfoServiceImpl extends ServiceImpl<InterfaceInfoMapper, InterfaceInfo>
    implements InterfaceInfoService {

    @Resource
    private UserInterfaceInfoService userInterfaceInfoService;
    @Resource
    private InterfaceInfoMapper interfaceInfoMapper;

    @Override
    public void validInterfaceInfo(InterfaceInfo interfaceInfo, boolean add) {
        if (interfaceInfo == null) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        String name = interfaceInfo.getName();
        // 创建时，所有参数必须非空
        if (add) {
            if (StringUtils.isAnyBlank(name)) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR);
            }
        }
        if (StringUtils.isNotBlank(name) && name.length() > 50) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "名称过长");
        }
    }

    /**
     * 获取接口总调用次数前TOP limit
     * @return
     */
    @Override
    public List<InterfaceInfoVo> listInvokeCount(int limit) {
        List<InterfaceStatistic> interfaceStatisticList = userInterfaceInfoService.listInvokeCount(limit);
        Map<Long, InterfaceStatistic> interfaceStatisticMap = interfaceStatisticList.stream().collect(Collectors.toMap(InterfaceStatistic::getInterfaceInfoId, o -> o));
        QueryWrapper<InterfaceInfo> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("id", interfaceStatisticList.stream().map(InterfaceStatistic::getInterfaceInfoId).collect(Collectors.toList()));
        List<InterfaceInfo> interfaceInfoList = interfaceInfoMapper.selectList(queryWrapper);
        return interfaceInfoList.stream().map(interfaceInfo -> {
            InterfaceInfoVo interfaceInfoVo = new InterfaceInfoVo();
            BeanUtils.copyProperties(interfaceStatisticMap.get(interfaceInfo.getId()), interfaceInfoVo);
            BeanUtils.copyProperties(interfaceInfo, interfaceInfoVo);
            return interfaceInfoVo;
        }).collect(Collectors.toList());
    }

}




