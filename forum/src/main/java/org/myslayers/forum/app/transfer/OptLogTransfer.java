package org.myslayers.forum.app.transfer;

import org.springframework.util.ObjectUtils;
import org.myslayers.forum.api.request.user.UserOptLogPageRequest;
import org.myslayers.forum.common.enums.OptLogTypeEn;
import org.myslayers.forum.domain.entity.OptLog;

public class OptLogTransfer {

    public static OptLog toOptLog(UserOptLogPageRequest request) {
        return OptLog.builder()
                .operatorId(request.getOperatorId())
                .type(ObjectUtils.isEmpty(request.getType()) ? null : OptLogTypeEn.getEntity(request.getType()))
                .build();
    }

}
