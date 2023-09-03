package com.dagachi.app.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class FirstTimeLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
        boolean isFirstTimeLogin = checkIfFirstTimeLogin(authentication);

        if (isFirstTimeLogin) {
            // 최초 로그인 시
            getRedirectStrategy().sendRedirect(request, response, "/member/memberKakaoCreate.do");
        } else {
            // 그 이후 
            super.onAuthenticationSuccess(request, response, authentication);
        }
    }

    private boolean checkIfFirstTimeLogin(Authentication authentication) {
        // 여기에 최초 로그인 여부를 확인하는 로직을 구현합니다.
        // 세션, 데이터베이스 등을 사용하여 구현할 수 있습니다.
        // 예를 들어 세션에 "firstTimeLogin" 플래그를 저장하고 이를 확인하는 방법이 있습니다.
        // 실제 사용하는 방법에 따라 구현이 달라집니다.
        // 여기서는 예시로 true를 반환하도록 합니다.
    	
        return true;
    }
}
