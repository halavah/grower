package org.myslayers.forum.app.transfer;

import org.myslayers.forum.api.vo.PostsVO;
import org.myslayers.forum.api.vo.SolutionVO;
import org.myslayers.forum.api.vo.TagVO;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.Comment;
import org.myslayers.forum.domain.entity.Posts;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PostsTransfer {

    public static List<PostsVO> toPostsVOs(List<Posts> postsList, List<Comment> comments) {
        List<PostsVO> res = new ArrayList<>();

        SafesUtil.ofList(postsList).forEach(posts -> {
            SolutionVO solution = null;
            for (Comment comment : comments) {
                if (comment.getId().equals(posts.getSolutionId())) {
                    solution = SolutionVO.builder()
                            .content(comment.getContent())
                            .id(comment.getId())
                            .build();
                }
            }

            PostsVO postsVO = PostsVO.builder()
                    .category(posts.getCategory().getValue())
                    .categoryDesc(posts.getCategory().getDesc())
                    .authorAvatar(posts.getAuthor().getAvatar())
                    .authorId(posts.getAuthor().getId())
                    .authorNickname(posts.getAuthor().getNickname())
                    .comments(posts.getComments())
                    .createAt(posts.getCreateAt())
                    .headImg(posts.getHeadImg())
                    .id(posts.getId())
                    .introduction(posts.getMarkdownContent())
                    .marrow(posts.getMarrow())
                    .official(posts.getOfficial())
                    .tags(SafesUtil.ofSet(posts.getTags()).stream().map(tag -> {
                        return TagVO.builder()
                                .id(tag.getId())
                                .name(tag.getName())
                                .build();
                    }).collect(Collectors.toList()))
                    .title(posts.getTitle())
                    .top(posts.getTop())
                    .views(posts.getViews())
                    .approvals(posts.getApprovals())
                    .solution(solution)
                    .build();

            res.add(postsVO);
        });

        return res;
    }
}
