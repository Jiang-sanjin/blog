package com.example.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * 日志 aop
 */
@Aspect
@Component
public class LogAspect {

    //获取日志信息
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    // 定义切面，声明log是一个切面
    @Pointcut("execution(* com.example.web.*.*(..))")
    public void log() {
    }


    // 在切面之前执行   获取请求的信息
    @Before("log()")
    public void doBefore(JoinPoint joinPoint) {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        String url = request.getRequestURL().toString();
        String ip = request.getRemoteAddr();
        String classMethod = joinPoint.getSignature().getDeclaringTypeName() + "." + joinPoint.getSignature().getName();
        Object[] args = joinPoint.getArgs();
        RequestLog requestLog = new RequestLog(url, ip, classMethod, args);

        logger.info("Request : {}", requestLog);
    }

    //切面之后执行
    @After("log()")
    public void doAfter() {
        // logger.info("----------------After-----------");
    }

    //返回之后拦截    获取返回的信息
    @AfterReturning(returning = "result", pointcut = "log()")
    public void doAfterRuturn(Object result) {
        logger.info("Result:{ }", result);
    }

    private class RequestLog {
        private String url;
        private String ip;
        private String classMethod;  //调用方法
        private Object[] args;   //请求参数

        public RequestLog(String url, String ip, String classMethod, Object[] args) {
            this.url = url;
            this.ip = ip;
            this.classMethod = classMethod;
            this.args = args;
        }

        @Override
        public String toString() {
            return "Request{" +
                    "url='" + url + '\'' +
                    ", ip='" + ip + '\'' +
                    ", classMethod='" + classMethod + '\'' +
                    ", args='" + args + '\'' +
                    '}';
        }
    }

}
