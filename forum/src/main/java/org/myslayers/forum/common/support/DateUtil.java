package org.myslayers.forum.common.support;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static String toyyyyMMddHHmmss(Date date) {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    }
}
