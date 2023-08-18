package com.dagachi.app.member.controller;

import java.io.Console;
import java.util.Collection;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.dto.MemberLoginDto;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@Validated
@RequestMapping("/member")
public class MemberSecurityController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/memberCreate.do")
	public void memberCreate() {}
	
	@PostMapping("/memberCreate.do")
	public String create(
			@Valid MemberCreateDto member,
			BindingResult bindingResult, 
			RedirectAttributes redirectAttr) {
		
		if(bindingResult.hasErrors()) { //에러 나면 
			ObjectError error = bindingResult.getAllErrors().get(0);
			redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
			return "redirect:/member/memberCreate.do";
		} 
		
		String rawPassword = member.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		log.debug("{} -> {}", rawPassword, encodedPassword);
		member.setPassword(encodedPassword);
		
		int result = memberService.insertMember(member);
		redirectAttr.addFlashAttribute("msg", "회원가입 완료");
		return "redirect:/";
	}

	@GetMapping("/memberLogin.do")
	public void memberLogin(Authentication authentication) {
		log.debug("authentication = {}", authentication);
//		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
//		log.debug("principal = {}", principal);
	}
	
//	@PostMapping("/memberLogin.do") 
//	public String memberLogin(	
//			@Valid MemberLoginDto _member,
//			BindingResult bindingResult, 
//			Model model
//			) {
//		
//				Member member = memberService.findMemberById(_member.getMemberId());
//				
//				log.debug("member = {}", member);
//				
//				if(member != null && passwordEncoder.matches(_member.getPassword(), member.getPassword())) {
//					model.addAttribute("loginMember", member);
//					log.debug("member = {}", member);
//				}
//				else {
//					return "redirect:/";
//				}
//				return "redirect:/";
//		
//	}
	
	//회원 아이디 중복 여부를 확인하기 위해 사용하는 코드 
	@GetMapping("/checkIdDuplicate.do")
	@ResponseBody
	public ResponseEntity<?> checkIdDuplicate(@RequestParam String memberId) {
		boolean available = false;
		try {
			UserDetails memberDetails = memberService.loadUserByUsername(memberId);
		} catch (UsernameNotFoundException e) {
			available = true;
		}
		
		return ResponseEntity
				.status(HttpStatus.OK)
				.body(Map.of("available", available, "memberId", memberId));
	}
	 
}

