package org.myslayers.forum.portal.controller.rest;

import org.springframework.web.bind.annotation.*;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.article.ArticleSaveArticleRequest;
import org.myslayers.forum.api.response.article.ArticleInfoResponse;
import org.myslayers.forum.api.response.article.ArticleQueryTypesResponse;
import org.myslayers.forum.api.service.ArticleApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RestController
@RequestMapping("/article-rest")
public class ArticleRestController {

    @Resource
    private ArticleApiService articleApiService;

    @PostMapping("/save")
    public ResultModel<Long> save(@RequestBody ArticleSaveArticleRequest articleRequest, HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return articleApiService.saveArticle(articleRequest);
    }

    @PostMapping("/{id}")
    public ResultModel<ArticleInfoResponse> get(@PathVariable("id") Long id, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));
        return articleApiService.info(id);
    }

    @PostMapping("/editArticleTypes")
    public ResultModel<List<ArticleQueryTypesResponse>> getAllType(HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return articleApiService.queryEditArticleTypes();
    }
}
