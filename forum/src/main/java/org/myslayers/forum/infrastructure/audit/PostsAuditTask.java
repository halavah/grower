package org.myslayers.forum.infrastructure.audit;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.myslayers.forum.common.enums.AuditStateEn;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.infrastructure.dal.dao.PostsDAO;
import org.myslayers.forum.infrastructure.dal.dataobject.PostsDO;

import javax.annotation.Resource;
import java.util.List;

/**
 * 帖子自动审核通过
 **/
@Service
public class PostsAuditTask {

    @Resource
    private PostsDAO postsDAO;

    @Scheduled(cron = "0/30 * * * * ? ")
    public void task() {
        List<PostsDO> postsDOS = postsDAO.query(PostsDO.builder()
                .auditState(AuditStateEn.WAIT.getValue())
                .build());
        SafesUtil.ofList(postsDOS).forEach(postsDO -> {
            postsDO.setAuditState(AuditStateEn.PASS.getValue());
            postsDAO.update(postsDO);
        });
    }

}
