package org.myslayers.forum.infrastructure.transfer;

import org.springframework.util.ObjectUtils;
import org.myslayers.forum.common.enums.*;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.Message;
import org.myslayers.forum.domain.entity.value.IdValue;
import org.myslayers.forum.infrastructure.dal.dataobject.MessageDO;

import java.util.ArrayList;
import java.util.List;

public class MessageTransfer {

    public static Message toMessage(MessageDO messageDO) {
        if (ObjectUtils.isEmpty(messageDO)) {
            return null;
        }
        Message message = Message.builder()
                .title(messageDO.getTitle())
                .read(MessageReadEn.getEntity(messageDO.getRead()))
                .receiver(IdValue.builder()
                        .id(messageDO.getReceiver())
                        .type(IdValueTypeEn.getEntity(messageDO.getReceiverType()))
                        .build())
                .sender(IdValue.builder()
                        .id(messageDO.getSender())
                        .type(IdValueTypeEn.getEntity(messageDO.getSenderType()))
                        .build())
                .type(MessageTypeEn.getEntity(messageDO.getType()))
                .content(messageDO.getContent())
                .channel(MessageChannelEn.getEntity(messageDO.getChannel()))
                .contentType(MessageContentTypeEn.getEntity(messageDO.getContentType()))
                .build();
        message.setId(messageDO.getId());
        message.setCreateAt(messageDO.getCreateAt());
        message.setUpdateAt(messageDO.getUpdateAt());

        return message;
    }

    public static List<Message> toMessages(List<MessageDO> messageDOS) {
        List<Message> res = new ArrayList<>();

        SafesUtil.ofList(messageDOS).forEach(messageDO -> {
            res.add(toMessage(messageDO));
        });

        return res;
    }
}
