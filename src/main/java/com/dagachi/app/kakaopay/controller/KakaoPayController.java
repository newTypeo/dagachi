package com.dagachi.app.kakaopay.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dagachi.app.kakaopay.dto.KakaoApproveResponse;
import com.dagachi.app.kakaopay.dto.KakaoReadyResponse;
import com.dagachi.app.kakaopay.service.KakaoPayService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/payment")
@RequiredArgsConstructor
public class KakaoPayController {
	
	private final KakaoPayService kakaoPayService;
	
	/**
	 * 결제 요청
	 */
	@PostMapping("/ready")
	public KakaoReadyResponse readyToKakaoPay() {
		System.out.println("ready controller");
		return kakaoPayService.kakaoPayReady();
	}
	
	/**
     * 결제 성공
     */
    @GetMapping("/success")
    public void afterPayRequest(@RequestParam(name="pg_token", required=false) String pgToken) {
    	
    	System.out.println("pgToken = " + pgToken);
        KakaoApproveResponse kakaoApprove = kakaoPayService.approveResponse(pgToken);
//        System.out.println("kakaoApprove = " + kakaoApprove);

//        return new ResponseEntity<>(kakaoApprove, HttpStatus.OK);
    }
	
	@GetMapping("/cancel")
	public void cancel() {
		
		throw new RuntimeException();
	}
	
	@GetMapping("/fail")
	public void fail() {
		
		throw new RuntimeException();
	}
	
	
}
