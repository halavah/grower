package org.myslayers.forum.domain.entity;

import lombok.Data;

import java.util.Date;

@Data
public abstract class BaseEntity {

    private Long id;
    
    private Date createAt;
    
    private Date updateAt;

}
