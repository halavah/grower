package org.myslayers.forum.app.transfer;


import org.myslayers.forum.api.request.comment.CommentCreateRequest;
import org.myslayers.forum.api.response.comment.CommentPageResponse;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.Comment;
import org.myslayers.forum.domain.entity.User;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.stream.Collectors;


public class CommentTransfer {

    public static Comment toComment(CommentCreateRequest request, User user) {
        return Comment.builder()
                .content(request.getContent())
                .postsId(request.getPostsId())
                .replyId(request.getReplyId())
                .userId(user.getId())
                .build();
    }

    public static List<CommentPageResponse> toCommentPageResponses(List<Comment> comments, List<User> users, Boolean isReply) {
        return SafesUtil.ofList(comments).stream().map(comment -> {
            CommentPageResponse.Commentator.CommentatorBuilder commentatorBuilder = CommentPageResponse.Commentator.builder();
            buildCommentator(commentatorBuilder, users, comment.getUserId());

            CommentPageResponse.Commentator.CommentatorBuilder respondentBuilder = CommentPageResponse.Commentator.builder();
            if (isReply && !ObjectUtils.isEmpty(comment.getReplyReplyId())) {
                SafesUtil.ofList(comments).forEach(articleCommentDO1 -> {
                    if (comment.getReplyReplyId().equals(articleCommentDO1.getId())) {
                        buildCommentator(respondentBuilder, users, articleCommentDO1.getUserId());
                    }
                });
            }
            return CommentPageResponse.builder()
                    .id(comment.getId())
                    .createAt(comment.getCreateAt())
                    .content(comment.getContent())
                    .commentator(commentatorBuilder.build())
                    .respondent(respondentBuilder.build())
                    .replyId(isReply ? comment.getReplyId() : null)
                    .build();
        }).collect(Collectors.toList());
    }

    private static void buildCommentator(CommentPageResponse.Commentator.CommentatorBuilder commentatorBuilder, List<User> users, Long uid) {
        SafesUtil.ofList(users).forEach(user -> {
            if (uid.equals(user.getId())) {
                commentatorBuilder.id(user.getId())
                        .nickname(user.getNickname())
                        .avatar(user.getAvatar());
            }
        });
    }
}
