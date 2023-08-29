package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ClubNameAndCountDto {
	private int clubId;
	private String clubName;
	private LocalDateTime createdAt;
	private int memberCount;
}
