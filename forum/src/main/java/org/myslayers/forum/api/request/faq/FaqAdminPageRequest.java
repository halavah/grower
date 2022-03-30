package org.myslayers.forum.api.request.faq;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FaqAdminPageRequest implements Serializable {

    private String title;

    private String auditState;

    private Long userId;

    private Long commentId;

}
