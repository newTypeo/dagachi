package com.dagachi.app.member.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Validated
//@RequestMapping("/member")
//@SessionAttributes({"loginMember"})
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/memberCreate.do")
	public void memberCreate() {}
	
	/**
	 * $2a$10$LDOwiecU8H1aqMb19pEa0.LhJ.VKR5zV/YngckU4cOu0gMPqcbng.
	 * - 알고리즘 $2a$
	 * - 옵션 10$ round 숫자 (높으수록 보안성 증가, 속도/메모리 사용량 증가)
	 * - 랜덤솔트(22자리) LDOwiecU8H1aqMb19pEa0.
	 * - 해싱값(31자리) LhJ.VKR5zV/YngckU4cOu0gMPqcbng.
	 * 
	 * @param member
	 * @param bindingResult
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/memberCreate.do")
	public String memberCreate(
			@Valid MemberCreateDto member,
			BindingResult bindingResult, 
			RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		
		System.out.println(member);
		
		if(bindingResult.hasErrors()) {
			ObjectError error = bindingResult.getAllErrors().get(0);
			log.debug("에러띠");
		
			redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
			return "redirect:/member/memberCreate.do";
		} 

		System.out.println("1이다");
		
		
		String rawPassword = member.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		log.debug("{} -> {}", rawPassword, encodedPassword);
		member.setPassword(encodedPassword);
		
		System.out.println("됫냐?");
	
		
		int result = memberService.insertMember(member);
		redirectAttr.addFlashAttribute("msg", "🎉🎉🎉 회원가입을 축하드립니다.🎉🎉🎉");
		System.out.println("음");
		return "redirect:/";
		
	
		
		
	}
	

	
}
