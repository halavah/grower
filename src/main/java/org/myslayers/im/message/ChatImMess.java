package org.myslayers.im.message;

import lombok.Data;
import org.myslayers.im.vo.ImTo;
import org.myslayers.im.vo.ImUser;

@Data
public class ChatImMess {

    private ImUser mine;
    private ImTo to;

}
