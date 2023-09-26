package com.dagachi.app.chat.service;

import java.util.List;

import com.dagachi.app.chat.dto.ChatDetail;
import com.dagachi.app.chat.dto.ChatListDetail;
import com.dagachi.app.chat.dto.ClubInfo;
import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.chat.entity.ChatLogDetail;

public interface ChatService {

	ChatLogDetail findByRecentChat(int clubId);

	List<ChatLogDetail> clubChat(int no);

	int sendClubChat(ChatLog chatlog);

	String getNicknameById(String writer);

	ChatListDetail findByRecentChatDetail(int clubId);

	ClubInfo findByClubInfo(int clubId);

	List<ChatDetail> findClubChat(int no);
	


}
