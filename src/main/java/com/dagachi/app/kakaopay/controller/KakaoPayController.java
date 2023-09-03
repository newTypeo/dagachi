package com.dagachi.app.kakaopay.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dagachi.app.kakaopay.dto.KakaoApproveResponse;
import com.dagachi.app.kakaopay.dto.KakaoReadyResponse;
import com.dagachi.app.kakaopay.service.KakaoPayService;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.service.MemberService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/payment")
@RequiredArgsConstructor
public class KakaoPayController {
	
	@Autowired
	private MemberService memberService;
	
	private final KakaoPayService kakaoPayService;
	
	
	/**
	 * 결제 요청
	 */
	@PostMapping("/ready")
	public KakaoReadyResponse readyToKakaoPay() {
		return kakaoPayService.kakaoPayReady();
	}
	
	/**
     * 결제 성공
     */
    @GetMapping("/success")
    public ResponseEntity<?> afterPayRequest(
    		@RequestParam(name="pg_token", required=false) String pgToken,
    		@AuthenticationPrincipal MemberDetails member) {
    	
        KakaoApproveResponse kakaoApprove = kakaoPayService.approveResponse(pgToken);
//        System.out.println("kakaoApprove = " + kakaoApprove);
        String memberId = member.getMemberId();
        
        int result = memberService.buyCreateClubTicket(memberId);
        return ResponseEntity.status(HttpStatus.OK).body("<script>"
											        	   + "alert('결제가 완료되었습니다.');"
											        	   + "window.close();"
										        	   + "</script>");
        
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
