package org.myslayers.forum.app.manager;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.vo.PostsVO;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.app.support.LoginUserContext;
import org.myslayers.forum.app.transfer.PostsTransfer;
import org.myslayers.forum.common.enums.AuditStateEn;
import org.myslayers.forum.common.enums.ErrorCodeEn;
import org.myslayers.forum.common.enums.UserRoleEn;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.common.support.CheckUtil;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.BasePosts;
import org.myslayers.forum.domain.entity.Comment;
import org.myslayers.forum.domain.entity.Posts;
import org.myslayers.forum.domain.entity.Tag;
import org.myslayers.forum.domain.repository.CommentRepository;
import org.myslayers.forum.domain.repository.PostsRepository;
import org.myslayers.forum.domain.repository.TagRepository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public abstract class AbstractPostsManager {

    @Resource
    TagRepository tagRepository;

    @Resource
    PostsRepository postsRepository;

    @Resource
    CommentRepository commentRepository;

    Set<Tag> checkTags(Set<Long> tagIds) {
        List<Tag> tags = tagRepository.queryByIds(tagIds);
        Set<Tag> selectTags = SafesUtil.ofList(tags).stream()
                .filter(tag -> AuditStateEn.PASS.equals(tag.getAuditState()))
                .collect(Collectors.toSet());
        CheckUtil.isEmpty(selectTags, ErrorCodeEn.TAG_NOT_EMPTY);

        return selectTags;
    }

    PageResponseModel<PostsVO> pagePostsVO(PageResult<Posts> pageResult) {
        Set<Long> solutionIds = SafesUtil.ofList(pageResult.getList()).stream()
                .filter(posts -> !ObjectUtils.isEmpty(posts.getSolutionId()) && posts.getSolutionId() != 0L)
                .map(Posts::getSolutionId).collect(Collectors.toSet());

        if (ObjectUtils.isEmpty(solutionIds)) {
            return PageResponseModel.build(pageResult.getTotal(), pageResult.getSize(), PostsTransfer.toPostsVOs(pageResult.getList(), new ArrayList<>()));
        }

        List<Comment> comments = commentRepository.queryInIds(solutionIds);
        if (ObjectUtils.isEmpty(comments)) {
            return PageResponseModel.build(pageResult.getTotal(), pageResult.getSize(), PostsTransfer.toPostsVOs(pageResult.getList(), new ArrayList<>()));
        }

        return PageResponseModel.build(pageResult.getTotal(), pageResult.getSize(), PostsTransfer.toPostsVOs(pageResult.getList(), comments));
    }

    @IsLogin
    @Transactional
    public void delete(Long id) {
        BasePosts basePosts = postsRepository.get(id);
        CheckUtil.isEmpty(basePosts, ErrorCodeEn.POSTS_NOT_EXIST);
        CheckUtil.isFalse(LoginUserContext.getUser().getId().equals(basePosts.getAuthorId()), ErrorCodeEn.POSTS_NOT_EXIST);

        tagRepository.deletePostsMapping(id);
        commentRepository.deleteByPostsId(id);
        postsRepository.delete(id);
        EventBus.emit(EventBus.Topic.POSTS_DELETE, basePosts);
    }

    @IsLogin(role = UserRoleEn.ADMIN)
    public void auditState(AdminBooleanRequest booleanRequest) {
        BasePosts basePosts = postsRepository.get(booleanRequest.getId());
        CheckUtil.isEmpty(basePosts, ErrorCodeEn.ARTICLE_NOT_EXIST);

        basePosts.setAuditState(booleanRequest.getIs() ? AuditStateEn.PASS : AuditStateEn.REJECT);
        postsRepository.update(basePosts);
    }
}
