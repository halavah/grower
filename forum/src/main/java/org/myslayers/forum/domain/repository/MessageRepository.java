package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.enums.MessageTypeEn;
import org.myslayers.forum.common.model.PageRequest;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Message;

import java.util.List;

public interface MessageRepository {

    void save(Message message);

    Message get(Long id);

    PageResult<Message> page(PageRequest<Message> pageRequest);

    void updateToRead(Message message);

    Long countUnRead(Long receiver);

    void deleteInTypesAndTitle(List<MessageTypeEn> typeEns, String title);
}
