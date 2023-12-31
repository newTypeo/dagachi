package com.dagachi.app.chat.contorller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.chat.dto.ChatDetail;
import com.dagachi.app.chat.dto.ChatListDetail;
import com.dagachi.app.chat.dto.ClubInfo;
import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.chat.entity.ChatLogDetail;
import com.dagachi.app.chat.service.ChatService;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.MemberProfile;
import com.dagachi.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private MemberService memberService;

	@GetMapping("/chat/chatBox.do")
	public String chatBox() {

		return "chat/chatBox";
	}
	
	@GetMapping("/chat/findChatList.do")
	public ResponseEntity<?> findChatList(
			@RequestParam int clubId
	) {
		
		ChatLogDetail chatlog = chatService.findByRecentChat(clubId);
		
		ClubInfo clubInfo=new ClubInfo();
		ChatListDetail chatList= new ChatListDetail();
		
		
		if(chatlog !=null)
			chatList=chatService.findByRecentChatDetail(clubId);
		else 
			clubInfo=chatService.findByClubInfo(clubId);
		
		Map<String, Object> data = new HashMap<>();
		data.put("chatList", chatList);
		data.put("clubInfo", clubInfo);
		
		
		return ResponseEntity.status(HttpStatus.OK).body(data);
	}

	
	
	
	@GetMapping("/chatRoom")
	public void chatRoom(
			@RequestParam int no,
			Model model
	) {
		
		
		List<ChatDetail> chatlogs=chatService.findClubChat(no);
		//log.debug("chatlogs={}",chatlogs);
		int clubId=no;
		
		model.addAttribute("chatlogs",chatlogs);
		model.addAttribute("clubId",clubId);

		
	}

	
	@GetMapping("/findWriterProfile.do")
	public ResponseEntity<?> findWriterProfile(
			@RequestParam String from,
			@RequestParam int to
	){
		List<MemberProfile> memberProfiles = memberService.findMemberProfileByClubId(to);
		
		String filename="";
	
		
		if(!memberProfiles.isEmpty()) {
			for(MemberProfile memberProfile : memberProfiles) {
				if(memberProfile.getMemberId().equals(from)) 
					filename=memberProfile.getRenamedFilename();
			}
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(filename);
	}
	
}
