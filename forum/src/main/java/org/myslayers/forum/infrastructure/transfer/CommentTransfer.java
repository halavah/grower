package org.myslayers.forum.infrastructure.transfer;

import org.springframework.util.ObjectUtils;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.Comment;
import org.myslayers.forum.infrastructure.dal.dataobject.CommentDO;

import java.util.List;
import java.util.stream.Collectors;

public class CommentTransfer {

    public static CommentDO toCommentDO(Comment comment) {
        CommentDO commentDO = CommentDO.builder()
                .content(comment.getContent())
                .postsId(comment.getPostsId())
                .replyId(comment.getReplyId())
                .replyReplyId(comment.getReplyReplyId())
                .userId(comment.getUserId())
                .build();
        commentDO.setId(comment.getId());
        commentDO.initBase();

        return commentDO;
    }

    public static List<Comment> toComments(List<CommentDO> commentDOs) {
        return SafesUtil.ofList(commentDOs).stream()
                .map(CommentTransfer::toComment)
                .collect(Collectors.toList());
    }

    public static Comment toComment(CommentDO commentDO) {
        if (ObjectUtils.isEmpty(commentDO)) {
            return null;
        }

        Comment comment = Comment.builder()
                .content(commentDO.getContent())
                .postsId(commentDO.getPostsId())
                .replyId(commentDO.getReplyId())
                .replyReplyId(commentDO.getReplyReplyId())
                .userId(commentDO.getUserId())
                .build();
        comment.setId(commentDO.getId());
        comment.setCreateAt(commentDO.getCreateAt());
        comment.setUpdateAt(commentDO.getUpdateAt());

        return comment;
    }
}
