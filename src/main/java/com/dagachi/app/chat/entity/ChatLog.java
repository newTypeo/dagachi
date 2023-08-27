package com.dagachi.app.chat.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatLog {
	private int id;
	private int clubId;
	private String writer;
	private String content;
	private LocalDateTime createdAt;
}
