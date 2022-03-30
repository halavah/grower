package org.myslayers.forum.portal.request;

import lombok.Data;

@Data
public class IndexRequest extends BasePageRequest {

    private String type;

    private String toast;

    private String token;
}
