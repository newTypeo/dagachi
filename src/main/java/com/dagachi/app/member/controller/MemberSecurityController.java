package com.dagachi.app.member.controller;

import static com.dagachi.app.common.DagachiUtils.kakaoMapApi;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.dto.MemberKakaoUpdateDto;
import com.dagachi.app.member.dto.MemberUpdateDto;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberInterest;
import com.dagachi.app.member.entity.MemberProfile;
import com.dagachi.app.member.service.MemberService;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

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
	public String create(@Valid MemberCreateDto member, BindingResult bindingResult, RedirectAttributes redirectAttr,
			@RequestParam String interests) throws UnsupportedEncodingException {
	
		if(bindingResult.hasErrors()) {
			ObjectError error = bindingResult.getAllErrors().get(0);
			redirectAttr.addFlashAttribute("msg", "다시 확인하고 입력하세요");
			return "redirect:/member/memberCreate.do";
		} 
	    
		JsonArray documents = kakaoMapApi(member.getMainAreaId(), "address"); 
	    JsonElement document = documents.getAsJsonArray().get(0);
	    JsonObject item = document.getAsJsonObject();
	    JsonObject params = item.get("address").getAsJsonObject();
	    String bCode = params.get("b_code").getAsString();
	    log.debug("documents ={}",documents);
	    log.debug("document ={}",document);
	    log.debug("item ={}",item);
	    log.debug("params ={}",params);
	    log.debug("bCode ={}",bCode);
	 
	    String rawPassword = member.getPassword();
	    String encodedPassword = passwordEncoder.encode(rawPassword);
	    
	    
	    List<String> interest = Arrays.asList(interests.split(","));
	    member.setInterest(interest);
	    member.setPassword(encodedPassword);
	    member.setMainAreaId(bCode);
	    int result = memberService.insertMember(member);
	    return "redirect:/";
	}

	@GetMapping("/memberKakaoCreate.do")
	public String kakaoUpadteCreate(@AuthenticationPrincipal MemberDetails loginMember) {
	        return "member/memberKakaoCreate";
	    }
	

	@PostMapping("/memberKakaoCreate.do")
	public String kakaoUpadteCreate(@AuthenticationPrincipal MemberDetails _member,
	        @Valid MemberKakaoUpdateDto member, BindingResult bindingResult, RedirectAttributes redirectAttr,
	        @RequestParam String interests, HttpServletRequest request) throws UnsupportedEncodingException {

	    JsonArray documents = kakaoMapApi(member.getMainAreaId(), "address");
	    JsonElement document = documents.getAsJsonArray().get(0);
	    JsonObject item = document.getAsJsonObject();
	    JsonObject params = item.get("address").getAsJsonObject();
	    String bCode = params.get("b_code").getAsString();

	    // 사용자 정보 업데이트 (예: 이메일 업데이트)
	    String userId = _member.getMemberId(); // 사용자 ID 가져오기
	    String newEmail = "new_email@example.com"; // 새 이메일 정보 설정


	    List<String> interest = Arrays.asList(interests.split(","));
	    member.setInterest(interest);
	    member.setMainAreaId(bCode);
	    member.setMemberId(_member.getMemberId());
	    int result = memberService.kakaoUpadteCreate(member);

	    // Principal 업데이트
	    
	    _member.setMemberProfile(new MemberProfile());
	    _member.getMemberProfile().setRenamedFilename("default.png");

	    // SecurityContext 업데이트
	    Authentication authentication = new UsernamePasswordAuthenticationToken(_member, _member.getPassword(), _member.getAuthorities());

	    // Spring Security 로그아웃 수행
	    request.getSession().invalidate();

	    // 로그아웃 후 리디렉션
	    return "redirect:/member/memberlogin.do";
	}

		
	
	
	@GetMapping("/memberAdminInquiry.do")
	public void InquiryCreate() {
	}

	@GetMapping("/memberAdminInquiryList.do")
	public String inquiryList(Model model) {
		List<AdminInquiry> inquiry = new ArrayList<>();
		inquiry = memberService.memberAdminInquiryList();
		model.addAttribute("inquiry", inquiry);
		return "member/memberAdminInquiryList";
	}

	@PostMapping("/memberAdminInquiry.do")
	public String InquiryCreate(@Valid AdminInquiryCreateDto inquiry, @AuthenticationPrincipal MemberDetails member) {
		inquiry.setMemberId(member.getMemberId());
		int result = memberService.InquiryCreate(inquiry);
		return "redirect:/member/memberAdminInquiryList.do";
	}
	

	@GetMapping("/memberLogin.do")
	public void memberLogin() {}

	/**
	 * 로그인 시 principal에 추가 정보 삽입
	 * @author 동찬
	 */
	@PostMapping("/memberLoginSuccess.do")
	public String memberLoginSuccess(@AuthenticationPrincipal MemberDetails memberDetails, HttpSession session) {
		String memberId = memberDetails.getMemberId();
		ActivityArea activityArea = memberService.findActivityAreaById(memberId);
		MemberProfile profile = memberService.findMemberProfile(memberId);
		List<MemberInterest> interests = memberService.findMemberInterestsByMemberId(memberId);
		List<ClubMember> clubMembers = memberService.findClubMemberByMemberId(memberId);

		memberDetails.setMemberProfile(profile);
		memberDetails.setClubMember(clubMembers);
		memberDetails.setMemberInterest(interests);
		memberDetails.setActivityArea(activityArea);
		
		log.debug("memberDetails = {}", memberDetails);
		
		// 리다이렉트 처리
		SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		String location = savedRequest == null ? "/" : savedRequest.getRedirectUrl();
//		log.debug("location = {}", location);
		return "redirect:" + location;
	}

	// 회원 아이디 중복 여부를 확인하기 위해 사용하는 코드
	@GetMapping("/checkIdDuplicate.do")
	@ResponseBody
	public ResponseEntity<?> checkIdDuplicate(@RequestParam String memberId) {
		boolean available = false;
		try {
			UserDetails memberDetails = memberService.loadUserByUsername(memberId);
		} catch (UsernameNotFoundException e) {
			available = true;
		}
		return ResponseEntity.status(HttpStatus.OK).body(Map.of("available", available, "memberId", memberId));
	}
	
	
	// 카카오톡 아이디 확인 
	@GetMapping("/checkKakao.do")
	@ResponseBody
	public ResponseEntity<?> checkKakao(@RequestParam String memberId) {
		boolean available = false;
		try {
			int memberDetails = memberService.checkKakao(memberId);
		} catch (UsernameNotFoundException e) {
			available = true;
		}
		return ResponseEntity.status(HttpStatus.OK).body(Map.of("available", available, "memberId", memberId));
	}
	

	@PostMapping("memberDelete.do")
	public String memberDelete(@AuthenticationPrincipal MemberDetails member) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		int result = memberService.memberDelete(member.getMemberId());
		if (authentication != null) {
			SecurityContextHolder.clearContext(); // 인증 정보 삭제
		}
		return "redirect:/";
	}

	@GetMapping("/memberUpdate.do")
	public String memberUpdate(@AuthenticationPrincipal MemberDetails loginMember, Model model) {
		String id = loginMember.getMemberId();
		MemberProfile profile = memberService.findMemberProfile(id);
		model.addAttribute("profile", profile);
		model.addAttribute("loginMember", loginMember);
		return "/member/memberUpdate";
	}

	/**
	  * 회원 정보수정
	  * @author 준한
	  */
	@PostMapping("/memberUpdate.do")
	public String memberUpdate(@AuthenticationPrincipal MemberDetails loginMember,
			@RequestParam(value = "upFile") MultipartFile upFile, @Valid MemberUpdateDto _member,
			BindingResult bindingResult) throws IllegalStateException, IOException {
		String uploadDir = "/member/profile/";
		MemberProfile memberProfile = null;
		if (!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
			File destFile = new File(uploadDir + renamedFilename);

			upFile.transferTo(destFile);

			memberProfile = MemberProfile.builder().memberId(loginMember.getMemberId())
					.originalFilename(originalFilename).renamedFilename(renamedFilename).build();

			int result = memberService.updateMemberProfile(memberProfile);
			
			// 프로필사진 업데이트시 principal객체 업데이트
			if(result != 0)
				loginMember.getMemberProfile().setRenamedFilename(renamedFilename);
		}

		Member member = Member.builder().memberId(loginMember.getMemberId()).name(_member.getName())
								.nickname(_member.getNickname()).phoneNo(_member.getPhoneNo()).address(_member.getAddress())
								.gender(_member.getGender()).mbti(_member.getMbti()).birthday(_member.getBirthday()).build();

		int result2 = memberService.UpdateMember(member);

		return "redirect:/member/" + member.getMemberId();
	}

		

}