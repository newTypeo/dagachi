package com.dagachi.app.chat.contorller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {

	@GetMapping("/chat/chatBox.do")
	public String chatBox() {

		return "chat/chatBox";
	}

	@GetMapping("/chat/findChatList.do")
	public ResponseEntity<?> findChatList(
			@RequestParam String memberId
	) {
		
		log.debug("memberId",memberId);
		return ResponseEntity.status(HttpStatus.OK).body(null);
	}
}
