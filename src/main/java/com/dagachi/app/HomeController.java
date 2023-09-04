package com.dagachi.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import com.dagachi.app.member.entity.MemberDetails;

import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("")
	// @ResponseBody // 응답메세지에 리턴객체 출력 (viewName으로 사용하지 않음)
	public String home(@AuthenticationPrincipal MemberDetails member) {
		
		if(member != null) {
			int checkKakao = memberService.checkKakao(member.getMemberId());
			if(checkKakao == 1) {
				return "redirect:/member/memberKakaoCreate.do";
			}else {
				return "forward:/index.jsp";
			}			
			
		}

		
		//		log.info("home!");
		return "forward:/index.jsp"; // forward: 접두사를 사용하면, /WEB-INF/viewx/...jsp 경로가 아닌 주어진 경로 view단 연결
	
	}
}
