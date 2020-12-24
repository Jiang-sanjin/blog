package com.example.handler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 拦截所有异常  进行统一异常处理
 */



@ControllerAdvice   //拦截所有Controller注解   实现全局异常处理
public class ControllerExceptionHandler {


    private final Logger logger = LoggerFactory.getLogger(this.getClass());   //获取日志记录器



    @ExceptionHandler(Exception.class)   // ExceptionHandler 用来指明异常的处理类型    拦截Exception级别的异常
    public ModelAndView exceptionHander(HttpServletRequest request, Exception e) throws Exception {
        //记录异常信息
        logger.error("Requst URL : {}，Exception : {}", request.getRequestURL(),e);


        //判断是否存在  状态码  存在即抛给springboot自行处理    传递异常类和状态
        if (AnnotationUtils.findAnnotation(e.getClass(), ResponseStatus.class) != null) {
            throw e;
        }

        ModelAndView mv = new ModelAndView();
        mv.addObject("url",request.getRequestURL());
        mv.addObject("exception", e);
        mv.setViewName("error/error");
        return mv;
    }
}
