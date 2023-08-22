package com.dagachi.app.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.dagachi.app.Pagination;
import com.dagachi.app.club.controller.ClubController;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/club")
@Slf4j
public class adminController {

	@Autowired
	private ClubService clubService;
	
	@Autowired
	private MemberService memberService;
	

	@GetMapping("/adminInquriyList.do")
	public void InquriyList() {
	}
	
	/**
	 * 관리자 모임 목록 조회
	 * @author 종환
	 */
	@GetMapping("adminClubList.do")
	public void clubList(
			@RequestParam(defaultValue = "1") int page,
			@RequestParam String keyword, 
			@RequestParam String column, 
			HttpServletRequest request,
			Model model) {
		int limit = 10;
		String getCount = "getCount";
		
		Map<String, Object> params = new HashMap<>();
        params.put("page", page);
        params.put("limit", limit);
        params.put("keyword", keyword);
        params.put("column", column);
        
		List<Club> clubs = clubService.adminClubList(params);
		// log.debug("clubs= {}", clubs);
		model.addAttribute("clubs", clubs);
		
		// 전체게시물 수
		params.put("getCount", getCount);
		int totalCount = clubService.adminClubList(params).size();
		String url = request.getRequestURI();
		url += "#&keyword=" + keyword + "&column=" + column;
		String pageBar = Pagination.getPagebar(page, limit, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");
		model.addAttribute("pagebar", pageBar);
		
	}

	/**
	 * 관리자 회원 목록 조회
	 * @author 현우
	 */
	@GetMapping("adminMemberList.do")
	public void memberList(
			@RequestParam(defaultValue = "1") int page,
			@RequestParam String keyword,
			@RequestParam String column,
			HttpServletRequest request,
			Model model) {
		int limit = 10;
		
		log.debug("키워드야 안녕?", keyword);
		
		String getCount = "getCount";
		Map<String, Object> params = new HashMap<>();
        params.put("page", page);
        params.put("limit", limit);
        params.put("keyword", keyword);
        params.put("column", column);
        
		List<Member> members = memberService.adminMemberList(params);
		model.addAttribute("members", members);
		
		// 전체게시물 수
		params.put("getCount", getCount);
		int totalCount = memberService.adminMemberList(params).size();
		String url = request.getRequestURI();
		url += "#&keyword=" + keyword + "&column=" + column;
		String pageBar = Pagination.getPagebar(page, limit, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");
		model.addAttribute("pagebar", pageBar);
	}
	
	/**
	 * 관리자 탈퇴 회원 목록에서 탈퇴 회원 조회
	 * @author 현우
	 */
	@GetMapping("adminQuitMemberList.do")
	public void quitMemberList(
			@RequestParam(defaultValue = "1") int page,
			@RequestParam String keyword,
			@RequestParam String column,
			HttpServletRequest request,
			Model model) {
		int limit = 10;
		String getCount = "getCount";
		
		Map<String, Object> params = new HashMap<>();
		params.put("page", page);
		params.put("limit", limit);
		params.put("keyword", keyword);
		params.put("column", column);
		
		List<Member> members = memberService.adminQuitMemberList(params);
		model.addAttribute("members", members);
		
		// 전체 게시물 수
		params.put("getCount", getCount);
		int totalCount = memberService.adminQuitMemberList(params).size();
		String url = request.getRequestURI();
		url += "#&keyword=" + keyword + "&column=" + column;
		String pageBar = Pagination.getPagebar(page, limit, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");
		model.addAttribute("pagebar", pageBar);
	}
	/**
	 * 관리자 신고 회원 목록에서 신고 회원 조회
	 * @author 현우
	 */
	@GetMapping("adminReportMemberList.do")
	public void repotMemberList(
			@RequestParam(defaultValue = "1") int page,
			@RequestParam String keyword,
			@RequestParam String column,
			HttpServletRequest request,
			Model model) {
		
		int limit = 10;
		String getCount = "getCount"; 
		log.debug("키워드 : ", keyword);
		log.debug("컬럼 : ", column);
		
		Map<String, Object> params = new HashMap<>();
		params.put("page", page);
		params.put("limit", limit);
		params.put("keyword", keyword);
		params.put("column", column);
		
		List<Member> members = memberService.adminReportMemberList(params);
		model.addAttribute("members", members);
		
		// 전체 게시물 수
		params.put("getCount", getCount);
		int totalCount = memberService.adminReportMemberList(params).size();
		String url = request.getRequestURI();
		url += "#&keyword=" + keyword + "&column=" + column;
		String pageBar = Pagination.getPagebar(page, limit, totalCount, url);
		pageBar = pageBar.replaceAll("\\?", "&");
		pageBar = pageBar.replaceAll("#&", "\\?");
		model.addAttribute("pagebar", pageBar);
		
		

	
	}
	

	
}
