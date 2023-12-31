package com.dagachi.app.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dagachi.app.Pagination;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.admin.entity.MainPage;
import com.dagachi.app.admin.service.AdminService;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubBoardAttachment;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.common.DagachiUtils;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private ClubService clubService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	static final int LIMIT = 10;
	
	@GetMapping("/adminUpdateBanner.do")
	public void adminUpdateBanner() {}
	
	/**
	 * 관리자 - 메인 배너 추가
	 * @author 종환
	 */
	@PostMapping("/adminUpdateBanner.do")
	public String adminUpdateBanner(@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles) throws IllegalStateException, IOException {
		
		if (!upFiles.get(0).isEmpty()) {
			String originalFilename = upFiles.get(0).getOriginalFilename();
			String renamedFilename = DagachiUtils.getRenameFilename(originalFilename);
			File destFile = new File("/main/" + renamedFilename);
			
			// 실제 파일 저장
			upFiles.get(0).transferTo(destFile);

			ClubBoardAttachment attach = ClubBoardAttachment.builder()
															.originalFilename(originalFilename)
															.renamedFilename(renamedFilename).build();
			int result = adminService.updateBanner(attach);
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/adminInquiryUpdate.do")
	public String adminInquiryUpdate(@RequestParam int inquiryId, Model model){
	    AdminInquiry inquiry = adminService.findInquiry(inquiryId);
	    model.addAttribute("inquiry",inquiry );
	    return "/admin/adminInquiryUpdate";
	}
	
	@PostMapping("/adminInquiryUpdate.do")
	public String adminInquiryUpdate(@RequestParam String inquiryId, @RequestParam String response, @AuthenticationPrincipal MemberDetails member) {
	    AdminInquiryUpdateDto inquiryUpdate = new AdminInquiryUpdateDto(); 
	    inquiryUpdate.setAdminId(member.getMemberId());
	    inquiryUpdate.setInquiryId(inquiryId);
	    inquiryUpdate.setResponse(response);
	    //inquiryUpdate.setResponse(response);

	    int result = adminService.updateInquiry(inquiryUpdate);
	    
	    return "redirect:/admin/adminInquiryList.do";
	}
	
	
	@GetMapping("/adminInquiryList.do")
	public void inquriyList(Model model){
	}
	
	@GetMapping("/findAdminInquiry.do")		// 필수값이 아니다. 
	public ResponseEntity<?> InquiryList(@RequestParam(required = false, defaultValue = "0") int inquiryType,int inquiryStatus,
			@RequestParam(defaultValue = "1") int page) {
		int _type = (inquiryType != 0) ? inquiryType : 0;
		int _status = (inquiryStatus != 0) ? inquiryStatus : 0;
		log.debug("_type={}",_type);
		log.debug("_status={}",_status);
		
		AdminInquiry adminInquiry = AdminInquiry.builder().type(_type).type(_status).build();
		log.debug("adminInquiry={}",adminInquiry);
		Map<String, Object> params = Map.of("page", page, "limit", LIMIT);
		List<AdminInquiry> inquirys = adminService.adminInquiryList(adminInquiry, params);
		log.debug("inquirys={}",inquirys);
		int inquirySize = adminService.inquirySize(adminInquiry);
		log.debug("inquirySize={}",inquirySize);
		
		Map<String, Object> inquiryInfo = Map.ofEntries(
				Map.entry("inquirySize", inquirySize),
				Map.entry("inquirys", inquirys)
		);
		
		return ResponseEntity.status(HttpStatus.OK).body(inquiryInfo);
	}

	@GetMapping("/searchInquiryType.do")
	public ResponseEntity<?> searchInquiryType(@PathVariable("domain") 
			@RequestParam String searchKeywordVal, @RequestParam String searchTypeVal, 
			@RequestParam int inquiryTypeVal,@RequestParam int inquiryStatusVal,
			@RequestParam(defaultValue = "1") int page) {


		Map<String,Object> searchInquirydMap =  new HashMap<String,Object>();
				searchInquirydMap.put("searchKeyword", searchKeywordVal);
				searchInquirydMap.put("searchType", searchTypeVal);
				searchInquirydMap.put("type", inquiryTypeVal);
				searchInquirydMap.put("status", inquiryStatusVal);
		log.debug("t121212ype={}",inquiryTypeVal);
		log.debug("21212status={}",searchInquirydMap); 
		
		Map<String, Object> params = Map.of("page", page, "limit", LIMIT);
		
		List<AdminInquiry> inquirys = adminService.searchInquirys(searchInquirydMap,params);
		
		List<AdminInquiry> inquiry  = adminService.searchInquiry(searchInquirydMap);
		log.debug("inquirys={}",inquirys);
		
		int inquirySize =inquiry.size();
			Map<String,Object> data =  new HashMap<String,Object>();
					data.put("inquirys", inquirys);
					data.put("inquirySize", inquirySize);
		return ResponseEntity.status(HttpStatus.OK).body(data);

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
	
	@GetMapping("mainBannerList.do")
	@ResponseBody
	public ResponseEntity<?> mainBannerList() {
		List<MainPage> mainBanners = new ArrayList<MainPage>();
		mainBanners = adminService.getMainBanner();
		return ResponseEntity.status(HttpStatus.OK).body(mainBanners);
	}
	
}