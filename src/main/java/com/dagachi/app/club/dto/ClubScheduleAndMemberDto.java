package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;

import lombok.Data;

@Data
public class ClubScheduleAndMemberDto {
	private int scheduleId;
	private int clubId;
	
	private String title;
	private LocalDateTime startDate;
	private LocalDateTime endDate;
	private int capacity;
	private Status status;
	
	private String memberId;
	private LocalDateTime createdAt;
	
	private int memberCount;
}
