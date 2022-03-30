package org.myslayers.forum.facade.validator;

import org.myslayers.forum.api.request.comment.CommentCreateRequest;
import org.myslayers.forum.common.support.CheckUtil;

public class CommentValidator {

    public static void create(CommentCreateRequest request) {
        CheckUtil.checkParamToast(request, "request");
        CheckUtil.checkParamToast(request.getPostsId(), "postsId");
        CheckUtil.checkParamToast(request.getContent(), "content");
    }
}
