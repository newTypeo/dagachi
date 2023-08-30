package com.dagachi.app.schedule.dto;

import java.time.LocalDateTime;
import java.util.List;

import com.dagachi.app.club.common.Status;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.club.entity.ClubSchedulePlace;

import lombok.Data;

@Data
public class ScheduleDetailsDto {
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
	
	private List<ClubScheduleEnrollMember> enrollMembers;
	private List<ClubSchedulePlace> places;
}
