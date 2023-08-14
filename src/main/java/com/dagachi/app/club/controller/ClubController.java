package com.dagachi.app.club.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/club")
public class ClubController {

	
	@GetMapping("/clubDetail.do")
	public void Detail() {
	}
	
	
	@GetMapping("/clubBoard.do")
	public void board() {
	};
	
}
