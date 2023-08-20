package com.dagachi.app.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.dagachi.app.common.interceptor.AuthNullCheckInterceptor;
import com.dagachi.app.common.interceptor.LogInterceptor;

@Configuration
public class AppConfig implements WebMvcConfigurer {
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		//리소스 파일(스타일시트, 이미지 등)에 대한 요청을 로깅하지 않기 위한 것
		registry.addInterceptor(new LogInterceptor())
				.addPathPatterns("/**")
				.excludePathPatterns("/resources/**");
		
		//로그인이 필요한 요청에 대한 로그인 여부를 확인
		registry.addInterceptor(new AuthNullCheckInterceptor())
				.addPathPatterns("/**")
				.excludePathPatterns("/resources/**", "/member/memberLogin.do");
			
		
	}
	
}
