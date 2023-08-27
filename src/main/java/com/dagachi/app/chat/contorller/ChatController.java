package com.dagachi.app.chat.contorller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.chat.service.ChatService;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.MemberDetails;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private ClubService clubService;

	@GetMapping("/chat/chatBox.do")
	public String chatBox() {

		return "chat/chatBox";
	}

	@GetMapping("/chat/findChatList.do")
	public ResponseEntity<?> findChatList(
			@RequestParam int clubId
	) {
		
		Club club= clubService.findClubById(clubId);
		String clubName= club.getClubName();
		
		ChatLog cahtlog=chatService.findByRecentChat(clubId);
		
		log.debug("cahtlog={}",cahtlog);
		log.debug("clubName={}",clubName);
		
		Map<String, Object> data = new HashMap<>();
		data.put("cahtlog", cahtlog);
		data.put("clubName", clubName);
		
		
		return ResponseEntity.status(HttpStatus.OK).body(data);
	}
	
	@GetMapping("/chatRoom")
	public void chatRoom(
			@RequestParam int no,
			Model model
	) {
		List<ChatLog> cahtlogs=chatService.clubChat(no);
		log.debug("cahtlogs={}",cahtlogs);
		int clubId=no;
		model.addAttribute("clubId",clubId);
		model.addAttribute("cahtlogs",cahtlogs);
		
	}
}
