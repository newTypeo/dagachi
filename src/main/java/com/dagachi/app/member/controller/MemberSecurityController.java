package com.dagachi.app.member.controller;

import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.dto.MemberLoginDto;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberInterest;
import com.dagachi.app.member.entity.MemberProfile;
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
         @Valid MemberCreateDto _member,
         BindingResult bindingResult, 
         RedirectAttributes redirectAttr,
         @AuthenticationPrincipal MemberDetails member,
         @RequestParam(value = "upFile", required = false) MultipartFile upFile
         ) throws IllegalStateException, IOException {
       log.debug("냥 -> {}", member);
      
      if(bindingResult.hasErrors()) { //에러 나면 
         ObjectError error = bindingResult.getAllErrors().get(0);
         redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
         log.debug("오류 -> {}", member);
         return "redirect:/member/memberCreate.do"; 
      } 
      
      // 파일 저장 
 
      String uploadDir = "/memberProfile/";
      MemberProfile memberProfile = null;
		if(!upFile.isEmpty()) { 
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을 사용
			upFile.transferTo(destFile); // 실제파일 저장
		
			memberProfile = memberProfile.builder()
					.originalFilename(originalFilename)
					.renamedFilename(renamedFilename)
					.build();
		}
      String rawPassword = member.getPassword();
      String encodedPassword = passwordEncoder.encode(rawPassword);
      log.debug("회원가입 완료{} -> {}", rawPassword, encodedPassword);
      member.setPassword(encodedPassword);
      
      List<String> memberInterest = new ArrayList<>();
		for (String Interest : _member.getInterest().split(",")) {
			memberInterest.add(Interest);
		}
	
		ActivityArea activityArea = new ActivityArea();

  	// 2. db저장
      MemberDetails member1 = MemberDetails.builder()
				.memberId(_member.getMemberId())
				.password(_member.getPassword())
				.name(_member.getName())
				.nickname(_member.getMemberId())
				.phoneNo(_member.getPhoneNo())
				.email(_member.getMemberId())
				.birthday(_member.getBirthday())
				.gender(_member.getGender())
				.memberInterest(memberInterest)
				.memberProfile(memberProfile)
				.activityArea(activityArea)
				.build();
				
		
      int result = memberService.insertMember(member1);
      redirectAttr.addFlashAttribute("msg", "회원가입 완료");
      return "redirect:/";
   }

	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
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