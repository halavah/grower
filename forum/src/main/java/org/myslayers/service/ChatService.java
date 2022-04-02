package org.myslayers.service;

import java.util.List;
import org.myslayers.im.vo.ImMess;
import org.myslayers.im.vo.ImUser;

public interface ChatService {
    ImUser getCurrentUser();

    void setGroupHistoryMsg(ImMess responseMess);

    List<Object> getGroupHistoryMsg(int count);
}
