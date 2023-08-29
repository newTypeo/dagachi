package com.dagachi.app.schedule.service;

import java.util.List;

import com.dagachi.app.club.entity.ClubSchedule;

public interface scheduleService {

	List<ClubSchedule> findSchedulesByClubId(int clubId);

}
