package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.model.PageRequest;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.OptLog;

public interface OptLogRepository {

    void save(OptLog optLog);

    PageResult<OptLog> page(PageRequest<OptLog> pageRequest);
}
