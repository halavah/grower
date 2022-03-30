package org.myslayers.forum.app.manager;

import org.springframework.stereotype.Component;
import org.myslayers.forum.api.request.file.FileUploadImgRequest;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.domain.service.FileService;

import javax.annotation.Resource;

@Component
public class FileManager {

    @Resource
    private FileService fileService;

    @IsLogin
    public String uploadImg(FileUploadImgRequest request) {
        return fileService.uploadImg(request.getBase64(), request.getFileName());
    }
}
