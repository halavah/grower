package org.myslayers.schedules;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import org.myslayers.entity.Post;
import org.myslayers.service.PostService;
import org.myslayers.utils.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 定时器定时更新
 */
@Component
public class ViewCountSyncTask {

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    RedisTemplate redisTemplate;

    @Autowired
    PostService postService;

    //每分钟同步一次（缓存 -> 同步到数据库）
    @Scheduled(cron = "0/5 * * * * *")
    public void task() {
        //1.查询缓存中"day:rank:post:"的全部key
        Set<String> keys = redisTemplate.keys("day:rank:post:" + "*");

        //2.遍历全部key，如果某个key中含有“post-viewCount”，则通过ArrayList数组依次将【带有post-viewCount的文章postId】存放
        List<String> ids = new ArrayList<>();
        for (String key : keys) {
            if (redisUtil.hHasKey(key, "post-viewCount")) {
                String postId = key.substring("day:rank:post:".length());
                ids.add(postId);
            }
        }

        //3.将【全部缓存中的postId】同步到数据库
        if (ids.isEmpty()) {
            //3.1 如果[没有需要更新阅读量的文章】，则直接返回
            return;
        } else {
            //3.2 如果[存在需要更新阅读量的文章】，则先【根据ids查询全部的文章】，再【从缓存中获取该postId对应的访问量】，然后【给Post重新赋值viewCount】
            List<Post> posts = postService.list(new QueryWrapper<Post>().in("id", ids));
            for (Post post : posts) {
                Integer viewCount = (Integer) redisUtil
                    .hget("day:rank:post:" + post.getId(), "post-viewCount");
                post.setViewCount(viewCount);
            }

            //3.3 同步操作
            if (posts.isEmpty()) {
                //如果【数据库中刚好删除完全部文章，即不存在文章】，则直接返回
                return;
            } else {
                //同步数据，并删除缓存
                if (postService.updateBatchById(posts)) {
                    for (String id : ids) {
                        redisUtil.hdel("day:rank:post:" + id, "post-viewCount");
                        System.out.println(id + "---------------------->同步成功");
                    }
                }
            }
        }
    }
}

