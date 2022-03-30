package org.myslayers.forum.infrastructure.dal.dao;

import org.apache.ibatis.annotations.Param;
import org.myslayers.forum.infrastructure.dal.dataobject.CacheDO;

import java.util.List;
import java.util.Set;

public interface CacheDAO {

    void insertBatch(List<CacheDO> cacheDOS);

    void insert(CacheDO cacheDO);

    List<CacheDO> getAll();

    void batchDeleteByKeys(@Param("keys") Set<String> keys);

    void updateByKey(@Param("key") String key, @Param("value") String value);

}