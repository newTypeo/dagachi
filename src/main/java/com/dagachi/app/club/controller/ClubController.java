package com.dagachi.app.club.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;


import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubCreateDto;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.service.ClubService;

import com.dagachi.app.common.DagachiUtils;

import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;

import lombok.Builder.Default;
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
	public void clubSearch(@RequestParam String inputText) {
		// log.debug("inputText = {}", inputText);
		List<Club> clubs = clubService.clubSearch(inputText);
		log.debug("clubs = {}", clubs);
		// 8/17 여기서 마무리 했음.
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
	


	@GetMapping("/&{domain}/manageMember.do")
	public void manageMemeber(
			@PathVariable("domain") String domain,
			Model model) {
		int clubId = clubService.clubIdFindByDomain(domain); // 해당 클럽의 아이디(pk) 가져오기
		List<ClubApply> clubApplies = clubService.clubApplyfindByClubId(clubId); // 해당 소모임에 가입 신청한 회원들 조회해서
		
		log.debug("clubId = {}", clubId);
		log.debug("clubApplies = {}", clubApplies);
		
		List<Member> members = new ArrayList<>(); // 해당 소모임에 신청한 회원들의 
		String memberId = "";
		
		// 조회된 회원 한명당 아이디를 가져와서 회원테이블에서 조회후 members배열에 담음
		for(int i=0; i<clubApplies.size(); i++) {
			memberId = clubApplies.get(i).getMemberId();
//			members
//			members.add();
		}
//		List<Member> members = clubService.findById(id);
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
		String upload = "";
		
		if(!upFile.isEmpty()) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename); // 20230807_142828888_123.jpg
			File destFile = new File(renamedFilename); // 부모디렉토리 생략가능. spring.servlet.multipart.location 값을 사용
			upFile.transferTo(destFile); // 실제파일 저장
			
//			Attachment attach = 
//					Attachment.builder()
//					.originalFilename(originalFilename)
//					.renamedFilename(renamedFilename)
//					.build();
//			attachments.add(attach);
		}
		
		return "redirect:/dagachi/club/clubCreate.do";
	}
	
	
}
