package org.myslayers.common.lang;

import lombok.Data;

import java.io.Serializable;

@Data
public class Result implements Serializable {
    // 操作状态：0成功，-1失败
    private int status;

    // 携带msg
    private String msg;

    // 携带data
    private Object data;

    // 跳转页面：【lay-submit】默认提交时，通过阅读/res/mods/index.js源码可知，默认跳转【location.href = res.action;】，即action对应的位置
    private String action;

    /**
     * 操作状态：0成功，-1失败
     */
    public static Result success(String msg, Object data) {
        Result result = new Result();
        result.status = 0;
        result.msg = msg;
        result.data = data;
        return result;
    }

    public static Result success() {
        return Result.success("操作成功", null);
    }

    public static Result success(Object data) {
        return Result.success("操作成功", data);
    }

    /**
     * 操作状态：0成功，-1失败
     */
    public static Result fail(String msg) {
        Result result = new Result();
        result.status = -1;
        result.data = null;
        result.msg = msg;
        return result;
    }

    /**
     * 跳转页面
     */
    public Result action(String action){
        this.action = action;
        return this;
    }
}

