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

@SuppressWarnings("deprecation")
@EnableWebSecurity // @Configuration 상속
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
//	@Autowired
//	private UserDetailsService memberService;
//	
//	@Autowired
//	private OAuth2UserService oauth2UserService;
	
	@Autowired
	private DataSource dataSource;
	
	@Bean
	public PersistentTokenRepository tokenRepository() {
		JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
		tokenRepository.setDataSource(dataSource);
		return tokenRepository;
	}
	
	/**
	 * 실제 인증/인가를 담당하는 AuthenticationManager에 대한 설정
	 * - in memory
	 * - db 사용자
	 */
//	@Override
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//
//		auth.userDetailsService(memberService).passwordEncoder(passwordEncoder());
//
//	}
	
	/**
	 * - anonymous
	 * - authenticated
	 * - permitAll
	 * - hasRole/hasAuthority
	 * 
	 * 인증/인가 설정
	 * 폼로그인/로그아웃
	 * ...
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/", "/**").permitAll()
			.anyRequest().authenticated();
		
		http.formLogin() // 
			.permitAll();
		
		http.logout()
			.logoutUrl("/member/memberLogout.do")
			.logoutSuccessUrl("/")
			.permitAll();

	
	}
	
	/**
	 * security bypasss 경로 지정
	 * - static파일 (js, css, images,...)
	 */
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().mvcMatchers("/resources/**");  
	}
	
	
	
	
}
