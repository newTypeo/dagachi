package com.dagachi.app.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.dagachi.app.member.entity.MemberDetails;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class AuthNullCheckInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		SecurityContext securityContext = SecurityContextHolder.getContext();
		Authentication authentication = securityContext.getAuthentication();
		//인증 정보 중에서 principal 객체 가져옴,
		//principal 객체가 MemberDetails 클래스의 인스턴스인 경우 == 사용자가 로그인한 경우를 의미
		Object principal = authentication.getPrincipal();
		//사용자가 로그인한 경우, MemberDetails로 캐스팅
		// member.getMemberId()를 사용하여 사용자의 아이디 정보를 확인
		log.debug("principal = {}", principal);
		if(principal instanceof MemberDetails) {
			MemberDetails member = (MemberDetails) principal;
			if(member.getMemberId() == null) {
				//아이디 null == 사용자를 로그인 페이지로 리다이렉트
				//false 반환 컨트롤러 메서드의 호출을 방지
				response.sendRedirect(request.getContextPath() + "/member/memberLogin.do");
				return false; // handler호출 없이 afterCompletion처리후 응답.
			}
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}

