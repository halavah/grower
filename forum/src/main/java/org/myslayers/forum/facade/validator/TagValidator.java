package org.myslayers.forum.facade.validator;

import org.myslayers.forum.api.request.tag.TagCreateRequest;
import org.myslayers.forum.common.support.CheckUtil;

public class TagValidator {

    public static void create(TagCreateRequest request) {
        CheckUtil.checkParamToast(request, "request");
        CheckUtil.checkParamToast(request.getName(), "name");
        CheckUtil.checkParamToast(request.getGroupName(), "groupName");
        CheckUtil.checkParamToast(request.getDescription(), "description");
    }

}
