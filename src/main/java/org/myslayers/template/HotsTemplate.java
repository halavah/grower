package org.myslayers.template;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.myslayers.common.templates.DirectiveHandler;
import org.myslayers.common.templates.TemplateDirective;
import org.myslayers.utils.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Component;

/**
 * 本周热议文章【标签】
 */
@Component
public class HotsTemplate extends TemplateDirective {

    @Autowired
    RedisUtil redisUtil;

    @Override
    public String getName() {
        return "hots";
    }

    @Override
    public void execute(DirectiveHandler handler) throws Exception {
        List<Map> hostPost = new ArrayList<>();

        // 获取有序集 key 中成员 member 的排名，其中有序集成员按 score 值递减 (从大到小) 排序
        Set<ZSetOperations.TypedTuple> typedTuples = redisUtil.getZSetRank("week:rank", 0, 6);
        for (ZSetOperations.TypedTuple typedTuple : typedTuples) {
            Map<String, Object> map = new HashMap<>();

            //zSet(key， value， score)  -> zSet(文章日期, 文章id, 文章评论数commentCount)，此处取出zSet中的value，即文章id
            String postHashKey = "day:rank:post:" + typedTuple.getValue();

            map.put("id", redisUtil.hget(postHashKey, "post-id"));
            map.put("title", redisUtil.hget(postHashKey, "post-title"));
            map.put("commentCount", redisUtil.hget(postHashKey, "post-commentCount"));
            map.put("viewCount", redisUtil.hget(postHashKey, "post-viewCount"));

            hostPost.add(map);
        }

        handler.put(RESULTS, hostPost).render();
    }
}

