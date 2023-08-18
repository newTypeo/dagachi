package com.dagachi.app.member.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.dto.MemberLoginDto;
import com.dagachi.app.member.entity.Member;
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
	
	@PostMapping("/memberCreate.do")
	public String memberCreate(
			@Valid MemberCreateDto member,
			BindingResult bindingResult, 
			RedirectAttributes redirectAttr) {

		if(bindingResult.hasErrors()) {
			ObjectError error = bindingResult.getAllErrors().get(0);
			redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
			return "redirect:/member/memberCreate.do";
		} 
		
		String rawPassword = member.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setPassword(encodedPassword);
		
		int result = memberService.insertMember(member);
		redirectAttr.addFlashAttribute("msg", "🎉🎉🎉 회원가입을 축하드립니다.🎉🎉🎉");
		return "redirect:/";
	}
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {
	
	}
	
	@PostMapping("/memberLogin.do")
	public String memberLogin(	
			@Valid MemberLoginDto _member,
			BindingResult bindingResult, 
			Model model
			) {
		
				Member member = memberService.findMemberById(_member.getMemberId());
				if(member != null && passwordEncoder.matches(_member.getPassword(), member.getPassword())) {
					model.addAttribute("loginMember", member);
				}
				else {
					return "redirect:/member/memberLogin.do?error";
				}
				return "redirect:/";
		
	}
	
	

	
}
