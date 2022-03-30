package org.myslayers.forum.domain.service;

import org.myslayers.forum.domain.entity.Message;

public interface MailService {

    void sendHtml(Message mailMessage);

    void sendText(Message mailMessage);

}
