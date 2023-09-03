package com.dagachi.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dagachi.app.notification.entity.Alarm;
import com.dagachi.app.notification.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notification")
public class NotificationController {
	
	@Autowired
	private NotificationService notificationService;
	
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

}
