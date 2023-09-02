package com.dagachi.app.schedule.dto;

import java.sql.Date;
import java.util.List;

import com.dagachi.app.club.entity.ClubSchedulePlace;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ScheduleCreateDto {
	private Integer scheduleId;
	private Integer clubId;
	private String title;
	private String writer;
	private String content;
	private Date startDate;
	private Date endDate;
	private int expence;
	private int capacity;
	private List<ClubSchedulePlace> places;
}
