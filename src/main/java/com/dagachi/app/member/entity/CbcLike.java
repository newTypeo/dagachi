package com.dagachi.app.member.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CbcLike {
	
	private String memberId;
	private int type;
	private int targetId;
	private LocalDateTime createdAt;

}
