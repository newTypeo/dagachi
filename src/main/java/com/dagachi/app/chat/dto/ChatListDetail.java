package com.dagachi.app.chat.dto;

import java.time.LocalDateTime;

import com.dagachi.app.chat.entity.ChatLog;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ChatListDetail extends ChatLog{
	private String clubName;
	private String renamedFilename;
	private String nickname;
}
