package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;

import lombok.Data;

@Data
public class ClubSchedule {
	private int scheduleId;
	private int clubId;
	private String title;
	private String writer;
	private LocalDateTime startDate;
	private LocalDateTime endDate;
	private int expense;
	private int capacity;
	private LocalDateTime alarmDate;
	private Status status;
}
