package com.dagachi.app.oauth.service;

import java.util.Map;

public interface kakaoservice {

public interface KakaoService {

	String getAuthorizeUri();

	Map<String, Object> getTokens(String code);

	/**
	 * accessToken으로 사용자정보 요청하기
	 */
	Map<String, Object> getProfile(String accessToken);

}

}
