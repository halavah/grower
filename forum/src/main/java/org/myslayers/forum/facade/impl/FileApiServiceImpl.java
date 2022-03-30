package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.file.FileUploadImgRequest;
import org.myslayers.forum.api.service.FileApiService;
import org.myslayers.forum.app.manager.FileManager;
import org.myslayers.forum.facade.support.ResultModelUtil;
import org.myslayers.forum.facade.validator.FileValidator;

import javax.annotation.Resource;

@Service
public class FileApiServiceImpl implements FileApiService {

    @Resource
    private FileManager fileManager;

    @Override
    public ResultModel<String> uploadImg(FileUploadImgRequest request) {
        FileValidator.uploadImg(request);

        return ResultModelUtil.success(fileManager.uploadImg(request));
    }
}
