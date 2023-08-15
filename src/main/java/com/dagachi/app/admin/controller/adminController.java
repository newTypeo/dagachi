package com.dagachi.app.admin.controller;

import lombok.extern.slf4j.Slf4j;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.service.ClubService;

@Slf4j
@Controller
@RequestMapping("/admin")
public class adminController {

	@Autowired
	private ClubService clubService;
	
	/**
	 * 관리자 회원 목록 조회
	 * @author 종환
	 */
	@GetMapping("adminClubList.do")
	public void clubList(Model model) {
		List<Club> clubs = clubService.adminClubList();
		model.addAttribute("clubs",clubs);
	}
	
	
}
