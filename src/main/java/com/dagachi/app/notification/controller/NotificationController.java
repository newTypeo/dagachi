package com.dagachi.app.notification.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.club.dto.ClubMemberAndImage;
import com.dagachi.app.club.service.ClubService;
import com.dagachi.app.notification.entity.Alarm;
import com.dagachi.app.notification.service.NotificationService;
import com.dagachi.app.ws.dto.Payload;
import com.dagachi.app.ws.dto.PayloadType;

import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notification")
public class NotificationController {
	
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private ClubService clubService;
	
	@GetMapping("/findAlarms.do")
	public ResponseEntity<?> findAlarms(
			@RequestParam String receiver
	){
		
		List<Alarm> alarms = notificationService.findAlarms(receiver);
		log.debug("alarms={}",alarms);
		
		return ResponseEntity.status(HttpStatus.OK).body(alarms);
	}
	
	@PostMapping("/checkedAlarm.do")
	public ResponseEntity<?> checkedAlarm(
			@RequestParam String receiver
	){
		
		int result=notificationService.checkedAlarm(receiver);
		
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	
	@GetMapping("/insertAlarm.do")
	public ResponseEntity<?> insertAlarm(
			@RequestParam int clubId,
			@RequestParam String from
	) {
		
		List<ClubMemberAndImage> members=clubService.findClubMembers(clubId);
		String content = clubService.findClubInfoById(clubId).getClubName();
		
		for(ClubMemberAndImage member : members) {
			String to=member.getMemberId();
			if(!to.equals(from)) {
				
				Payload payload= Payload.builder()
						.content(content)
						.from(from)
						.to(to)
						.type(PayloadType.CHATNOTICE)
						.build();
				
				System.out.println(payload);
				
				int result= notificationService.insertAlarm(payload);
			}
		}
		
		
		String data="알람 저장 성공";
		return ResponseEntity.status(HttpStatus.OK).body(data);
	}
}
