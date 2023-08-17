package com.dagachi.app.club.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.service.ClubService;

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
	@GetMapping("/clubSearch.do")
	public ResponseEntity<?> clubSearch(@RequestParam String keyword) {
		List<Club> clubs = new ArrayList<>();
		if(keyword == "") {
			clubs = clubService.adminClubList();
		}
		else {
			clubs = clubService.clubSearch(keyword);
		}
		// log.debug("clubs = {}", clubs);
		return ResponseEntity.status(HttpStatus.OK).body(clubs);
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
	public String clubDetail(@PathVariable("domain") String domain) {
//		log.debug("domain = {}", domain);
		
		
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
	
	
	
	
	
	
	
}
