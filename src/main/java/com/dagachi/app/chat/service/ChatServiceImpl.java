package com.dagachi.app.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.chat.dto.ChatDetail;
import com.dagachi.app.chat.dto.ChatListDetail;
import com.dagachi.app.chat.dto.ClubInfo;
import com.dagachi.app.chat.entity.ChatLog;
import com.dagachi.app.chat.entity.ChatLogDetail;
import com.dagachi.app.chat.repository.ChatRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatRepository chatRepository;
	
	@Override
	public ChatLogDetail findByRecentChat(int clubId) {
		return chatRepository.findByRecentChat(clubId);
	}
	
	@Override
	public List<ChatLogDetail> clubChat(int no) {
		return chatRepository.clubChat(no);	}
	
	@Override
	public int sendClubChat(ChatLog chatlog) {
		return chatRepository.sendClubChat(chatlog);
	}
	
	@Override
	public String getNicknameById(String writer) {
		return chatRepository.getNicknameById(writer);
	}
	
	@Override
	public ChatListDetail findByRecentChatDetail(int clubId) {
		return chatRepository.findByRecentChatDetail(clubId);
	}
	
	@Override
	public ClubInfo findByClubInfo(int clubId) {
		return chatRepository.findByClubInfo(clubId);
	}
	
	@Override
	public List<ChatDetail> findClubChat(int no) {
		return chatRepository.findClubChat(no);
	}

}
