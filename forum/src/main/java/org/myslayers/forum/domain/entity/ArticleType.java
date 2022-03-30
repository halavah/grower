package org.myslayers.forum.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.myslayers.forum.common.enums.ArticleTypeScopeEn;
import org.myslayers.forum.common.enums.AuditStateEn;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ArticleType extends BaseEntity {
    
    private String name;
    
    private String description;
    
    private Long refCount;
    
    private ArticleTypeScopeEn scope;
    
    private Long creatorId;
    
    private AuditStateEn auditState;

}
