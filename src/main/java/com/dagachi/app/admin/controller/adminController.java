package com.dagachi.app.admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.Member;
import com.sh.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class adminController {

	@Autowired
	private ClubService clubService;
	
	@Autowired
	private MemberService memberService;
	
	/**
	 * 관리자 모임 목록 조회
	 * @author 종환
	 */
	@GetMapping("adminClubList.do")
	public void clubList(Model model) {
		List<Club> clubs = clubService.adminClubList();
		model.addAttribute("clubs",clubs);
	}
	
	/**
	 * 관리자 회원 목록 조회
	 * @author 현우
	 */
	@GetMapping("adminMemberList.do")
	public void memberList(Model model) {
		List<Member> members = memberService.adminMemberList();
		model.addAttribute("members", members);
	}
	/**
	 * 관리자 회원 목록에서 회원 검색
	 * @author 현우
	 */	
//	@GetMapping("memberSearch.do")
//	public ResponseEntity<?> memberSearch(@RequestParam String keyword, @RequestParam String column) {
//		log.debug("keyword = {}", keyword);
//		log.debug("column = {}", column);
//		List<Member> members = new ArrayList<>();
//		if(keyword == "") {
//			members = memberService.memberSearch(keyword, column);
//		}
//	}
	
	
}
