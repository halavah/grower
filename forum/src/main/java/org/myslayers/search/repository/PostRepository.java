package org.myslayers.search.repository;

import org.myslayers.search.model.PostDocment;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

/**
 * PostRepository：继承ElasticsearchRepository
 */
@Repository
public interface PostRepository extends ElasticsearchRepository<PostDocment, Long> {
    // 符合jpa命名规范的接口
    // ...
}
