## 4. 集成 Shiro 实现博客详情-删除文章、评论文章
### 4.1 博客详情-删除文章
- `PostController.java` ：控制层，删除文章
```java
@Controller
public class PostController extends BaseController {
    /**
     * 详情detail：【删除】文章
     */
    @ResponseBody
    @Transactional
    @PostMapping("/post/delete")
    public Result delete(Long id) {
        Post post = postService.getById(id);
        Assert.notNull(post, "该帖子已被删除");
        Assert.isTrue(post.getUserId().longValue() == getProfileId().longValue(), "无权限删除此文章！");

        // 删除-该篇文章【该篇文章】-Post
        postService.removeById(id);
        // 删除-我的消息【收到消息】-UserMessage中的post_id
        messageService.removeByMap(MapUtil.of("post_id", id));
        // 删除-用户中心【收藏的帖】-UserCollection中的post_id
        collectionService.removeByMap(MapUtil.of("post_id", id));

        return Result.success().action("/user/index");
    }

    /**
     * 详情detail：【评论】文章
     */
    @ResponseBody
    @Transactional
    @PostMapping("/post/reply/")
    public Result reply(Long jid, String content) {
        Assert.notNull(jid, "找不到对应的文章");
        Assert.hasLength(content, "评论内容不能为空");

        Post post = postService.getById(jid);
        Assert.isTrue(post != null, "该文章已被删除");

        // 新增评论
        Comment comment = new Comment();
        comment.setPostId(jid);
        comment.setContent(content);
        comment.setUserId(getProfileId());
        comment.setCreated(new Date());
        comment.setModified(new Date());
        comment.setLevel(0);
        comment.setVoteDown(0);
        comment.setVoteUp(0);
        commentService.save(comment);

        // 评论数量+1
        post.setCommentCount(post.getCommentCount() + 1);
        postService.updateById(post);

        // 本周热议数量+1
        postService.incrCommentCountAndUnionForWeekRank(post, true);

        // 通知作者，有人评论了你的文章
        // 作者自己评论自己文章，不需要通知
        if (comment.getUserId() != post.getUserId()) {
            UserMessage message = new UserMessage();
            message.setFromUserId(getProfileId());
            message.setToUserId(post.getUserId());
            message.setPostId(jid);
            message.setCommentId(comment.getId());
            message.setType(1); //我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论
            message.setStatus(0); //我的消息的【状态】：0代表未读、1代表已读
            message.setCreated(new Date());
            messageService.save(message);
        }

        // 通知被@的人，有人回复了你的文章
        if (content.startsWith("@")) {
            String username = content.substring(1, content.indexOf(" "));
            User user = userService.getOne(new QueryWrapper<User>().eq("username", username));
            if (user != null) {
                UserMessage message = new UserMessage();
                message.setFromUserId(getProfileId());
                message.setToUserId(post.getUserId());
                message.setPostId(jid);
                message.setCommentId(comment.getId());
                message.setType(2); //我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论
                message.setStatus(0); //我的消息的【状态】：0代表未读、1代表已读
                message.setCreated(new Date());
                messageService.save(message);
            }
        }

        return Result.success().action("/post/" + post.getId());
    } 
}
```

### 4.2 博客详情-评论文章
- `PostController.java` ：控制层，评论文章
```java
@Controller
public class PostController extends BaseController {
    /**
     * 详情detail：【删除】文章
     */
    @ResponseBody
    @Transactional
    @PostMapping("/post/delete")
    public Result delete(Long id) {
        Post post = postService.getById(id);
        Assert.notNull(post, "该帖子已被删除");
        Assert.isTrue(post.getUserId().longValue() == getProfileId().longValue(), "无权限删除此文章！");

        // 删除-该篇文章【该篇文章】-Post
        postService.removeById(id);
        // 删除-我的消息【收到消息】-UserMessage中的post_id
        messageService.removeByMap(MapUtil.of("post_id", id));
        // 删除-用户中心【收藏的帖】-UserCollection中的post_id
        collectionService.removeByMap(MapUtil.of("post_id", id));

        return Result.success().action("/user/index");
    }

    /**
     * 详情detail：【评论】文章
     */
    @ResponseBody
    @Transactional
    @PostMapping("/post/reply/")
    public Result reply(Long jid, String content) {
        Assert.notNull(jid, "找不到对应的文章");
        Assert.hasLength(content, "评论内容不能为空");

        Post post = postService.getById(jid);
        Assert.isTrue(post != null, "该文章已被删除");

        // 新增评论
        Comment comment = new Comment();
        comment.setPostId(jid);
        comment.setContent(content);
        comment.setUserId(getProfileId());
        comment.setCreated(new Date());
        comment.setModified(new Date());
        comment.setLevel(0);
        comment.setVoteDown(0);
        comment.setVoteUp(0);
        commentService.save(comment);

        // 评论数量+1
        post.setCommentCount(post.getCommentCount() + 1);
        postService.updateById(post);

        // 本周热议数量+1
        postService.incrCommentCountAndUnionForWeekRank(post, true);

        // 通知作者，有人评论了你的文章
        // 作者自己评论自己文章，不需要通知
        if (comment.getUserId() != post.getUserId()) {
            UserMessage message = new UserMessage();
            message.setFromUserId(getProfileId());
            message.setToUserId(post.getUserId());
            message.setPostId(jid);
            message.setCommentId(comment.getId());
            message.setType(1); //我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论
            message.setStatus(0); //我的消息的【状态】：0代表未读、1代表已读
            message.setCreated(new Date());
            messageService.save(message);
        }

        // 通知被@的人，有人回复了你的文章
        if (content.startsWith("@")) {
            String username = content.substring(1, content.indexOf(" "));
            User user = userService.getOne(new QueryWrapper<User>().eq("username", username));
            if (user != null) {
                UserMessage message = new UserMessage();
                message.setFromUserId(getProfileId());
                message.setToUserId(post.getUserId());
                message.setPostId(jid);
                message.setCommentId(comment.getId());
                message.setType(2); //我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论
                message.setStatus(0); //我的消息的【状态】：0代表未读、1代表已读
                message.setCreated(new Date());
                messageService.save(message);
            }
        }

        return Result.success().action("/post/" + post.getId());
    } 
}
```