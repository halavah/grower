package org.myslayers.forum.infrastructure.dal.dao;

import org.myslayers.forum.infrastructure.dal.dataobject.OptLogDO;

import java.util.List;


public interface OptLogDAO {

    void insert(OptLogDO optLogDO);

    List<OptLogDO> query(OptLogDO optLogDO);
}
