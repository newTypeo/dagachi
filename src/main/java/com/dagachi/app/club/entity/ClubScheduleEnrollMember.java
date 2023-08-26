package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ClubScheduleEnrollMember {
	private String memberId;
	private int clubId;
	private int scheduleId;
	private LocalDateTime createdAt;
}
