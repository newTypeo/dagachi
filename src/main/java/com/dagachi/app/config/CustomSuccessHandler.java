package com.dagachi.app.config;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.dagachi.app.member.entity.MemberDetails;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @see <a href="https://www.baeldung.com/spring_redirect_after_login">Redirect to Different Pages after Login with Spring Security</a>
 *
 */
@Slf4j
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

   @Getter
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    
    //인증에 성공했을 때 호출되며, 이 때 사용자의 인증 정보를 파라미터로 받는다.
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
      throws IOException {
       MemberDetails member = (MemberDetails) authentication.getPrincipal();
       
       String targetUrl = "/";
       // if member information is not found, then redirect to creating kakao user page
       if(
             member == null ||
             member.getActivityArea().getMainAreaId() == null ||
             member.getMemberInterest().isEmpty() ||
             member.getMemberInterest().get(0).getInterest() == null ||
             member.getMemberProfile().getCreatedAt() == null
       ) {
          targetUrl = "/member/memberKakaoCreate.do";
       }
        if (response.isCommitted()) {
           return;
        }
        getRedirectStrategy().sendRedirect(request, response, targetUrl);

    }
   
}