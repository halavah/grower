package org.myslayers.forum.infrastructure.dal.dao;

import org.apache.ibatis.annotations.Param;
import org.myslayers.forum.infrastructure.dal.dataobject.ConfigDO;

import java.util.Date;
import java.util.List;
import java.util.Set;

public interface ConfigDAO {

    /**
     * 插入
     */
    void insert(ConfigDO configDO);

    /**
     * 更新
     */
    void update(ConfigDO configDO);

    /**
     * 查询
     */
    ConfigDO get(Long id);

    /**
     * 查询
     */
    List<ConfigDO> query(ConfigDO configDO);

    /**
     * 查询可用
     */
    List<ConfigDO> queryAvailable(@Param("types") Set<String> types,
                                  @Param("nowDate") Date nowDate,
                                  @Param("state") String state);

}
