package com.dagachi.app.notification.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.club.dto.ClubMemberAndImage;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.notification.entity.Alarm;
import com.dagachi.app.notification.repository.NotificationRepository;
import com.dagachi.app.ws.dto.Payload;
import com.dagachi.app.ws.dto.PayloadType;

import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class notificationServiceImpl implements NotificationService {
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	@Autowired
	ClubService clubService;
	
	@Autowired
	NotificationRepository notificationRepository;
	
	@Override
	public int sendChatalarm(ChatLog chatlog) {
	
		
		List<ClubMemberAndImage> members=clubService.findClubMembers(chatlog.getClubId());
		String clubName= clubService.findClubInfoById(chatlog.getClubId()).getClubName();
		
		int result=0;
		
		for(ClubMemberAndImage member : members) {
			String to=member.getMemberId();
			if(!to.equals(chatlog.getWriter())) {
				Payload payload= Payload.builder()
						.type(PayloadType.CHATNOTICE)
						.to(to)
						.from(chatlog.getWriter())
						.content(clubName)
						.build();
				
				Alarm alarm = Alarm.builder()
						.receiver(to)
						.sender(chatlog.getWriter())
						.content(clubName)
						.type(PayloadType.CHATNOTICE)
						.build();
				
				result= notificationRepository.insertChatAlarm(alarm);
				
				simpMessagingTemplate.convertAndSend("/app/notice/" +to,payload);
			}
		}

		return result;
	}
	
	
	@Override
	public List<Alarm> findAlarms(String receiver) {
		return notificationRepository.findAlarms(receiver);
	}
	
	@Override
	public int checkedAlarm(String receiver) {
		return notificationRepository.checkedAlarm(receiver);
	}
	
	
	@Override
	public int membershipRequest(Club club, MemberDetails member,JoinClubMember master) {
		
		int result=0;
		String content=club.getClubName()+":"+member.getNickname()+"(이)가 가입요청을 보냈습니다.";
		
		log.debug("master={}",master);
		
		Alarm alarm=Alarm.builder()
				.receiver(master.getMemberId())
				.sender(member.getMemberId())
				.content(content)
				.type(PayloadType.NOTICE)
				.build();
		
		result=notificationRepository.insertChatAlarm(alarm);
		
	
		Payload payload=getPayload(alarm);
		payload.setContent(content);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" +master.getMemberId() ,payload);
		
		log.debug("payload={}",payload);
		log.debug("alarm={}",alarm);
		
		return result;
	}
	
	@Override
	public int permitApply(Club club, String memberId,JoinClubMember master) {
		
		int result=0;
		String content=club.getClubName()+"의 모임에 가입 요청이 승인되었습니다.";
		
		Alarm alarm=Alarm.builder()
				.receiver(memberId)
				.sender(master.getMemberId())
				.content(content)
				.type(PayloadType.NOTICE)
				.build();
		
		result=notificationRepository.insertChatAlarm(alarm);
		
		Payload payload=getPayload(alarm);
		payload.setContent(content);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" +memberId ,payload);
		
		return result;
	}
	
	@Override
	public int refuseApply(Club club, String memberId,JoinClubMember master) {
		
		int result=0;
		String content=club.getClubName()+"의 모임에 가입 요청이 거절되었습니다.";
		
		Alarm alarm=Alarm.builder()
				.receiver(memberId)
				.sender(master.getMemberId())
				.content(content)
				.type(PayloadType.NOTICE)
				.build();
		
		result=notificationRepository.insertChatAlarm(alarm);
		
		Payload payload=getPayload(alarm);
		payload.setContent(content);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" +memberId ,payload);
		
		return result;
	}
	
	
	
	public Alarm getAlarm(Payload payload) {
		
		
		Alarm alarm=Alarm.builder()
				.receiver(payload.getTo())
				.sender(payload.getFrom())
				.type(payload.getType())
				.build();
		
		return alarm;
	}
	
	public Payload getPayload(Alarm alarm) {
		
		Payload payload= Payload.builder()
				.type(alarm.getType())
				.to(alarm.getReceiver())
				.from(alarm.getSender())
				.build();
		
		return payload;
	}
}
