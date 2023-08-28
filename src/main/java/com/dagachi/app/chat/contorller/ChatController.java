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
		
		log.debug("filename={}",filename);
		log.debug("memberProfiles={}",memberProfiles);
		log.debug("from={}",from);
		log.debug("to={}",to);
		return ResponseEntity.status(HttpStatus.OK).body(filename);
	}
	
}
