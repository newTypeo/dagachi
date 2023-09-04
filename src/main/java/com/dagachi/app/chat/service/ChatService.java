package com.dagachi.app.chat.service;

import java.util.List;

import com.dagachi.app.chat.entity.ChatLogDetail;
import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.ws.dto.Payload;

public interface ChatService {

	ChatLogDetail findByRecentChat(int clubId);

	List<ChatLog> clubChat(int no);

	int sendClubChat(ChatLog chatlog);

	String getNicknameById(String writer);
	


}
