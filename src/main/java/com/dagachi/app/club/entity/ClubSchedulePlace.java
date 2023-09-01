package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ClubSchedulePlace {
	private int id;
	private int scheduleId;
	private String name;
	private String address;
	private String details;
	private int sequence;
	private LocalDateTime startTime;
}
