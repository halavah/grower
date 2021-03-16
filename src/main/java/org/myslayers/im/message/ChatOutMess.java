package org.myslayers.im.message;

import lombok.Data;
import org.myslayers.im.vo.ImMess;

@Data
public class ChatOutMess {

    private String emit;
    private ImMess data;

}
