package com.dagachi.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;

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
	



	
}
