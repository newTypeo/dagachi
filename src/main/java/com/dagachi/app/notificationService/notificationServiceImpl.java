package com.dagachi.app.notificationService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.club.dto.ClubMemberAndImage;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.ws.dto.Payload;
import com.dagachi.app.ws.dto.PayloadType;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class notificationServiceImpl implements NotificationService {
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	@Autowired
	ClubService clubService;
	
	@Override
	public int sendChatalarm(ChatLog chatlog) {
	
		
		List<ClubMemberAndImage> members=clubService.findClubMembers(chatlog.getClubId());
		String clubName= clubService.findClubInfoById(chatlog.getClubId()).getClubName();
		
		
		
		for(ClubMemberAndImage member : members) {
			String to=member.getMemberId();
			
			Payload payload= Payload.builder()
					.type(PayloadType.CHATNOTICE)
					.to(to)
					.from(chatlog.getWriter())
					.content(clubName)
					.build();
			
			simpMessagingTemplate.convertAndSend("/app/notice/" +to,payload);
		
		}

		
		return 0;
	}
	
}
