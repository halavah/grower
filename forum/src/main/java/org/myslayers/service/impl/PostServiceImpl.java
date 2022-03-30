package org.myslayers.service.impl;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.Post;
import org.myslayers.mapper.PostMapper;
import org.myslayers.service.PostService;
import org.myslayers.utils.RedisUtil;
import org.myslayers.vo.PostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements PostService {

    @Autowired
    PostMapper postMapper;

    @Autowired
    RedisUtil redisUtil;

    @Override
    public IPage<PostVo> selectPosts(Page page, Long categoryId, Long userId, Integer level,
        Boolean recommend, String order) {
        if (level == null) {
            level = -1;
        }
        QueryWrapper wrapper = new QueryWrapper<Post>()
            .eq(categoryId != null, "category_id", categoryId)
            .eq(userId != null, "user_id", userId)
            .eq(level == 0, "level", 0)
            .gt(level > 0, "level", 0)
            .orderByDesc(order != null, order);
        return postMapper.selectPosts(page, wrapper);
    }

    @Override
    public PostVo selectOnePost(QueryWrapper<Post> warapper) {
        return postMapper.selectOnePost(warapper);
    }

    /**
     * 本周热议的【初始化操作】（近7天全部文章评论量的排行榜）
     */
    @Override
    public void initWeekRank() {
        //1.获取【近7天文章】
        List<Post> posts = this.list(new QueryWrapper<Post>()
            .gt("created", DateUtil.offsetDay(new Date(), -100))  //根据created时间，对最近7天内的文章进行筛选
            .select("id, title, user_id, comment_count, view_count, created") //对文章的属性进行筛选，加快查询速率
        );

        //2.初始化【近7天文章】的总评论量（先使用SortedSet集合对【排行榜7天内全部文章】进行zadd操作，并设置它们expire为7天；再使用Hash哈希表对【排行榜7天内全部文章】进行hexists判断，再hset缓存操作）
        for (Post post : posts) {
            //1.添加add——|day:rank:20210202--0208|，将【近7天文章】创建日期时间作为key值，每篇文章对应的id作为它的value值，每篇文章对应的评论comment作为它的score值，并使用redis的工具类（RedisUtil），对文章的具体属性进行zSet()缓存操作
            String zKey =
                "day:rank:" + DateUtil.format(post.getCreated(), DatePattern.PURE_DATE_FORMAT);
            redisUtil
                .zSet(zKey, post.getId(), post.getCommentCount());//阅读redisUtil工具类，可知zSet等同于zadd

            //2.过期expire——|day:rank:20210202--0208|，让【近7天文章】的key过期： 7-（当前时间-创建时间）= 过期时间
            long expireTime =
                (100 - DateUtil.between(new Date(), post.getCreated(), DateUnit.DAY)) * 24 * 60 * 60;
            redisUtil.expire(zKey, expireTime);

            //3.缓存——|day:rank:post:1~16|，缓存【近7天文章】的一些基本信息，例如文章id，标题title，评论数量，作者信息...方便访问【近7天文章】时，直接redis，而非MySQL
            //3.1先对文章进行EXISTS判断其缓存是否存在
            String hKey = "day:rank:post:" + post.getId();
            if (!redisUtil.hasKey(hKey)) {
                //3.2如果false不存在，则再hset缓存操作
                redisUtil.hset(hKey, "post-id", post.getId(), expireTime);
                redisUtil.hset(hKey, "post-title", post.getTitle(), expireTime);
                redisUtil.hset(hKey, "post-commentCount", post.getCommentCount(), expireTime);
                redisUtil.hset(hKey, "post-viewCount", post.getViewCount(), expireTime);
            }
        }

        //3.对【近7天文章】做并集运算（zUnionAndStore）， 并使用根据评论量的数量从大到小进行展示（zrevrange）
        String currentKey = "day:rank:" + DateUtil.format(new Date(), DatePattern.PURE_DATE_FORMAT);
        List<String> otherKeys = new ArrayList<>();
        for (int i = -6; i < 0; i++) {
            String temp = "day:rank:" + DateUtil
                .format(DateUtil.offsetDay(new Date(), i), DatePattern.PURE_DATE_FORMAT);
            otherKeys.add(temp);
        }
        String destKey = "week:rank";
        redisUtil.zUnionAndStore(currentKey, otherKeys, destKey);
    }

    /**
     * 本周热议的【更新操作】：通过自增/自减评论数，再对排行榜做并集运算
     */
    @Override
    public void incrCommentCountAndUnionForWeekRank(Post post, boolean isIncr) {
        //1.自增/自减评论数
        String currentKey = "day:rank:" + DateUtil.format(new Date(), DatePattern.PURE_DATE_FORMAT);
        redisUtil.zIncrementScore(currentKey, post.getId(), isIncr ? 1 : -1);

        //2.更新这篇文章的缓存时间，并更新这篇文章的基本信息
        String zKey =
            "day:rank:" + DateUtil.format(post.getCreated(), DatePattern.PURE_DATE_FORMAT);
        long expireTime =
            (7 - DateUtil.between(new Date(), post.getCreated(), DateUnit.DAY)) * 24 * 60 * 60;
        redisUtil.expire(zKey, expireTime);
        String hKey = "day:rank:post:" + post.getId();
        if (!redisUtil.hasKey(hKey)) {
            //3.2如果false不存在，则再hset缓存操作
            redisUtil.hset(hKey, "post-id", post.getId(), expireTime);
            redisUtil.hset(hKey, "post-title", post.getTitle(), expireTime);
            redisUtil.hset(hKey, "post-commentCount", post.getCommentCount(), expireTime);
            redisUtil.hset(hKey, "post-viewCount", post.getViewCount(), expireTime);
        }

        //3.对【近7天文章】重新做并集运算（zUnionAndStore）
        List<String> otherKeys = new ArrayList<>();
        for (int i = -6; i < 0; i++) {
            String temp = "day:rank:" + DateUtil
                .format(DateUtil.offsetDay(new Date(), i), DatePattern.PURE_DATE_FORMAT);
            otherKeys.add(temp);
        }
        String destKey = "week:rank";
        redisUtil.zUnionAndStore(currentKey, otherKeys, destKey);
    }

    /**
     * 文章阅读【缓存实现访问量】：减少访问数据库的次数，存在一个BUG，只与点击链接的次数相关，没有与用户的id进行绑定
     */
    @Override
    public void putViewCount(PostVo postVo) {
        //1.从缓存中获取当前访问量viewCount
        String hKey = "day:rank:post:" + postVo.getId();
        Integer viewCount = (Integer) redisUtil.hget(hKey, "post-viewCount");

        //2.若缓存中存在viewCount，则viewCount+1；若不存在，则postVo.getViewCount()+1
        //  注意一点，项目启动前会对【7天内的文章】进行缓存，因此，还会存在【7天前的文章】未进行缓存
        if (viewCount != null) {
            postVo.setViewCount(viewCount + 1);
        } else {
            postVo.setViewCount(postVo.getViewCount() + 1);
        }

        //3.将viewCount同步到缓存中
        redisUtil.hset(hKey, "post-viewCount", postVo.getViewCount());
    }
}



