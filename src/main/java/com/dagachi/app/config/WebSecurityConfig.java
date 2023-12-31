package com.dagachi.app.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import java.security.SecureRandom;
import java.util.Base64;

@SuppressWarnings("deprecation")
@EnableWebSecurity 
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
   
   @Bean
   public PasswordEncoder passwordEncoder() {
      return new BCryptPasswordEncoder();
   }
   
   @Autowired
   private UserDetailsService memberService;
   
   @Autowired
   private OAuth2UserService oauth2UserService;
   
   @Autowired
   private DataSource dataSource;
   
   @Bean
   public PersistentTokenRepository tokenRepository() {
      JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
      tokenRepository.setDataSource(dataSource);
      return tokenRepository;
   }
   
   @Override
   protected void configure(AuthenticationManagerBuilder auth) throws Exception {
      auth.userDetailsService(memberService).passwordEncoder(passwordEncoder());
   }

   @Override
   protected void configure(HttpSecurity http) throws Exception {
      http.authorizeRequests()
         .antMatchers("/", "/index.jsp", "/club/categoryList.do", "/club/clubList.do", "/club/findAddress.do",
        		"/searchPw.do","/member/searchIdResult.jsp","/searchIdResult.jsp", "/member/memberCreate.do",
        		"/member/sendCode.do", "/member/checkNicknameDuplicate.do", "/member/checkIdDuplicate.do",
	            "/member/checkEmailDuplicate.do", "/memberSearchId.do","/member/memebrInsertEmail.do",
	            "/admin/mainBannerList.do", "/club/clubSearch.do", "/club/searchClubWithFilter.do", 
	            "/member/searchPw.do","/member/sendCode.do","/member/memberPwUpdate.jsp",
	            "/sendCode.do","/searchPw.do","/member/memberPwUpdate.do",
	            "/member/searchId.do","/member/memberSearchId.do",
               	"/member/{email}/memberPwUpdate.do").permitAll() //요청은 모든 사용자에게 허용
         .antMatchers("/member/memberLogin.do","/member/searchId.do","/member/searchPw.do").anonymous()
         .antMatchers("/admin/**").hasAuthority("ADMIN")
         .anyRequest().authenticated(); //(로그인한) 사용자에게만 허용된다는 것을 의미
      http.headers()
            .contentSecurityPolicy("frame-ancestors 'self' http://localhost:8080/*");
      
      
      // /login
      http.formLogin()
         .loginPage("/member/memberLogin.do") // 내가 만든 로그인 페이지 
         .loginProcessingUrl("/member/memberLogin.do") // 동일한 url 을 post로 날림
         .successForwardUrl("/member/memberLoginSuccess.do")
         .usernameParameter("memberId") // 기본 파라미터 바꿈
         .passwordParameter("password") // 똑같으면 그냥 안적어도 된다
         .permitAll(); // 모두 허용해달라
      
      // logout
      http.logout()
         .logoutUrl("/member/memberLogout.do") /// 로그아웃 url 연결
         .logoutSuccessUrl("/")
         .permitAll();
      
      // 보안상의 이유로 key값 무작위로 받아오는 코드부분
      SecureRandom random = new SecureRandom(); 
      byte[] keyBytes = new byte[64];
       random.nextBytes(keyBytes);
      String generatedKey = Base64.getUrlEncoder().withoutPadding().encodeToString(keyBytes);
      
      http.rememberMe()
          .tokenRepository(tokenRepository())
          .key(generatedKey)
//          .key("hello-springboot-secret")
          .tokenValiditySeconds(60 * 60 * 24 * 14); // 2주
      
      http.oauth2Login()
         .loginPage("/member/memberLogin.do")
//         .loginProcessingUrl("/member/memberLogin.do")
         .successHandler(customSuccessHandler())
//         .successHandler(successHandler)
         .userInfoEndpoint()
         .userService(oauth2UserService);
   }
   
   @Bean
   public AuthenticationSuccessHandler customSuccessHandler() {
      return new CustomSuccessHandler();
   }
   
   @Override // security bypasss 경로 지정
   public void configure(WebSecurity web) throws Exception {
      web.ignoring().mvcMatchers("/resources/**");  
   }
   
}