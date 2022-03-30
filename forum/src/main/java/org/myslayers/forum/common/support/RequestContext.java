package org.myslayers.forum.common.support;

import org.springframework.util.ObjectUtils;

public class RequestContext {
    
    private static final ThreadLocal<String> REQUEST_TRACE_ID = new ThreadLocal<>();
    
    public static void init() {
        if (ObjectUtils.isEmpty(REQUEST_TRACE_ID.get())) {
            REQUEST_TRACE_ID.set(StringUtil.generateUUID());
        }
    }
    
    public static String getTraceId() {
        return ObjectUtils.isEmpty(REQUEST_TRACE_ID.get()) ? "" : REQUEST_TRACE_ID.get();
    }

    public static void removeAll() {
        REQUEST_TRACE_ID.remove();
    }

}
