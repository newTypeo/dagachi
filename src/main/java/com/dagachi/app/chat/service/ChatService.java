package com.dagachi.app.chat.service;

import java.util.List;

import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.chat.entity.ChatLogDetail;

public interface ChatService {

	ChatLogDetail findByRecentChat(int clubId);

	List<ChatLogDetail> clubChat(int no);

	int sendClubChat(ChatLog chatlog);

	String getNicknameById(String writer);
	


}
