package com.dagachi.app.kakaopay.service;

import org.springframework.http.ResponseEntity;

import com.dagachi.app.kakaopay.dto.KakaoApproveResponse;
import com.dagachi.app.kakaopay.dto.KakaoReadyResponse;

public interface KakaoPayService {

	KakaoReadyResponse kakaoPayReady();

	KakaoApproveResponse approveResponse(String pgToken);
	
}
