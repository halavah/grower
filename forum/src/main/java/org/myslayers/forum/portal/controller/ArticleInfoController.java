package org.myslayers.forum.portal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.article.ArticleAuthorPageRequest;
import org.myslayers.forum.api.response.article.ArticleInfoResponse;
import org.myslayers.forum.api.response.article.ArticleUserPageResponse;
import org.myslayers.forum.api.response.comment.CommentPageResponse;
import org.myslayers.forum.api.service.ApprovalApiService;
import org.myslayers.forum.api.service.ArticleApiService;
import org.myslayers.forum.api.service.CommentApiService;
import org.myslayers.forum.api.service.UserApiService;
import org.myslayers.forum.api.vo.TagVO;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.common.support.GlobalViewConfig;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.portal.request.BasePageRequest;
import org.myslayers.forum.portal.support.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/article")
public class ArticleInfoController {

    @Resource
    private ArticleApiService articleApiService;

    @Resource
    private CommentApiService commentApiService;

    @Resource
    private UserApiService userApiService;

    @Resource
    private ApprovalApiService approvalApiService;

    @Resource
    private WebUtil webUtil;

    @Resource
    private GlobalViewConfig globalViewConfig;

    @GetMapping("/{id}")
    public String home(@PathVariable("id") Long id, BasePageRequest pageRequest, HttpServletRequest request, Model model) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebContext.getCurrentSid());

        ResultModel<ArticleInfoResponse> resultModel = articleApiService.info(id);
        if (!resultModel.getSuccess() || ObjectUtils.isEmpty(resultModel)) {
            throw ViewException.build(resultModel.getMessage());
        }
        ArticleInfoResponse articleInfoResponse = resultModel.getData();

        model.addAttribute("posts", webUtil.buildPostsInfo(articleInfoResponse));
        model.addAttribute("hasFollow", hasFollow(articleInfoResponse.getAuthorId()));
        model.addAttribute("hasApproval", hasApproval(id));
        model.addAttribute("authArticleList", authArticleList(articleInfoResponse.getAuthorId()));

        PageResponseModel pageResponseModel = pickComment(model, id, pageRequest);
        model.addAttribute("pager", pager(pageRequest.getPageNo(), pageResponseModel));

        Set<Long> tagIds = SafesUtil.ofList(articleInfoResponse.getTags()).stream().map(TagVO::getId).collect(Collectors.toSet());
        model.addAttribute("relatedPosts", webUtil.relatedPosts(tagIds));
        model.addAttribute("usedTags", webUtil.usedTags());

        return "article-info";
    }

    private boolean hasApproval(Long postsId) {
        ResultModel<Boolean> resultModel = approvalApiService.hasApproval(postsId);
        if (resultModel.getSuccess() && !ObjectUtils.isEmpty(resultModel.getData())) {
            return resultModel.getData();
        }
        return false;
    }

    private boolean hasFollow(Long followed) {
        ResultModel<Boolean> resultModel = userApiService.hasFollow(followed);
        if (!resultModel.getSuccess()) {
            return false;
        }
        return resultModel.getData();
    }

    private PageResponseModel pickComment(Model model, Long id, BasePageRequest pageRequest) {
        PageRequestModel<Long> pageRequestModel = new PageRequestModel<>();
        pageRequestModel.setPageSize(globalViewConfig.getPageSize());
        pageRequestModel.setPageNo(pageRequest.getPageNo());
        pageRequestModel.setFilter(id);

        ResultModel<PageResponseModel<CommentPageResponse>> resultModel = commentApiService.page(pageRequestModel);
        if (!resultModel.getSuccess()) {
            throw ViewException.build(resultModel.getMessage());
        }

        PageResponseModel<CommentPageResponse> pageResponseModel = resultModel.getData();
        model.addAttribute("comments", pageResponseModel.getList());

        return pageResponseModel;
    }

    private Map<String, Object> pager(Integer pageNo, PageResponseModel pageResponseModel) {
        String queryPath = "?" + WebConst.PAGE_NO_NAME + "=";

        return webUtil.buildPager(pageNo, queryPath, pageResponseModel);
    }

    private List<Map<String, Object>> authArticleList(Long authorId) {
        List<Map<String, Object>> postsList = new ArrayList<>();

        PageRequestModel<ArticleAuthorPageRequest> pageRequestModel = new PageRequestModel<>();
        pageRequestModel.setPageSize(10);
        pageRequestModel.setPageNo(1);
        pageRequestModel.setFilter(ArticleAuthorPageRequest.builder()
                .userId(authorId)
                .build());
        ResultModel<PageResponseModel<ArticleUserPageResponse>> resultModel = articleApiService.authorPage(pageRequestModel);
        if (!resultModel.getSuccess()) {
            return postsList;
        }

        PageResponseModel<ArticleUserPageResponse> pageResponseModel = resultModel.getData();
        SafesUtil.ofList(pageResponseModel.getList()).forEach(articleUserPageResponse -> {
            Map<String, Object> posts = new HashMap<>();
            posts.put("id", articleUserPageResponse.getId());
            posts.put("title", articleUserPageResponse.getTitle());
            posts.put("createdAt", articleUserPageResponse.getCreateAt());
            postsList.add(posts);
        });

        return postsList;
    }

}
