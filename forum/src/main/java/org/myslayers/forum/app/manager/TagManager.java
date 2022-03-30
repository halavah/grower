package org.myslayers.forum.app.manager;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.tag.TagCreateRequest;
import org.myslayers.forum.api.request.tag.TagPageRequest;
import org.myslayers.forum.api.response.tag.TagPageResponse;
import org.myslayers.forum.api.response.tag.TagQueryResponse;
import org.myslayers.forum.api.vo.PostsVO;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.app.support.PageUtil;
import org.myslayers.forum.app.transfer.TagTransfer;
import org.myslayers.forum.common.enums.AuditStateEn;
import org.myslayers.forum.common.enums.CacheBizTypeEn;
import org.myslayers.forum.common.enums.ErrorCodeEn;
import org.myslayers.forum.common.enums.UserRoleEn;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.common.support.CheckUtil;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.Posts;
import org.myslayers.forum.domain.entity.Tag;
import org.myslayers.forum.domain.repository.TagRepository;
import org.myslayers.forum.domain.service.CacheService;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class TagManager extends AbstractPostsManager {

    @Resource
    private TagRepository tagRepository;

    @Resource
    private CacheService cacheService;

    private static final String ALL_USED_TAG_CACHE_KEY = "all_used_tag";

    private static final Long TAG_CACHE_EXPIRE_SECOND = 60 * 60L;

    @IsLogin(role = UserRoleEn.ADMIN)
    public void create(TagCreateRequest request) {
        CheckUtil.isNotEmpty(tagRepository.query(Tag.builder().name(request.getName()).build()), ErrorCodeEn.TAG_IS_EXIST);

        tagRepository.save(TagTransfer.toTag(request));
    }

    public List<TagQueryResponse> queryAll() {
        return TagTransfer.toTagQueryAllResponses(tagRepository.queryByState(AuditStateEn.PASS));
    }

    public List<TagQueryResponse> queryInIds(Set<Long> ids) {
        List<Tag> tags = tagRepository.queryByIds(ids);

        return TagTransfer.toTagQueryAllResponses(SafesUtil.ofList(tags).stream()
                .filter(tag -> AuditStateEn.PASS.equals(tag.getAuditState()))
                .collect(Collectors.toList()));
    }

    public TagQueryResponse getByName(String name) {
        Tag tag = tagRepository.getByNameAndState(name, AuditStateEn.PASS);
        CheckUtil.isEmpty(tag, ErrorCodeEn.TAG_NOT_EXIST);

        return TagTransfer.toTagQueryAllResponse(tag);
    }

    public PageResponseModel<PostsVO> pagePosts(PageRequestModel<Long> pageRequestModel) {
        PageResult<Posts> pageResult = tagRepository.pagePosts(PageUtil.buildPageRequest(pageRequestModel, pageRequestModel.getFilter()));

        return pagePostsVO(pageResult);
    }

    public PageResponseModel<PostsVO> pagePostsByTagIds(PageRequestModel<Set<Long>> pageRequestModel) {
        PageResult<Posts> pageResult = tagRepository.pagePostsByTagIds(PageUtil.buildPageRequest(pageRequestModel, pageRequestModel.getFilter()));

        return pagePostsVO(pageResult);
    }

    @IsLogin(role = UserRoleEn.ADMIN)
    public PageResponseModel<TagPageResponse> page(PageRequestModel<TagPageRequest> pageRequestModel) {
        TagPageRequest tagPageRequest = pageRequestModel.getFilter();
        Tag tag = Tag.builder()
                .groupName(tagPageRequest.getGroupName())
                .name(tagPageRequest.getName())
                .description(tagPageRequest.getDescription())
                .build();
        if (!ObjectUtils.isEmpty(tagPageRequest.getAuditState())) {
            tag.setAuditState(AuditStateEn.getEntity(tagPageRequest.getAuditState()));
        }

        PageResult<Tag> pageResult = tagRepository.page(PageUtil.buildPageRequest(pageRequestModel, tag));

        return PageResponseModel.build(pageResult.getTotal(), pageResult.getSize(), TagTransfer.toTagPageResponses(pageResult.getList()));
    }

    @IsLogin(role = UserRoleEn.ADMIN)
    public void tagAuditState(AdminBooleanRequest booleanRequest) {
        Tag tag = tagRepository.get(booleanRequest.getId());
        CheckUtil.isEmpty(tag, ErrorCodeEn.TAG_NOT_EXIST);

        tag.setAuditState(booleanRequest.getIs() ? AuditStateEn.PASS : AuditStateEn.REJECT);
        tagRepository.update(tag);
    }

    public List<TagQueryResponse> queryAllRef() {
        String cache = cacheService.get(CacheBizTypeEn.TAG_USED, ALL_USED_TAG_CACHE_KEY);

        List<Tag> cacheTags;
        if (ObjectUtils.isEmpty(cache)) {
            List<Tag> tags = tagRepository.queryByState(AuditStateEn.PASS);
            cacheTags = SafesUtil.ofList(tags).stream().filter(tag -> tag.getRefCount() > 0).collect(Collectors.toList());
            cacheService.setAndExpire(CacheBizTypeEn.TAG_USED, ALL_USED_TAG_CACHE_KEY, JSON.toJSONString(cacheTags), TAG_CACHE_EXPIRE_SECOND);
        } else {
            cacheTags = JSON.parseArray(cache, Tag.class);
        }

        return TagTransfer.toTagQueryAllResponses(cacheTags);
    }
}
