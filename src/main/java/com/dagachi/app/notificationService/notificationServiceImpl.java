package com.dagachi.app.notificationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;


import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class notificationServiceImpl implements NotificationService {
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
}
