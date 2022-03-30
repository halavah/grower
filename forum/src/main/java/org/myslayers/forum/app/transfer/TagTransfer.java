package org.myslayers.forum.app.transfer;

import org.myslayers.forum.api.request.tag.TagCreateRequest;
import org.myslayers.forum.api.response.tag.TagPageResponse;
import org.myslayers.forum.api.response.tag.TagQueryResponse;
import org.myslayers.forum.app.support.LoginUserContext;
import org.myslayers.forum.common.enums.AuditStateEn;
import org.myslayers.forum.common.support.DateUtil;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.Tag;

import java.util.ArrayList;
import java.util.List;

public class TagTransfer {

    public static Tag toTag(TagCreateRequest request) {
        return Tag.builder()
                .groupName(request.getGroupName())
                .auditState(AuditStateEn.WAIT)
                .creatorId(LoginUserContext.getUser().getId())
                .description(request.getDescription())
                .name(request.getName())
                .refCount(0L)
                .build();
    }

    public static List<TagQueryResponse> toTagQueryAllResponses(List<Tag> tags) {
        List<TagQueryResponse> responses = new ArrayList<>();

        SafesUtil.ofList(tags).forEach(tag -> responses.add(toTagQueryAllResponse(tag)));
        return responses;
    }

    public static TagQueryResponse toTagQueryAllResponse(Tag tag) {
        return TagQueryResponse.builder()
                .description(tag.getDescription())
                .groupName(tag.getGroupName())
                .id(tag.getId())
                .name(tag.getName())
                .refCount(tag.getRefCount())
                .build();
    }

    public static List<TagPageResponse> toTagPageResponses(List<Tag> tags) {
        List<TagPageResponse> responses = new ArrayList<>();

        SafesUtil.ofList(tags).forEach(tag -> responses.add(TagPageResponse.builder()
                .auditState(tag.getAuditState().getDesc())
                .createAt(DateUtil.toyyyyMMddHHmmss(tag.getCreateAt()))
                .creatorId(tag.getCreatorId())
                .description(tag.getDescription())
                .groupName(tag.getGroupName())
                .id(tag.getId())
                .name(tag.getName())
                .refCount(tag.getRefCount())
                .updateAt(DateUtil.toyyyyMMddHHmmss(tag.getUpdateAt()))
                .build()));

        return responses;
    }
}
