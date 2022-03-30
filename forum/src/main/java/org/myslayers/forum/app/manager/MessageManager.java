package org.myslayers.forum.app.manager;

import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.request.message.MessagePageRequest;
import org.myslayers.forum.api.response.message.MessagePageResponse;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.app.support.LoginUserContext;
import org.myslayers.forum.app.support.PageUtil;
import org.myslayers.forum.app.transfer.MessageTransfer;
import org.myslayers.forum.common.enums.ErrorCodeEn;
import org.myslayers.forum.common.enums.MessageChannelEn;
import org.myslayers.forum.common.enums.MessageReadEn;
import org.myslayers.forum.common.enums.MessageTypeEn;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.common.support.CheckUtil;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.BasePosts;
import org.myslayers.forum.domain.entity.Message;
import org.myslayers.forum.domain.entity.User;
import org.myslayers.forum.domain.entity.value.IdValue;
import org.myslayers.forum.domain.repository.MessageRepository;
import org.myslayers.forum.domain.repository.PostsRepository;
import org.myslayers.forum.domain.repository.UserRepository;

import javax.annotation.Resource;
import java.util.*;

@Component
public class MessageManager {

    @Resource
    private MessageRepository messageRepository;

    @Resource
    private UserRepository userRepository;

    @Resource
    private PostsRepository postsRepository;

    @IsLogin
    public PageResponseModel<MessagePageResponse> page(PageRequestModel<MessagePageRequest> pageRequestModel) {
        MessagePageRequest pageRequest = pageRequestModel.getFilter();
        Message message = Message.builder()
                .channel(MessageChannelEn.STATION_LETTER)
                .receiver(IdValue.builder()
                        .id(LoginUserContext.getUser().getId().toString())
                        .build())
                .type(MessageTypeEn.getEntityByDesc(pageRequest.getTypeDesc()))
                .build();
        PageResult<Message> pageResult = messageRepository.page(PageUtil.buildPageRequest(pageRequestModel, message));
        if (ObjectUtils.isEmpty(pageResult.getList())) {
            return PageResponseModel.build(pageResult.getTotal(), pageResult.getSize(), new ArrayList<>());
        }

        Set<Long> userIds = new HashSet<>();
        Set<Long> postsIds = new HashSet<>();
        SafesUtil.ofList(pageResult.getList()).forEach(message1 -> {
            userIds.add(Long.valueOf(message1.getSender().getId()));

            if (MessageTypeEn.APPROVAL_ARTICLE.equals(message.getType())
                    || MessageTypeEn.APPROVAL_FAQ.equals(message.getType())
                    || MessageTypeEn.COMMENT_FAQ.equals(message.getType())
                    || MessageTypeEn.COMMENT_ARTICLE.equals(message.getType())) {
                postsIds.add(Long.valueOf(message1.getTitle()));
            }
        });
        List<User> users = userRepository.queryByIds(new ArrayList<>(userIds));

        List<BasePosts> postsList = new ArrayList<>();
        if (!ObjectUtils.isEmpty(postsIds)) {
            postsList = postsRepository.queryInIds(postsIds);
        }

        List<MessagePageResponse> responses = MessageTransfer.toMessagePageResponses(pageResult.getList(), users, postsList, LoginUserContext.getUser());
        return PageResponseModel.build(pageResult.getTotal(), pageResult.getSize(), responses);
    }

    @IsLogin
    public void markIsRead(Long messageId) {
        Message message = messageRepository.get(messageId);
        CheckUtil.isEmpty(message, ErrorCodeEn.MESSAGE_NOT_EXIST);
        CheckUtil.isFalse(LoginUserContext.getUser().getId().toString().equals(message.getReceiver().getId()), ErrorCodeEn.MESSAGE_NOT_EXIST);

        message.setRead(MessageReadEn.YES);
        messageRepository.updateToRead(message);
    }

    @IsLogin
    public Long countUnRead() {
        return messageRepository.countUnRead(LoginUserContext.getUser().getId());
    }
}
