package org.myslayers.search.model;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

/**
 * Elasticsearch：实体类，类似MySQL表
 */
@Data
//indexName代表索引名称，type代表post类型，createIndex代表”启动时，是否创建该文档，默认为true“
@Document(indexName="post", type="post", createIndex=true)
public class PostDocment implements Serializable {

    //主键ID
    @Id
    private Long id;

    //文章的【标题title】
    //ik分词器：文本Text、最粗粒度的拆分ik_smart、最细粒度的拆分ik_max_word
    @Field(type = FieldType.Text, searchAnalyzer="ik_smart", analyzer = "ik_max_word")
    private String title;

    //文章的【作者id】
    @Field(type = FieldType.Long)
    private Long authorId;

    //文章的【作者name】
    @Field(type = FieldType.Keyword)
    private String authorName;

    //文章的【作者avatar】
    private String authorAvatar;

    //文章的【分类id】
    private Long categoryId;

    //文章的【分类name】
    @Field(type = FieldType.Keyword)
    private String categoryName;

    //文章的【置顶等级】
    private Integer level;

    //文章的【精华】
    private Boolean recomment;

    //文章的【评论数量】
    private Integer commentCount;

    //文章的【访问量】
    private Integer viewCount;

    //文章的【创建日期】
    @Field(type = FieldType.Date)
    private Date created;
}
