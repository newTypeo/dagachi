package com.dagachi.app.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.core.io.FileSystemResource;


import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.dto.MemberUpdateDto;
import com.dagachi.app.member.entity.CbcLike;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberLike;
import com.dagachi.app.member.entity.MemberProfile;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Validated
@SessionAttributes({"likeMe"})
@Slf4j
@RequestMapping("/member")
@Configuration
@ConfigurationProperties(prefix = "spring.mail")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
    private JavaMailSender javaMailSender;
	
	
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
		 	
		 	 // 회원 좋아요 전체 조회 후 화면에 노출시키기(현우)
			 List<MemberLike> likeMe = memberService.findAllLikeMe(loginMemberId);
			 model.addAttribute("likeMe",likeMe);
			 
			 // 찜 목록 화면에 노출시키기(현우)
			 List<ClubAndImage> clubLikeAndImages = clubService.findAllClubLike(loginMemberId);
//			 log.debug("이거 잘 들어왔어? {}", clubLikeAndImages);
			 model.addAttribute("clubLikeAndImages", clubLikeAndImages);
			 
	        return "member/memberDetail";
	        
	    }
	 
	 /**
	  * 회원 좋아요
	  * @author 현우 
	  */
	 @PostMapping("/memberLike.do")
	 public String memberLike(
			 @AuthenticationPrincipal MemberDetails loginMember,
			 @RequestParam String memberId,
			 Model model,
			 RedirectAttributes attr
			 ) {
		 String loginMemberId = loginMember.getMemberId();
		 
		 // 중복DB가 있을 경우, 있는 데이터 반환 없으면 0 반환
		 int checkDuplicate = memberService.checkDuplicateMemberId(memberId);
		 
		 Map<String, Object> params = Map.of(
				"memberId", memberId,
				"loginMemberId", loginMemberId
				 );
		 // 중복이 없는 경우 코드 실행
		 if(checkDuplicate == 0) {
			 int result = memberService.memberLike(params);			 
		 }

		 return "redirect:/member/" + memberId;
	 }
	 
	 @GetMapping("/searchId.do")
	 public void searchId() {}

	 
	 @PostMapping("/memberSearchId.do")
	 public String memberSearchId(
			 @RequestParam("email") String email,
			 Model model
			 ) {
		 log.debug("email = {} ",email);
		 
		 Member member = memberService.findmemberIdByEmail(email);
		 
		 if(member == null) {
			 String memberId = "없음";
			 model.addAttribute("memberId",memberId);
		 } else {
			 String memberId = member.getMemberId();
			 model.addAttribute("memberId",memberId);
		 }
		 
		 model.addAttribute("member",member);
		 model.addAttribute("email",email);
		 
		 return "/member/searchIdResult";
	 }
	 
	 @GetMapping("/searchPw.do")
	 public void searchPw() {}
	 
	 @GetMapping("/sendCode.do")
	 public ResponseEntity<?> sendVerificationCode(
			 @RequestParam("username") String username, 
             @RequestParam("email") String email
			 ){
		 
		 log.debug("가져오긴했냐? ={}", username);
		 log.debug("가져오긴했냐? ={}", email);
		 
		 Member member = memberService.findMemberByName(username);
		 Member member2 = memberService.findMemberByEmail(email);
		 log.debug("memberzzzzzzzzzzzz={}",member);
		 log.debug("member똑같냐?={}",member2);
		 String randomCode = null;
		 if(member != null && member2 != null && member.equals(member2)) {
			 // 입력받은 이름과 이메일이 db에 있는 정보와 일치할 시,
			 int min = 100000;
		     int max = 999999;
		     Random random = new Random();
		     int randomNumber = random.nextInt(max - min + 1) + min;
		     randomCode = String.valueOf(randomNumber);
		     
			 SimpleMailMessage message = new SimpleMailMessage();
			 message.setFrom("khsso102649@gmail.com");
			 message.setTo(email);
			 message.setSubject("인증코드 메일");
			 message.setText(randomCode);
			 
			 javaMailSender.send(message);
			 
			 
		 }else {
			 
			 randomCode = null;
			 
		 }
		 
		 return ResponseEntity.status(HttpStatus.OK).body(randomCode);
	 }
	 
//	 @PostMapping("/memberSearchPw.do")
//	 public String searchPwByCode(
//			 @RequestParam ("code") String code
//			 ) {
//		 
//		 
//		 return "";
//	 }
	 
	 
}
