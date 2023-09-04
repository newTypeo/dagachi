package com.dagachi.app.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public List<ChatLog> clubChat(int no) {
		return chatRepository.clubChat(no);	}
	
	@Override
	public int sendClubChat(ChatLog chatlog) {
		return chatRepository.sendClubChat(chatlog);
	}
	
	@Override
	public String getNicknameById(String writer) {
		return chatRepository.getNicknameById(writer);
	}

}
