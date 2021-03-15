package org.myslayers.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.util.ArrayList;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.index.query.MultiMatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.modelmapper.ModelMapper;
import org.myslayers.search.model.PostDocment;
import org.myslayers.search.repository.PostRepository;
import org.myslayers.service.PostService;
import org.myslayers.service.SearchService;
import org.myslayers.vo.PostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class SearchServiceImpl implements SearchService {

    @Autowired
    PostRepository postRepository;

    @Autowired
    PostService postService;

    /**
     * ES：search 搜索
     */
    @Override
    public IPage search(Page page, String keyword) {
        //1.将MP-page -> 转换为 JPA-page
        Long current = page.getCurrent() - 1;
        Long size = page.getSize();
        Pageable pageable = PageRequest.of(current.intValue(), size.intValue());

        //2.使用ES -> 得到 pageData数据
        MultiMatchQueryBuilder multiMatchQueryBuilder = QueryBuilders.multiMatchQuery(keyword, "title", "authorName", "categoryName");
        org.springframework.data.domain.Page<PostDocment> docments = postRepository.search(multiMatchQueryBuilder, pageable);

        //3.将JPA-page -> 转换为 MP-page
        IPage pageData = new Page(page.getCurrent(), page.getSize(), docments.getTotalElements());
        pageData.setRecords(docments.getContent());
        return pageData;
    }

    /**
     * ES：initEsData 初始化数据
     */
    @Override
    public int initEsData(List<PostVo> records) {
        if(records == null || records.isEmpty()) {
            return 0;
        }

        //将List<PostVo> -> List<PostDocment>
        List<PostDocment> documents = new ArrayList<>();
        for(PostVo vo : records) {
            //转换操作：将source映射到destinationType的实例，map(Object source, Class<D> destinationType)
            PostDocment postDocment = new ModelMapper().map(vo, PostDocment.class);
            documents.add(postDocment);
        }
        postRepository.saveAll(documents);
        return documents.size();
    }

//    /**
//     * ES：createOrUpdateIndex 创建/更新索引
//     */
//    @Override
//    public void createOrUpdateIndex(PostMqIndexMessage message) {
//        Long postId = message.getPostId();
//        PostVo postVo = postService.selectOnePost(new QueryWrapper<Post>().eq("p.id", postId));
//
//        PostDocment postDocment = modelMapper.map(postVo, PostDocment.class);
//
//        postRepository.save(postDocment);
//
//        log.info("es 索引更新成功！ ---> {}", postDocment.toString());
//    }
//
//    /**
//     * ES：removeIndex 移除索引
//     */
//    @Override
//    public void removeIndex(PostMqIndexMessage message) {
//        Long postId = message.getPostId();
//
//        postRepository.deleteById(postId);
//        log.info("es 索引删除成功！ ---> {}", message.toString());
//    }
}
