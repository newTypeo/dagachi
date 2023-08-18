package com.dagachi.app.club.controller;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.io.BufferedReader;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.service.ClubService;

import com.dagachi.app.common.DagachiUtils;

import com.dagachi.app.member.entity.Member;


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

    
	
	
}
