package com.jxy.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jxy.api.common.ErrorCode;
import com.jxy.api.exception.BusinessException;
import com.jxy.api.model.entity.UserInterfaceInfo;
import com.jxy.api.service.UserInterfaceInfoService;
import com.jxy.api.mapper.UserInterfaceInfoMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
* @author 13547
* @description 针对表【user_interface_info(用户调用接口关系)】的数据库操作Service实现
* @createDate 2024-05-26 21:54:18
*/
@Service
public class UserInterfaceInfoServiceImpl extends ServiceImpl<UserInterfaceInfoMapper, UserInterfaceInfo>
    implements UserInterfaceInfoService{

    @Override
    public void validUserInterfaceInfo(UserInterfaceInfo userInterfaceInfo, boolean add) {
        if (userInterfaceInfo == null) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        // 创建时，所有参数必须非空
        if (add) {
            if (null == userInterfaceInfo.getUserId() || null == userInterfaceInfo.getInterfaceInfoId()) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR, "用户id或接口id为空");
            }
        }
        if (userInterfaceInfo.getLeftNum() < 0 || userInterfaceInfo.getTotalNum() < 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "接口剩下的调用次数不足");
        }
    }

    /**
     * 调用接口统计
     * @param interfaceInfoId
     * @param userId
     * @return
     */
    @Override
    @Transactional
    // todo 添加分布式锁
    public boolean invokeCount(long interfaceInfoId, long userId) {
        if (interfaceInfoId <= 0 || userId <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "接口id错误或者用户id错误");
        }
        // 查询出对应的记录信息
        UserInterfaceInfo userInterfaceInfo = this.lambdaQuery()
                .eq(UserInterfaceInfo::getInterfaceInfoId, interfaceInfoId)
                .eq(UserInterfaceInfo::getUserId, userId)
                .one();
        if (null == userInterfaceInfo) {
            // 插入数据
            return this.save(new UserInterfaceInfo(userId, interfaceInfoId, 0, 0));
        } else {
            // 统计次数
            UpdateWrapper<UserInterfaceInfo> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("interfaceInfoId", interfaceInfoId)
                    .eq("userId", userId)
                    .gt("leftNum", 0)
                    .eq("leftNum", userInterfaceInfo.getLeftNum())
                    .eq("totalNum", userInterfaceInfo.getTotalNum())
                    .setSql("leftNum = leftNum - 1, totalNum = totalNum + 1");
            return this.update(updateWrapper);
        }
    }
}




