package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.model.PageRequest;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Config;

import java.util.List;
import java.util.Set;

public interface ConfigRepository {

    /**
     * 保存
     */
    void save(Config config);

    /**
     * 查询
     */
    Config get(Long id);

    /**
     * 更新
     */
    void update(Config config);

    /**
     * 根据类型查询可用
     */
    List<Config> queryAvailable(Set<String> types);

    /**
     * 分页查询
     */
    PageResult<Config> page(PageRequest<Config> configPageRequest);
}
