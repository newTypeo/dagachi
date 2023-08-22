package com.dagachi.app.oauth.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AccessToken;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class Oauth2UserServiceImpl extends DefaultOAuth2UserService {
	
	@Autowired
	private MemberService memberService;
	
	
	// 카카오톡 로그인 
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		ClientRegistration clientRegistration = userRequest.getClientRegistration(); // IDP
		OAuth2AccessToken accessToken = userRequest.getAccessToken();
		OAuth2User oauth2User = super.loadUser(userRequest);
		
		Map<String, Object> attributes = oauth2User.getAttributes();
		String memberId = attributes.get("id") + "@kakao";
		MemberDetails member = null;
	
		// 기존회원 가입여부 조회 (회원가입처리)
		try {
			member = (MemberDetails) memberService.loadUserByUsername(memberId);
		} catch (UsernameNotFoundException ignore) {
			Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
			Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
			
		
		}
		
		return member;
	}

}
