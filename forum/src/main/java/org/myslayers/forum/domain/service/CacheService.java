package org.myslayers.forum.domain.service;

import org.myslayers.forum.common.enums.CacheBizTypeEn;

public interface CacheService {

    /**
     * 存储
     */
    boolean set(CacheBizTypeEn bizType, String key, String value);

    /**
     * 存储并设置超时时长(单位:秒)
     */
    boolean setAndExpire(CacheBizTypeEn bizType, String key, String value, Long seconds);

    /**
     * 获取值
     */
    String get(CacheBizTypeEn bizType, String key);

    /**
     * 判断是否存在
     */
    Boolean exists(CacheBizTypeEn bizType, String key);

    /**
     * 删除
     */
    Boolean del(CacheBizTypeEn bizType, String key);

}
