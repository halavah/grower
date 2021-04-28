package org.myslayers.common.lang;


import java.io.Serializable;
import lombok.Data;

/**
 * 前后端分离：统一封装返回结果
 */
@Data
public class Result implements Serializable {

    // 操作状态：200代表成功，非200为失败/异常
    private int code;

    // 携带msg
    private String msg;

    // 携带data
    private Object data;

    public static Result success(int code, String msg, Object data) {
        Result result = new Result();
        result.code = code;
        result.msg = msg;
        result.data = data;
        return result;
    }

    public static Result success(String msg) {
        return Result.success(200, msg, null);
    }

    public static Result success(String msg, Object data) {
        return Result.success(200, msg, data);
    }

    public static Result fail(int code, String msg, Object data) {
        Result result = new Result();
        result.code = code;
        result.msg = msg;
        result.data = data;
        return result;
    }

    public static Result fail(String msg) {
        return fail(500, msg, null);
    }

    public static Result fail(String msg, Object data) {
        return fail(500, msg, data);
    }
}
