package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClubSchedulePlace {
	private int id;
	private int scheduleId;
	private String name;
	private String address;
	private String details;
	private int sequence;
	private LocalDateTime startTime;
}
