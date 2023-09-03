package com.dagachi.app.schedule.entity;

import com.dagachi.app.club.entity.ClubSchedulePlace;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class ClubSchedulePlaceDetail extends ClubSchedulePlace{
	private double xCo;
	private double yCo;
}
