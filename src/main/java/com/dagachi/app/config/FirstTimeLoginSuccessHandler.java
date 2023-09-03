package com.dagachi.app.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

public class FirstTimeLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // 최초 로그인 여부를 세션에 저장
        HttpSession session = request.getSession();
        session.setAttribute("isFirstTimeLogin", true);

        // 최초 로그인 여부를 세션에서 가져오기
        boolean isFirstTimeLogin = (boolean) session.getAttribute("isFirstTimeLogin");

        // 이후 로그인 시 최초 로그인 여부 업데이트
        if (isFirstTimeLogin) {
            session.setAttribute("isFirstTimeLogin", false);
        }

        // 이후 원하는 리다이렉션 또는 다른 처리를 수행
        // 예를 들어, 다음과 같이 리다이렉션할 수 있습니다.
        if (isFirstTimeLogin) {
            response.sendRedirect("/member/memberKakaoCreate.do");
        } else {
            // 최초 로그인이 아닌 경우 다른 로직 수행
            // 예를 들어, 기본 로그인 후 홈페이지로 리다이렉션
            response.sendRedirect("/");
        }
    }
}

