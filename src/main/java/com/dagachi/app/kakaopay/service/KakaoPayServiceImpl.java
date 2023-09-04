package com.dagachi.app.kakaopay.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.dagachi.app.kakaopay.dto.KakaoApproveResponse;
import com.dagachi.app.kakaopay.dto.KakaoReadyResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class KakaoPayServiceImpl implements KakaoPayService {
	
	static final String cid = "TC0ONETIME"; // 가맹점 테스트코드 (가맹점x)
	static final String admin_key = "edd64d90a91f8f6a8eeaca0467e8905d"; // 어드민 키
	private KakaoReadyResponse kakaoReady;
	
	@Override
	public KakaoReadyResponse kakaoPayReady() {
		
		// 카카오페이 요청 양식
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
		parameters.add("cid", cid);
		parameters.add("partner_order_id", "partner_order_id");
		parameters.add("partner_user_id", "partner_user_id");
		parameters.add("item_name", "모임생성 1회권");
		parameters.add("quantity", "1");
		parameters.add("total_amount", "10000");
		parameters.add("tax_free_amount", "0");
		parameters.add("vat_amount", "200");
		parameters.add("approval_url", "http://localhost:8080/dagachi/payment/success");
		parameters.add("cancel_url", "http://localhost:8080/dagachi/payment/cancel");
		parameters.add("fail_url", "http://localhost:8080/dagachi/payment/fail");
		
		// 요청 header, 사용자입력값
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Authorization", "KakaoAK " + admin_key);
        httpHeaders.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        
        // 파라미터, 헤더
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, httpHeaders);
		
		RestTemplate restTemplate = new RestTemplate(); // 타서버로의 요청객체
        kakaoReady = restTemplate.postForObject(
                "https://kapi.kakao.com/v1/payment/ready",
                requestEntity,
                KakaoReadyResponse.class);
        
		return kakaoReady;
	}
	
	/**
     * 결제 완료 승인
     */
	public KakaoApproveResponse approveResponse(String pgToken) {
    
        // 카카오 요청
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("cid", cid);
        parameters.add("tid", kakaoReady.getTid());
        parameters.add("partner_order_id", "partner_order_id"); // 가맹점 주문 번호
        parameters.add("partner_user_id", "partner_user_id"); // 가맹점 회원 ID
        parameters.add("pg_token", pgToken);

        // 요청 header, 사용자입력값
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Authorization", "KakaoAK " + admin_key);
        httpHeaders.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        // 파라미터, 헤더
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, httpHeaders);
        // 외부에 보낼 url
        RestTemplate restTemplate = new RestTemplate();
        
        KakaoApproveResponse approveResponse = restTemplate.postForObject(
                "https://kapi.kakao.com/v1/payment/approve",
                requestEntity,
                KakaoApproveResponse.class);
        
                
        return approveResponse;
    }

	
}
