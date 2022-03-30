package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.enums.ArticleTypeScopeEn;
import org.myslayers.forum.common.enums.AuditStateEn;
import org.myslayers.forum.common.model.PageRequest;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.ArticleType;

import java.util.List;

public interface ArticleTypeRepository {

    void save(ArticleType articleType);

    List<ArticleType> query(ArticleType articleType);

    List<ArticleType> queryByState(AuditStateEn auditState);

    List<ArticleType> queryByScopesAndState(List<ArticleTypeScopeEn> scopes, AuditStateEn auditState);

    void update(ArticleType articleType);

    ArticleType get(Long id);

    ArticleType getByNameAndState(String typeName, AuditStateEn pass);

    void increaseRefCount(Long id);

    void decreaseRefCount(Long id);

    PageResult<ArticleType> page(PageRequest<ArticleType> articleTypePageRequest);
}
