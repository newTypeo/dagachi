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
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import java.security.SecureRandom;
import java.util.Base64;




@SuppressWarnings("deprecation")
@EnableWebSecurity // @Configuration 상속
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
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/", "/**").permitAll()
			.anyRequest().authenticated();
		
		// /login
		http.formLogin()
			.loginPage("/member/memberLogin.do") // 내가 만든 로그인 페이지 
			.loginProcessingUrl("/member/memberLogin.do") // 동일한 url 을 post로 날림
			.usernameParameter("memberId") // 기본 파라미터 바꿈
			//.passwordParameter("password") // 똑같으면 그냥 안적어도 된다
			.defaultSuccessUrl("/")
			.permitAll(); // 모두 허용해달라
		
		
		// logout
		http.logout()
			.logoutUrl("/member/memberLogout.do") /// 로그아웃 url 연결
			.logoutSuccessUrl("/"); 
		
		
		SecureRandom random = new SecureRandom(); // 보안상의 이유로 key값 무작위로 받아오는 코드부분
		byte[] keyBytes = new byte[64];
		random.nextBytes(keyBytes);
		String generatedKey = Base64.getUrlEncoder().withoutPadding().encodeToString(keyBytes);

		http.rememberMe()
		    .tokenRepository(tokenRepository())
		    .key(generatedKey)
		    .tokenValiditySeconds(60 * 60 * 24 * 14); // 2주
		
		http.oauth2Login()
			.loginPage("/member/memberLogin.do")
			.userInfoEndpoint()
			.userService(oauth2UserService);
	}
	
	
	/**
	 * security bypasss 경로 지정
	 * - static파일 (js, css, images,...)
	 */
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().mvcMatchers("/resources/**");  
	}
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberService).passwordEncoder(passwordEncoder());
	}

	
	
	
	
}
