package org.myslayers.forum.portal.controller.rest;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.response.tag.TagQueryResponse;
import org.myslayers.forum.api.service.TagApiService;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/tag-rest")
public class TagRestController {

    @Resource
    private TagApiService tagApiService;

    @PostMapping("/all")
    public ResultModel<List<TagQueryResponse>> all() {
        return tagApiService.queryAll();
    }
}
