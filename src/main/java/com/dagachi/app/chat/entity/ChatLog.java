package com.dagachi.app.chat.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ChatLog {
	private int id;
	private int clubId;
	private String writer;
	private String content;
	private LocalDateTime createdAt;
}
