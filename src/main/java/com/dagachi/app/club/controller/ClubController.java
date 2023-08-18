package com.dagachi.app.club.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubCreateDto;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ClubUpdateDto;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.entity.MemberDetails;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/club")
@Slf4j
public class ClubController {
	
	@Autowired
	private ClubService clubService;
	
	@GetMapping("/main.do")
	public void Detail() {
	}
	
	
	@GetMapping("/clubBoardList.do")
	public void boardList() {
	}
	
	@GetMapping("/clubBoardCreate.do")
	public void boardCreate() {
		
	}
	
//	@PostMapping("/clubBoardCreate.do")
//	public String boardCreate1(
//			
//	) {
//		
//		return " ";
//	}
	
	/**
	 * 관리자 회원 목록에서 모임 검색
	 * @author 종환
	 */
	@GetMapping("/adminClubSearch.do")
	public ResponseEntity<?> adminClubSearch(@RequestParam String keyword, @RequestParam String column) {
		log.debug("keyword = {}", keyword);
		log.debug("column = {}", column);
		List<Club> clubs = new ArrayList<>();
		if(keyword == "") {
			clubs = clubService.adminClubList();
		}
		else {
			clubs = clubService.adminClubSearch(keyword, column);
		}
		// log.debug("clubs = {}", clubs);
		return ResponseEntity.status(HttpStatus.OK).body(clubs);
	}
	
	/**
	 * 메인화면에서 모임 검색
	 * @author 종환
	 */
	@GetMapping("/clubSearch.do")
	public void clubSearch(@RequestParam String inputText, Model model) {
		// log.debug("inputText = {}", inputText);
		List<ClubSearchDto> clubs = clubService.clubSearch(inputText);
		log.debug("clubs = {}", clubs);
		model.addAttribute("clubs", clubs);
	}
	
	
	
	@GetMapping("/chatList.do")
	public void chatList() {
		
	}
	
	@GetMapping("/chatRoom.do")
	public void chatRoom() {
		
	}
	
	/**
	 * 인덱스 페이지에서 클럽 상세보기 할 때 매핑입니다.
	 * 도메인도 domain 변수 안에 넣어놨습니다. (창환)
	 */
	@GetMapping("/&{domain}")
	public String clubDetail(
			@PathVariable("domain") String domain,
			Model model) {
//		log.debug("domain = {}", domain);
		
		model.addAttribute("domain", domain);
		return "club/clubDetail";
	}
	
	/**
	 * 메인에서 소모임 전체 조회(카드로 출력)
	 * @author 준한
	 */
	@GetMapping("/clubList.do")
	public ResponseEntity<?> clubList(){
		List<ClubAndImage> clubAndImages = new ArrayList<>();
		clubAndImages = clubService.clubList();
		return ResponseEntity.status(HttpStatus.OK).body(clubAndImages);
	}
	


	/**
	 * 해당 모임의 회원관리 클릭시
	 * @author 창환
	 */
	@GetMapping("/&{domain}/manageMember.do")
	public String manageMemeber(
			@PathVariable("domain") String domain,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기
		List<ManageMember> clubApplies = clubService.clubApplyByFindByClubId(clubId); // clubId로 club_apply, member 테이블 조인
		
//		log.debug("clubId = {}", clubId);
//		log.debug("clubApplies = {}", clubApplies);
		
		List<ClubMember> clubMembers = clubService.clubMemberByFindAllByClubId(clubId); // clubId로 club_member 조회
//		log.debug("clubMembers = {}", clubMembers);
		
		
		List<JoinClubMember> joinClubMembersInfo = clubService.clubMemberInfoByFindByMemberId(clubMembers);	// 해당 모임에 가입된 회원 정보(이름, 닉네임, 가입일)
		log.debug("joinClubMembersInfo = {}", joinClubMembersInfo);
		
		model.addAttribute("clubApplies", clubApplies);
		model.addAttribute("joinClubMembersInfo", joinClubMembersInfo);
		
		return "/club/manageMember";
	}

	
	/**
	 * 해당 모임의 방장, 부방장은 모임에 가입되어있는 회원의 권한을 변경 가능
	 * @author 창환
	 */
	@PostMapping("/&{domain}/clubMemberRole.do")
	public String clubMemberRoleUpdate(
			@PathVariable("domain") String domain,
			@RequestParam String memberId,
			@RequestParam int clubMemberRole) {
		
		log.debug("memberId = {}", memberId);
		log.debug("clubMemberRole = {}", clubMemberRole);
		
		ClubMemberRoleUpdate member = ClubMemberRoleUpdate.builder()
				.memberId(memberId)
				.clubMemberRole(clubMemberRole)
				.build();
		
		log.debug("member = {}", member);
		int result = clubService.clubMemberRoleUpdate(member);
		log.debug("result = {}", result);
		
		return "redirect:/club/&" + domain + "/manageMember.do";
	}
	
	
//	@GetMapping("/findBoardType.do")
//	public ResponseEntity<?> boardList(@RequestParam(required = false)int boardType){
//		
//		List<ClubBoard> boards = clubService.boardList(boardType);
//		
//		return ResponseEntity.status(HttpStatus.OK).body(boards);
//	}
//	
	@GetMapping("/clubCreate.do")
	public void clubCreate() throws Exception {
		
	}
	
	/**
	 * 클럽 비활성화 버튼( 클럽테이블의 status값을 Y -> N으로 변경)
	 * @author 준한
	 */
	@GetMapping("/&{domain}/clubDisabled.do")
	public String clubDisabled(
			@PathVariable("domain") String domain
			) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기
		int result = clubService.clubDisabled(clubId);
		return "redirect:/";
	}
	
	@GetMapping("/findAddress.do")
	public ResponseEntity<?> findAddress(String keyword) throws UnsupportedEncodingException {
		
		if (keyword == null || keyword == "") return null;
		String SearchType = "address";
		
		JsonArray documents = DagachiUtils.kakaoMapApi(keyword, SearchType);

        Gson gson = new Gson();

        List<String> addressList = new ArrayList<>();
        for (JsonElement document : documents) {
            JsonObject item = document.getAsJsonObject();
            String addressName = item.get("address_name").getAsString();
            addressList.add(addressName);
        }
        return ResponseEntity.status(HttpStatus.OK).body(addressList);
	}

	@PostMapping("/clubCreate.do")
	public String clubCreate(@Valid ClubCreateDto _club, 
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member,
			@RequestParam(value = "upFile") MultipartFile upFile) throws IllegalStateException, IOException {
		
		// 1. 파일저장
		String uploadDir = "/clubProfile/";
		ClubProfile clubProfile = null;
		if(!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을 사용
			upFile.transferTo(destFile); // 실제파일 저장
			
			clubProfile = ClubProfile.builder()
					.originalFilename(originalFilename)
					.renamedFilename(renamedFilename)
					.build();
		}
		
		List<String> tagList = new ArrayList<>();
		for (String tag : _club.getTags().split(",")) {
			tagList.add(tag);
		}
		
		// 2. db저장
		ClubDetails club = ClubDetails.builder()
				.clubName(_club.getClubName())
				.activityArea(_club.getActivityArea())
				.category(_club.getCategory())
				.tagList(tagList)
				.domain(_club.getDomain())
				.introduce(_club.getIntroduce())
				.enrollQuestion(_club.getEnrollQuestion())
				.clubProfile(clubProfile)
				.build();
		
		System.out.println(club);
				
		int result = clubService.insertClub(club);
		
		
		return "redirect:/club/clubCreate.do";
	}
	
	@GetMapping("/&{domain}/clubUpdate.do")
	public String clubUpdate(
			@PathVariable("domain") String domain,
			Model model
			) {
		int clubId = clubService.clubIdFindByDomain(domain);
		Club club = clubService.findClubById(clubId);
		ClubProfile clubProfile = clubService.findClubProfileById(clubId);
		List<ClubTag> clubTagList = clubService.findClubTagById(clubId);
		
		log.debug("club = {}", club);
		log.debug("clubProfile={}",clubProfile);
		log.debug("clubTag = {}", clubTagList);
		
		model.addAttribute("club",club);
		model.addAttribute("clubProfile",clubProfile);
		model.addAttribute("clubTagList",clubTagList);
		
		return "club/clubUpdate";
	}
	
	@PostMapping("/&{domain}/clubUpdate.do")
	public String clubUpdate(
			@PathVariable("domain") String domain,
			@Valid ClubUpdateDto _club, 
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member,
			@RequestParam(value = "upFile") MultipartFile upFile) throws IllegalStateException, IOException {
		int clubId = clubService.clubIdFindByDomain(domain);
		// 1. 파일저장
		
		String uploadDir = "/clubProfile/";
		ClubProfile clubProfile = null;
		if(!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(uploadDir + renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을 사용
			upFile.transferTo(destFile); // 실제파일 저장
			
			clubProfile = ClubProfile.builder()
					.originalFilename(originalFilename)
					.renamedFilename(renamedFilename)
					.build();
		}
		
		List<String> tagList = new ArrayList<>();
		for (String tag : _club.getTags().split(",")) {
			tagList.add(tag);
		}
		
		// 2. db저장
		ClubDetails club = ClubDetails.builder()
				.clubName(_club.getClubName())
				.activityArea(_club.getActivityArea())
				.category(_club.getCategory())
				.tagList(tagList)
				.domain(_club.getDomain())
				.introduce(_club.getIntroduce())
				.enrollQuestion(_club.getEnrollQuestion())
				.clubProfile(clubProfile)
				.build();
		club.setClubId(clubId);
		
		System.out.println(club);
		log.debug("clubbbbbbbbbb={}",club);
		log.debug("clubId={}",clubId);
				
		int result = clubService.updateClub(club);
		
		
		return "redirect:/";
	}
	
	
}
