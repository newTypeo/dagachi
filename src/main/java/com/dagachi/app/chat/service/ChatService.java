package com.dagachi.app.chat.service;

import java.util.List;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.ws.dto.Payload;

public interface ChatService {

	ChatLog findByRecentChat(int clubId);

	List<ChatLog> clubChat(int no);

	int sendClubChat(ChatLog chatlog);
	


}
