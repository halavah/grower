package org.myslayers.forum.common.exception;

import org.myslayers.forum.common.enums.ErrorCodeEn;
import lombok.Data;

@Data
public class BizException extends RuntimeException {

    private String message;
    
    private Integer code;
    
    public BizException() {
        this(ErrorCodeEn.SYSTEM_ERROR);
    }
    
    public BizException(ErrorCodeEn errorCode) {
        this(errorCode.getCode(), errorCode.getMessage());
    }
    
    public BizException(Integer code, String message) {
        super(message);
        this.message = message;
        this.code = code;
    }

}