package com.dagachi.app.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.Member;

import lombok.extern.slf4j.Slf4j;

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
	
	@GetMapping("adminMemberList.do")
	public void memberList(Model model) {
		List<Member> members = clubService.adminMemberList();
		log.debug("맴버를 잘 가지고 왔니 부탁이야 = {}", members);
		model.addAttribute("members", members);
	}
	
	
	
	
}
