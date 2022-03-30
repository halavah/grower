package org.myslayers.forum.facade.validator;

import org.myslayers.forum.api.request.file.FileUploadImgRequest;
import org.myslayers.forum.common.support.CheckUtil;

public class FileValidator {

    public static void uploadImg(FileUploadImgRequest request) {
        CheckUtil.checkParamToast(request, "request");
        CheckUtil.checkParamToast(request.getBase64(), "base64");
        CheckUtil.checkParamToast(request.getFileName(), "fileName");
    }
}
