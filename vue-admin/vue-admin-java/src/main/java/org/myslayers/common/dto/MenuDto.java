package org.myslayers.common.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
public class MenuDto implements Serializable {
    private Integer id;
    private Long parentId;
    private String title;
    private String name;
    private String path;
    private String icon;
    private String perms;
    private String component;
    private Integer sorted;
    private Integer type;
    private Integer status;
    private Date created;
    private Date modified;
    private List<MenuDto> children = new ArrayList<MenuDto>();
}