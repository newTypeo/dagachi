package com.dagachi.app.common.interceptor;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

// HandlerInterceptor는 컨트롤러 의 메서드가 실행되기
// 전, 후, 또는 뷰(View)가 렌더링되기 전에 특정 작업을 수행하도록 하는 데 사용
public class LogInterceptor implements HandlerInterceptor{
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//메서드가 실행되기 전에 호출
		//요청(request)에 대한 로깅이 수행
		
		// true : 핸들러(컨트롤러) 메서드가 정상적으로 호출
		// false : 핸들러 메서드를 호출하지 않고 바로 afterCompletion 메서드가 호출
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mav) throws Exception {
		//ModelAndView 객체에 대한 처리
		//ModelAndView 객체의 내용을 로그에 출력하거나 필요한 작업을 수행
		if(mav != null) {
			Map<String, Object> model = mav.getModel();
			String viewName = mav.getViewName();
		}
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//HandlerInterceptor구현 클래스를 사용하면, 컨트롤러의 메서드 실행 전후에 특정 작업을 수행할 수 있으며
		//요청,응답 대한 로깅 및 각종 전처리 및 후처리 작업
	}

}
