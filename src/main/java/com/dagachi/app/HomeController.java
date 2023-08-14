package com.dagachi.app;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	
	@GetMapping("")
	// @ResponseBody // 응답메세지에 리턴객체 출력 (viewName으로 사용하지 않음)
	public String home() {
		log.info("home!");
		return "forward:/index.jsp"; // forward: 접두사를 사용하면, /WEB-INF/viewx/...jsp 경로가 아닌 주어진 경로 view단 연결
	}
}
