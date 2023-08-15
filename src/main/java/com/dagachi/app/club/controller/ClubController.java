package com.dagachi.app.club.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.service.ClubService;

@Controller
@RequestMapping("/club")
public class ClubController {
	
	@Autowired
	private ClubService clubService;
	
	@GetMapping("/clubDetail.do")
	public void Detail() {
	}
	
	
	@GetMapping("/clubBoard.do")
	public void board() {
	};
	
	
	
	
	
	
	
	
	
	
	
	// @RequestBody
	@GetMapping("/clubSearch.do")
	public void clubSearch(@RequestParam String keyword) {
		
		List<Club> clubs = clubService.clubSearch(keyword);
		
	}
	
	
	
	
	
	
	
	
	
}
