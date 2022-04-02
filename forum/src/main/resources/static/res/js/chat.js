/**
 * layim 聊天窗口（chat.js 调用 im.js 方法）
 */
layui.use('layim', function (layim) {

  var $ = layui.jquery;
  layim.config({
    brief: true //是否简约模式（如果true则不显示主面板）
    , voice: false
    , chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.html'
  });

  var tiows = new tio.ws($, layim);

  //1.【获取个人、群聊信息】 + 【打开聊天窗口】
  tiows.openChatWindow();

  //2.【查看历史聊天记录 - 回显】
  tiows.initHistoryMess();

  //3.【使用websocket建立连接】
  tiows.connect();

  //4.【发送消息】
  layim.on('sendMessage', function (res) {
    tiows.sendChatMessage(res);
  });
});
