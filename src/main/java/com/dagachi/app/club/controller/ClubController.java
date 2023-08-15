package com.dagachi.app.club.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/club")
public class ClubController {

	
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
//	
	
}
