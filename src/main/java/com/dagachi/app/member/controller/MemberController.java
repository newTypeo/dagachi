package com.dagachi.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Validated
//@RequestMapping("/member")
//@SessionAttributes({"loginMember"})
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	 @GetMapping("/{memberId}")
	    public String memberDetail(
	    		@PathVariable("memberId") String memberId,
	    		Model model,
	    		@AuthenticationPrincipal MemberDetails loginMember
	    		) {
		 	Member member = memberService.findMemberBymemberId(memberId);
		 
		 	model.addAttribute("member",member); // 내가 보고있는 상대방
		 	model.addAttribute("loginMember",loginMember); // 현재 로그인 되어있는 객체
	
	        return "member/memberDetail";
	    }
	
}
