package com.dagachi.app.member.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.dto.MemberPwUpdateDto;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberLike;
import com.dagachi.app.member.entity.MemberProfile;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@Controller
@Configuration
@RequestMapping("/member")
@SessionAttributes({"likeMe"})
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
	
	 /**
	  * 멤버 상세정보
	  * @author 준한 
	  */
	 @GetMapping("/{memberId}")
	    public String memberDetail(
	    		Model model,
	    		@PathVariable("memberId") String memberId,
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
	  * 회원 관심표시 
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
		 Map<String, Object> params = Map.of(
				 "memberId", memberId,
				 "loginMemberId", loginMemberId
				 );
		 int checkDuplicate = memberService.checkDuplicateMemberId(memberId);
		 int checkDuplicated = memberService.checkDuplicateMemberIdAndMyId(params);
		 // 중복이 없는 경우 코드 실행
		 if(checkDuplicated == 0) {
			 int result = memberService.memberLike(params);			 
		 }

		 return "redirect:/member/" + memberId;
	 }
	 
	 /**
	  * 회원 관심표시 중복체크 
	  * @author 현우
	  */
	 @GetMapping("memberLikeCheck.do")
	 public ResponseEntity<?> memberLikeCheck(
			 @RequestParam String memberId,
			 @AuthenticationPrincipal MemberDetails loginMember) {
		 String loginMemberId = loginMember.getMemberId();
		 Map<String, Object> params = Map.of(
				 "memberId", memberId,
				 "loginMemberId", loginMemberId
				 );
		 int checkDuplicate = memberService.checkDuplicateMemberId(memberId);
		 int checkDuplicated = memberService.checkDuplicateMemberIdAndMyId(params);
		 
		 boolean memberLikeCheck = checkDuplicated != 0 ? true : false;
				 
		 return ResponseEntity.status(HttpStatus.OK).body(memberLikeCheck);
	 }
	 
	 /**
	  * 회원 관심표시 취소 
	  * @author 현우
	  */
	 @PostMapping("/deleteMemberLike.do")
	 public String deleteMemberLike(
			 @AuthenticationPrincipal MemberDetails loginMember,
			 @RequestParam String memberId
			 ){
		 String loginMemberId = loginMember.getMemberId();
		 
		 Map<String, Object> params = Map.of(
					"memberId", memberId,
					"loginMemberId", loginMemberId
					 );
		 
		 int result = memberService.cancelMemberLike(params);
		 
		 return "redirect:/member/" + memberId;
				 
		 
	 }

	 @GetMapping("/searchId.do")
	 public void searchId() {}

	 
	 /**
	 * 아이디 찾기
	 * @author 김준한
	 */
	@PostMapping("/memberSearchId.do")
	 public String memberSearchId(
			 @RequestParam("email") String email,
			 Model model
			 ) {
		 
		 Member member = memberService.findmemberIdByEmail(email);
		 
		 if(member == null) {
			 String memberId = "없음";
			 model.addAttribute("memberId",memberId);
		 } else {
			 String memberId = member.getMemberId();
			 String maskedMemberId = memberId.substring(0, 3) + "*".repeat(memberId.length() - 3);
			 
			 model.addAttribute("memberId",maskedMemberId);
			 
			 
		 }
		 
		 model.addAttribute("member",member);
		 model.addAttribute("email",email);
		 
		 return "/member/searchIdResult";
	 }
	 
	 @GetMapping("/searchPw.do")
	 public void searchPw() {}
	 
	 /**
	  * @author 김준한
	  * 이메일로 6자리 랜덤코드생성해서
	  * 코드 보내기
	  */
	@GetMapping("/sendCode.do")
	public ResponseEntity<?> sendVerificationCode(
			 @RequestParam("username") String username, 
             @RequestParam("email") String email
			 ){
		 
		 Member member = memberService.findMemberByName(username);
		 Member member2 = memberService.findMemberByEmail(email);
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
			 message.setSubject("다가치 홈페이지 인증코드 메일");
			 message.setText(randomCode);
			 
			 javaMailSender.send(message);
			 
		 }else {
			 randomCode = null;
		 }
		 return ResponseEntity.status(HttpStatus.OK).body(randomCode);
	 }
	
	 /**
	  * @author 김나영
	  * 회원가입 이메일 인증 코드 
	  */
	@GetMapping("/memebrInsertEmail.do")
	public ResponseEntity<?> memebrInsertEmail(
            @RequestParam("email") String email
			 ){
		 
		 Member member2 = memberService.findMemberByEmail(email);
		 String randomCode = null;
		 if(member2 == null) {
			 // 입력받은 이름과 이메일이 db에 있는 정보와 일치할 시,
			 int min = 100000;
		     int max = 999999;
		     Random random = new Random();
		     int randomNumber = random.nextInt(max - min + 1) + min;
		     randomCode = String.valueOf(randomNumber);
		     
			 SimpleMailMessage message = new SimpleMailMessage();
			 message.setFrom("khsso102649@gmail.com");
			 message.setTo(email);
			 message.setSubject("다가치 홈페이지 인증코드 메일");
			 message.setText(randomCode);
			 
			 javaMailSender.send(message);
			 
		 }else {
			 randomCode = null;
		 }
		 return ResponseEntity.status(HttpStatus.OK).body(randomCode);
	 }
	 
	
	 /**
	  * @author 김나영
	  *닉네임/이메일 중복 검사
	  */
	@GetMapping("/checkNicknameDuplicate.do")
	@ResponseBody
	public ResponseEntity<?> checkNicknameDuplicate(@RequestParam("nickname") String nickname){
		 System.out.println("nickname" + nickname);
		 Member _nickname = memberService.checkNickNameDuplicate(nickname);
		 System.out.println("nicknamenicknamenickname" + _nickname);
		 boolean available = false; 
		 if(_nickname == null) {
				 available = true;
		 }else {
				 available = false;
		 }
		 System.out.println("이메알" + available);
			return ResponseEntity.status(HttpStatus.OK).body(Map.of("available", available));
	}
	
	@GetMapping("/checkEmailDuplicate.do")
	@ResponseBody
	public ResponseEntity<?> checkEmailDuplicate(@RequestParam("email") String email){
		System.out.println("바바바"+email);
		 Member _email = memberService.checkEmailDuplicate(email);
		 boolean available = false; 

		 if(_email == null) {
				 available = true;
		 }else {
				 available = false;
		 }
			return ResponseEntity.status(HttpStatus.OK).body(Map.of("available", available));
	}
	
	@RequestMapping("{email}/memberPwUpdate.do")
	public String updateMemberPassword(
			@PathVariable("email") String email,
			Model model
			) {
		model.addAttribute("email",email);
		
		return "/member/memberPwUpdate";
	}
	
	/**
	 * @author 김준한
	 * 이메일인증을 통한 비밀번호 찾기후 변경
	 */
	@PostMapping("/memberPwUpdate.do")
	public String memberPwUpdate(
			@RequestParam("newPassword") String password,
			@RequestParam("email") String email,
			RedirectAttributes redirectAttr
			) {
		String encodedPassword = passwordEncoder.encode(password);
		MemberPwUpdateDto memberPwUpdateDto = MemberPwUpdateDto.builder()
				.password(encodedPassword)
				.email(email).build();
		int result = memberService.memberPwUpdate(memberPwUpdateDto);
		
		redirectAttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다.");
		
		return "redirect:/member/searchPw.do";
		
	}
}
