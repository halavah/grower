## 1. 侧边栏本周热议
### 1.1 Redis集成
- 添加redis依赖，使用utils包下的RedisUtil对内置RedisTemplate进行封装
- 添加hutool依赖，使用DateUtil类中的offsetDay()、format()
- 考虑到redis序列化后出现乱码问题，使用RedisConfig配置类进行编码的处理

### 1.2 利用 Redis 的 zet 有序集合实现
- 缓存热评文章——哈希表Hash
- 评论数量排行——有序列表sortedSet：ZADD（添加）、ZREVRANGE（展示）、ZUNIONSTORE（并集）
    - ZADD key score member [[score member] [score member] ...]     
        ```
        127.0.0.1:6379> ZADD day:18 10 post:1 6 post:2 4 post:3
        (integer) 3
        127.0.0.1:6379> ZADD day:19 10 post:1 6 post:2 4 post:3
        (integer) 3
        127.0.0.1:6379> ZADD day:20 10 post:1 6 post:2 4 post:3
        (integer) 3
        127.0.0.1:6379> ZADD day:21 10 post:1 6 post:2 4 post:3
        (integer) 3
        127.0.0.1:6379> ZADD day:22 10 post:1 6 post:2 4 post:3
        (integer) 3
        127.0.0.1:6379> ZADD day:23 10 post:1 6 post:2 4 post:3
        (integer) 3
        127.0.0.1:6379> ZADD day:24 10 post:1 6 post:2 4 post:3
        (integer) 3
        ```
    - ZREVRANGE key start stop [WITHSCORES]
        ```
        127.0.0.1:6379> ZREVRANGE day:18 0 -1 withscores
        1) "post:1"
        2) "10"
        3) "post:2"
        4) "6"
        5) "post:3"
        6) "4"
        ```
    - ZUNIONSTORE destination numkeys key [key ...] [WEIGHTS weight [weight ...]] [AGGREGATE SUM|MIN|MAX]
        ```
        127.0.0.1:6379> ZUNIONSTORE week:rank 7 day:18 day:19 day:20 day:21 day:22 day:23 day:24
        1) "post:1"
        2) "post:2"
        ```
    - 查看排行榜
        ```
        127.0.0.1:6379> ZREVRANGE week:rank 0 -1 withscores
        1) "post:1"
        2) "70"
        3) "post:2"
        4) "42"
        5) "post:3"
        6) "28"
        ```
    - 添加/删除评论
        ```
        127.0.0.1:6379> ZINCRBY day:18 10 post:1
        "20"
        127.0.0.1:6379> ZREVRANGE  day:18 0 -1 withscores
        1) "post:1"
        2) "20"
        3) "post:2"
        4) "6"
        5) "post:3"
        6) "4"
        127.0.0.1:6379> ZINCRBY day:18 -10 post:1
        "10"
        ```
        
### 1.3 本周热议的基本实现逻辑
- 项目启动前，获取【近7天文章】
- 初始化【近7天文章】的总评论量（先使用SortedSet集合对【排行榜7天内全部文章】进行zadd操作，并设置它们expire为7天；再使用Hash哈希表对【排行榜7天内全部文章】进行hexists判断，再hset缓存操作）
    - 添加add——将【近7天文章】创建日期时间作为key值，每篇文章对应的id作为它的value值，每篇文章对应的评论comment作为它的score值，并使用redis的工具类（RedisUtil），对文章的具体属性进行zSet()缓存操作
    - 过期expire——让【近7天文章】的key过期： 7-（当前时间-创建时间）= 过期时间
    - 缓存——缓存【近7天文章】的一些基本信息，例如文章id，标题title，评论数量，作者信息...方便访问【近7天文章】时，直接redis，而非MySQL
        - 先对文章进行EXISTS判断其缓存是否存在
        - 如果false不存在，则再hset缓存操作
- 对【近7天文章】做并集运算（zUnionAndStore）， 并使用根据评论量的数量从大到小进行展示（zrevrange）

### 1.4 后端核心代码
```java
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements PostService {

    @Autowired
    RedisUtil redisUtil;

    /**
     * 项目启动前，初始化本周热议（近7天全部文章评论量的排行榜）
     */
    @Override
    public void initWeekRank() {
        //1.获取【近7天文章】
        List<Post> posts = this.list(new QueryWrapper<Post>()
                .gt("created", DateUtil.offsetDay(new Date(), -7))  //根据created时间，对最近7天内的文章进行筛选
                .select("id, title, user_id, comment_count, view_count, created") //对文章的属性进行筛选，加快查询速率
        );

        //2.初始化【近7天文章】的总评论量（先使用SortedSet集合对【排行榜7天内全部文章】进行zadd操作，并设置它们expire为7天；再使用Hash哈希表对【排行榜7天内全部文章】进行hexists判断，再hset缓存操作）
        for (Post post : posts) {
            //1.添加add——将【近7天文章】创建日期时间作为key值，每篇文章对应的id作为它的value值，每篇文章对应的评论comment作为它的score值，并使用redis的工具类（RedisUtil），对文章的具体属性进行zSet()缓存操作
            String zKey = "day:rank:" + DateUtil.format(post.getCreated(), DatePattern.PURE_DATE_FORMAT);
            redisUtil.zSet(zKey, post.getId(), post.getCommentCount());//阅读redisUtil工具类，可知zSet等同于zadd

            //2.过期expire——让【近7天文章】的key过期： 7-（当前时间-创建时间）= 过期时间
            long expireTime = (7 - DateUtil.between(new Date(), post.getCreated(), DateUnit.DAY)) * 24 * 60 * 60;
            redisUtil.expire(zKey, expireTime);

            //3.缓存——缓存【近7天文章】的一些基本信息，例如文章id，标题title，评论数量，作者信息...方便访问【近7天文章】时，直接redis，而非MySQL
            //3.1先对文章进行EXISTS判断其缓存是否存在
            String hKey = "day:rank:post:" + post.getId();
            if (!redisUtil.hasKey(hKey)) {
                //3.2如果false不存在，则再hset缓存操作
                redisUtil.hset(hKey, "post-id", post.getId(), expireTime);
                redisUtil.hset(hKey, "post-title", post.getTitle(), expireTime);
                redisUtil.hset(hKey, "post-commentCount", post.getCommentCount(), expireTime);
                redisUtil.hset(hKey, "post:viewCount", post.getViewCount(), expireTime);
            }
        }

        //3.对【近7天文章】做并集运算（zUnionAndStore）， 并使用根据评论量的数量从大到小进行展示（zrevrange）
        String currentKey = "day:rank:" + DateUtil.format(new Date(), DatePattern.PURE_DATE_FORMAT);
        List<String> otherKeys = new ArrayList<>();
        for (int i = -6; i < 0; i++) {
            String temp = "day:rank:" + DateUtil.format(DateUtil.offsetDay(new Date(), i), DatePattern.PURE_DATE_FORMAT);
            otherKeys.add(temp);
        }
        String destKey = "week:rank";
        redisUtil.zUnionAndStore(currentKey, otherKeys, destKey);
    }
}
```







