package org.myslayers.forum.infrastructure;

import org.springframework.stereotype.Service;
import org.myslayers.forum.common.enums.MessageChannelEn;
import org.myslayers.forum.common.enums.MessageContentTypeEn;
import org.myslayers.forum.domain.entity.Message;
import org.myslayers.forum.domain.repository.MessageRepository;
import org.myslayers.forum.domain.service.MailService;
import org.myslayers.forum.domain.service.MessageService;

import javax.annotation.Resource;

@Service
public class MessageServiceImpl implements MessageService {

    @Resource
    private MessageRepository messageRepository;

    @Resource
    private MailService mailService;

    @Override
    public void send(Message message) {
        // 邮件
        if (MessageChannelEn.MAIL.equals(message.getChannel())) {
            if (MessageContentTypeEn.HTML.equals(message.getContentType())) {
                mailService.sendHtml(message);
            }
            if (MessageContentTypeEn.TEXT.equals(message.getContentType())) {
                mailService.sendText(message);
            }
        }

        // 站内信
        if (MessageChannelEn.STATION_LETTER.equals(message.getChannel())) {
            // do nothing
        }

        messageRepository.save(message);
    }

}
