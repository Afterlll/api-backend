package com.jxy.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jxy.api.common.ErrorCode;
import com.jxy.api.exception.BusinessException;
import com.jxy.api.mapper.InterfaceInfoMapper;
import com.jxy.api.mapper.UserInterfaceInfoMapper;
import com.jxy.api.model.entity.InterfaceStatistic;
import com.jxy.api.service.UserInterfaceInfoService;
import com.jxy.apicommon.model.entity.UserInterfaceInfo;
import org.redisson.RedissonRateLimiter;
import org.redisson.api.RLock;
import org.redisson.api.RScoredSortedSet;
import org.redisson.api.RedissonClient;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
* @author 13547
* @description 针对表【user_interface_info(用户调用接口关系)】的数据库操作Service实现
* @createDate 2024-05-26 21:54:18
*/
@Service
public class UserInterfaceInfoServiceImpl extends ServiceImpl<UserInterfaceInfoMapper, UserInterfaceInfo>
    implements UserInterfaceInfoService{

    @Resource
    private UserInterfaceInfoMapper userInterfaceInfoMapper;
    @Resource
    private InterfaceInfoMapper interfaceInfoMapper;
    @Resource
    private RedissonClient redissonClient;

    public static final String INVOKE_COUNT_KEY = "userInterface:invokeCount";

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
//    @Transactional
    // todo 添加分布式锁
    public boolean invokeCount(long interfaceInfoId, long userId) {
        if (interfaceInfoId <= 0 || userId <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "接口id错误或者用户id错误");
        }

        return redissonInvokeCount(interfaceInfoId, userId);
    }

    // 分布式锁实现
    private boolean redissonInvokeCount(long interfaceInfoId, long userId) {
        RLock lock = redissonClient.getLock(INVOKE_COUNT_KEY + ":" + userId + ":" + interfaceInfoId);
        try {
            if (!lock.tryLock(1, 5, TimeUnit.MINUTES)) {
                throw new BusinessException(ErrorCode.OPERATION_ERROR, "操作繁忙，请稍后再试！");
            }
            // 查询出对应的记录信息
            UserInterfaceInfo userInterfaceInfo = this.lambdaQuery()
                    .eq(UserInterfaceInfo::getInterfaceInfoId, interfaceInfoId)
                    .eq(UserInterfaceInfo::getUserId, userId)
                    .one();
            if (null == userInterfaceInfo) {
                // 插入数据
                return this.save(new UserInterfaceInfo(userId, interfaceInfoId, 1, 10000));
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
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "接口统计失败！");
        } finally {
            lock.unlock();
        }
    }

    /**
     * zset实现，在判断是否没有调用次数需要走redis
     * @param interfaceInfoId
     * @param userId
     * @return
     */
    private boolean zsetInvokeCount(long interfaceInfoId, long userId) {
        RLock lock = redissonClient.getLock(INVOKE_COUNT_KEY + ":" + userId + ":" + interfaceInfoId);
        try {
            if (!lock.tryLock(1, 5, TimeUnit.MINUTES)) {
                throw new BusinessException(ErrorCode.OPERATION_ERROR, "操作繁忙，请稍后再试！");
            }

            // 使用 ZSet 存储数据
            RScoredSortedSet<String> zset = redissonClient.getScoredSortedSet(INVOKE_COUNT_KEY);
            String memberId = userId + ":" + interfaceInfoId;
            Double currentLeftNum = zset.getScore(memberId);

            if (null == currentLeftNum) {
                // 如果不存在，说明是首次调用，插入数据
                zset.add(0L, memberId);
                return true;
            } else {
                // 如果存在，更新数据
                if (currentLeftNum > 0) {
                    // 减少 leftNum 并增加 totalNum
                    zset.addScore(memberId, -1);
                    zset.addScore(INVOKE_COUNT_KEY + "_total", 1);
                    return true;
                } else {
                    // 如果 leftNum 已经为 0，不允许再调用
                    throw new BusinessException(ErrorCode.OPERATION_ERROR, "接口调用次数已用完");
                }
            }
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "接口统计失败！");
        } finally {
            lock.unlock();
        }
    }

    /**
     * 获取接口总调用次数前TOP limit
     * @return
     */
    @Override
    public List<InterfaceStatistic> listInvokeCount(int limit) {
        return userInterfaceInfoMapper.listInvokeCount(limit);
    }
}




