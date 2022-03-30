package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.myslayers.forum.common.enums.*;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.BasePosts;
import org.myslayers.forum.domain.entity.Comment;
import org.myslayers.forum.domain.entity.Message;
import org.myslayers.forum.domain.entity.value.IdValue;
import org.myslayers.forum.domain.repository.CommentRepository;
import org.myslayers.forum.domain.repository.MessageRepository;
import org.myslayers.forum.domain.repository.PostsRepository;

import javax.annotation.Resource;
import java.util.Map;

@Component
public class MessageCommentCreateListener extends EventBus.EventHandler<Map<String, Object>> {

    @Resource
    private MessageRepository messageRepository;

    @Resource
    private PostsRepository postsRepository;

    @Resource
    private CommentRepository commentRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.COMMENT_CREATE;
    }

    @Override
    public void onMessage(Map<String, Object> msg) {
        Long sender = Long.valueOf(msg.get("commenter").toString());
        Comment comment = (Comment) msg.get("comment");

        BasePosts basePosts = postsRepository.get(comment.getPostsId());
        if (ObjectUtils.isEmpty(basePosts)) {
            return;
        }

        // 通知帖子作者
        saveCommentMessage(basePosts.getCategory(), basePosts.getId(), basePosts.getAuthorId(), sender);

        // 通知被回复人
        if (!ObjectUtils.isEmpty(comment.getReplyId())) {
            Comment reply = commentRepository.get(comment.getReplyId());
            if (!ObjectUtils.isEmpty(reply)) {
                saveCommentMessage(basePosts.getCategory(), basePosts.getId(), reply.getUserId(), sender);
            }
        }

        // 通知评论人
        if (!ObjectUtils.isEmpty(comment.getReplyReplyId())) {
            Comment replyReply = commentRepository.get(comment.getReplyReplyId());
            if (!ObjectUtils.isEmpty(replyReply)) {
                saveCommentMessage(basePosts.getCategory(), basePosts.getId(), replyReply.getUserId(), sender);
            }
        }
    }

    private void saveCommentMessage(PostsCategoryEn categoryEn, Long postsId, Long receiver, Long sender) {
        Message message = Message.builder()
                .channel(MessageChannelEn.STATION_LETTER)
                .receiver(IdValue.builder()
                        .id(receiver.toString())
                        .type(IdValueTypeEn.USER_ID)
                        .build())
                .read(MessageReadEn.NO)
                .contentType(MessageContentTypeEn.TEXT)
                .title(postsId.toString())
                .content("")
                .sender(IdValue.builder()
                        .id(sender.toString())
                        .type(IdValueTypeEn.USER_ID)
                        .build())
                .build();

        if (PostsCategoryEn.ARTICLE.equals(categoryEn)) {
            message.setType(MessageTypeEn.COMMENT_ARTICLE);
        } else if (PostsCategoryEn.FAQ.equals(categoryEn)) {
            message.setType(MessageTypeEn.COMMENT_FAQ);
        } else {
            return;
        }

        messageRepository.save(message);
    }
}
