package org.myslayers.im.handler.filter;

import lombok.Data;
import org.tio.core.ChannelContext;
import org.tio.core.ChannelContextFilter;

/**
 * 过滤器：过滤当前用户，不需要发送消息
 */
@Data
public class ExculdeMineChannelContextFilter implements ChannelContextFilter {

    private ChannelContext currentContext;

    @Override
    public boolean filter(ChannelContext channelContext) {

        // 过滤当前用户，不需要发送消息
        if(currentContext.userid.equals(channelContext.userid)) {
            return false;
        }
        return true;
    }
}
