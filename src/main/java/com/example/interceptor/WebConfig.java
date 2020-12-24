package com.example.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 配置拦截器
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {


    //添加拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/admin/**")
                .excludePathPatterns("/admin").excludePathPatterns("/admin/login");
        // addPathPatterns 添加拦截路径    excludePathPatterns 排除拦截路径
    }
}
