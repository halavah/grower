package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Comment;
import org.myslayers.forum.domain.entity.UserFood;
import org.myslayers.forum.domain.repository.UserFoodRepository;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Component
public class FoodCommentCreateListener extends EventBus.EventHandler<Map<String, Object>> {

    @Resource
    private UserFoodRepository userFoodRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.COMMENT_CREATE;
    }

    @Override
    public void onMessage(Map<String, Object> msg) {
        Long userId = Long.valueOf(msg.get("commenter").toString());
        Comment comment = (Comment) msg.get("comment");

        List<UserFood> userFoods = Arrays.asList(UserFood.builder()
                .postsId(comment.getPostsId())
                .userId(userId)
                .build());

        userFoodRepository.batchSave(userFoods);
    }
}
