package org.myslayers.forum.facade.validator;

import org.myslayers.forum.api.request.message.MessagePageRequest;
import org.myslayers.forum.common.enums.MessageTypeEn;
import org.myslayers.forum.common.support.CheckUtil;

public class MessageValidator {

    public static void page(MessagePageRequest request) {
        CheckUtil.checkParamToast(request, "request");
        CheckUtil.checkParamToast(request.getTypeDesc(), "typeDesc");
        CheckUtil.checkParamToast(MessageTypeEn.getEntityByDesc(request.getTypeDesc()), "不存在的消息类型");
    }
}
