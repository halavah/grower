package org.myslayers.forum.api.service;

import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.file.FileUploadImgRequest;

public interface FileApiService {

    ResultModel<String> uploadImg(FileUploadImgRequest request);

}
