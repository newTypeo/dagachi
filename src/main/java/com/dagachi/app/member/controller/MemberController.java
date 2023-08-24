package com.dagachi.app.member.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberProfile;
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
		 	MemberProfile memberProfile = memberService.findMemberProfile(memberId); 

		 	model.addAttribute("memberProfile",memberProfile);
		 	model.addAttribute("member",member);
		 	model.addAttribute("loginMember",loginMember);
		 	String loginMemberId = loginMember.getMemberId();
		 	
		 	List<ClubAndImage> clubAndImages = new ArrayList<>();
		 	clubAndImages = clubService.recentVisitClubs(loginMemberId);
		 	
		 	
//		 	log.debug("잘 들어왔니? = {}", clubAndImages);
		 	model.addAttribute("clubAndImages",clubAndImages);
		 	
		 	List<ClubAndImage> joinClub = clubService.searchJoinClub(member.getMemberId());
		 	model.addAttribute("joinClub",joinClub);
	        return "member/memberDetail";
	    }
	 
	 
	
	
}
