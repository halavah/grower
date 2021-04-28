package org.myslayers.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;
import lombok.Data;

@Data
public class BaseEntity {

    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 创建日期
     */
    @JsonFormat(pattern="yyyy-MM-dd")
    private Date created;

    /**
     * 更新日期
     */
    @JsonFormat(pattern="yyyy-MM-dd")
    private Date modified;
}