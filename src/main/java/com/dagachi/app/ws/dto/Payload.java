package com.dagachi.app.ws.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Payload {
	private PayloadType type;
	private String from;
	private String to;
	private String content;
	private long createdAt;
}
