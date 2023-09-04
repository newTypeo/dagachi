package com.dagachi.app.chat.contorller;

import java.util.Arrays;
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
import com.dagachi.app.chat.entity.ChatLogDetail;
import com.dagachi.app.chat.service.ChatService;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.MemberDetails;
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
		System.out.println(clubId);
		Club club = clubService.findClubById(clubId);
		String clubName= club.getClubName();
		ClubProfile clubProfile = clubService.findClubProfileById(clubId);
		String filename = clubProfile.getRenamedFilename();
		
		ChatLogDetail chatlog = chatService.findByRecentChat(clubId);
		
		if (chatlog != null) {
			String writer = chatlog.getWriter();
			chatlog.setNickname(chatService.getNicknameById(writer));
		}
		
		log.debug("chatlog={}",chatlog);
		log.debug("clubName={}",clubName);
		
		Map<String, Object> data = new HashMap<>();
		data.put("cahtlog", chatlog);
		data.put("clubName", clubName);
		data.put("clubProfile", filename);
		
		
		return ResponseEntity.status(HttpStatus.OK).body(data);
	}
	
	@GetMapping("/chatRoom")
	public void chatRoom(
			@RequestParam int no,
			Model model
	) {
		List<ChatLog> chatlogs=chatService.clubChat(no);
		log.debug("cahtlogs={}",chatlogs);
		int clubId=no;
		
		List<MemberProfile> memberProfiles = memberService.findMemberProfileByClubId(clubId);
		
		
		model.addAttribute("clubId",clubId);
		model.addAttribute("memberProfiles",memberProfiles);
		model.addAttribute("chatlogs",chatlogs);
		
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
