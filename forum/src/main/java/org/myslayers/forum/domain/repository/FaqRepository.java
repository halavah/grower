package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Faq;
import org.myslayers.forum.domain.entity.value.PostsPageQueryValue;

import java.util.List;


public interface FaqRepository {

    void save(Faq faq);

    void update(Faq faq);

    void updateEntity(Faq faq);

    Faq get(Long id);

    PageResult<Faq> page(Integer pageNo, Integer pageSize, PostsPageQueryValue pageQueryValue);

    List<Faq> hots(int size);

}
