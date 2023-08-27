package com.dagachi.app.ws.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.chat.service.ChatService;
import com.dagachi.app.notificationService.NotificationService;
import com.dagachi.app.ws.dto.Payload;

import lombok.extern.slf4j.Slf4j;

/**
 * ApplicationDestinationPrefix로 시작하는 ws 요청은 이 핸들러를 거친다.
 *  
 *
 */
@Controller
@Slf4j
public class StompMessageController {
	
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private ChatService chatService;
	
	/**
	 * prefix를 제외한 url만 작성
	 * 
	 * @return
	 */
	@MessageMapping("/notice")
	@SendTo("/app/notice")
	public Payload notice(Payload message) {
		log.debug("message = {}", message);
		// notificationService.insertNotification(message);
		return message;
	}
	
	@MessageMapping("/clubTalk/{clubId}")
	@SendTo("/app/clubTalk/{clubId}")
	public Payload noticeEach(@DestinationVariable  int clubId, Payload message) {
		log.debug("message = {}", message);
		
		ChatLog chatlog=ChatLog.builder()
				.clubId(clubId)
				.content(message.getContent())
				.writer(message.getFrom())
				.build();
		
		int result=chatService.sendClubChat(chatlog);
		
		return message;
	}
	
	@MessageMapping("/moimtalk/{moimTitle}")
	@SendTo("/app/notice/{moimTitle}")
	public Payload moimtalk(@DestinationVariable String moimTitle, Payload message) {
		log.debug("moimTitle = {}", moimTitle);
		log.debug("message = {}", message);
		return message;
	}
	
}
