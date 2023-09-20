package com.dagachi.app.chat.dto;

import com.dagachi.app.chat.entity.ChatLog;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatDetail extends ChatLog{
	private String nickname;
	private String renamedFilename;
}
