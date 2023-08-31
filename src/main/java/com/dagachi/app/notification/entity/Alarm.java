package com.dagachi.app.notification.entity;

import java.time.LocalDateTime;

import com.dagachi.app.ws.dto.PayloadType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Alarm {
	private int id;
	private String receiver;
	private String sender;
	private String content;
	private int isRead;
	private LocalDateTime createdAt;
	private PayloadType type;
}
