package org.myslayers.forum.facade.aspect;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.myslayers.forum.common.enums.ErrorCodeEn;
import org.myslayers.forum.common.exception.BizException;
import org.myslayers.forum.common.support.LogUtil;
import org.myslayers.forum.common.support.StringUtil;
import org.myslayers.forum.facade.support.ResultModelUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Slf4j
@Component
@Aspect
public class ExceptionHandlerAndLogAspect {

    @Resource
    private HttpServletRequest httpServletRequest;

    @Around("execution(* org.myslayers.forum.api..*.*(..))")
    public Object invoke(ProceedingJoinPoint pjp) throws Throwable {
        Long start = System.currentTimeMillis();
        Object result;
        Throwable throwable = null;
        Boolean invokeSuccess = true;

        try {
            result = pjp.proceed();
        } catch (BizException bizException) {
            result = ResultModelUtil.fail(bizException.getCode(), bizException.getMessage());
            invokeSuccess = false;
        } catch (Exception e) {
            result = ResultModelUtil.fail(ErrorCodeEn.SYSTEM_ERROR);
            invokeSuccess = false;
            throwable = e;
        }

        logRequestInfo(invokeSuccess, pjp, start, result, throwable);

        return result;
    }

    private void logRequestInfo(Boolean invokeSuccess, ProceedingJoinPoint pjp, Long start, Object result, Throwable e) {
        Long cost = System.currentTimeMillis() - start;
        if (null == e) {
            LogUtil.info(log, "{}, ip={}. api={}#{}. cost={}ms. params={}. result={}"
                    , invokeSuccess ? "success" : "fail"
                    , httpServletRequest.getRemoteAddr()
                    , pjp.getSourceLocation().getWithinType().getName()
                    , pjp.getSignature().getName()
                    , cost
                    , StringUtil.toJSONString(pjp.getArgs())
                    , (null == result ? "" : StringUtil.toJSONString(result)));
            return;
        }

        LogUtil.info(log, e, "fail, ip={}. api={}#{}. cost={}ms. params={}. result={}. exception={}"
                , httpServletRequest.getRemoteAddr()
                , pjp.getSourceLocation().getWithinType().getName()
                , pjp.getSignature().getName()
                , cost
                , StringUtil.toJSONString(pjp.getArgs())
                , (null == result ? "" : StringUtil.toJSONString(result))
                , e.getClass().getName() + ": " + e.getMessage());
    }


}
