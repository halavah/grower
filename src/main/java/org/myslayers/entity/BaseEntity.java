package org.myslayers.entity;

import java.util.Date;
import lombok.Data;

@Data
public class BaseEntity {

    private Long id;

    private Date created;

    private Date modified;

}




