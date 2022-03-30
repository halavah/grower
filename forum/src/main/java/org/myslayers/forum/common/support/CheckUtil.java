package org.myslayers.forum.common.support;

import org.myslayers.forum.common.enums.ErrorCodeEn;
import org.myslayers.forum.common.exception.BizException;
import org.springframework.util.ObjectUtils;

import java.text.MessageFormat;

public class CheckUtil {

    private CheckUtil() {
    }
    
    public static void checkParamToast(Object o, String message) {
        if (ObjectUtils.isEmpty(o)) {
            throw new BizException(ErrorCodeEn.PARAM_CHECK_ERROR.getCode(),
                    MessageFormat.format(ErrorCodeEn.PARAM_CHECK_ERROR.getMessage(), message));
        }
    }

    public static void checkEmptyToast(Object o, String message) {
        if (ObjectUtils.isEmpty(o)) {
            throw new BizException(ErrorCodeEn.CHECK_ERROR_TOAST.getCode(),
                    MessageFormat.format(ErrorCodeEn.CHECK_ERROR_TOAST.getMessage(), message));
        }
    }
    
    public static void isEmpty(Object o, ErrorCodeEn errorCode) {
        if (ObjectUtils.isEmpty(o)) {
            throw new BizException(errorCode);
        }
    }

    public static void isNotEmpty(Object o, ErrorCodeEn errorCode) {
        if (!ObjectUtils.isEmpty(o)) {
            throw new BizException(errorCode);
        }
    }

    public static void isFalse(Boolean b, ErrorCodeEn errorCode) {
        if (!b) {
            throw new BizException(errorCode);
        }
    }

    public static void isTrue(Boolean b, ErrorCodeEn errorCode) {
        if (b) {
            throw new BizException(errorCode);
        }
    }

}