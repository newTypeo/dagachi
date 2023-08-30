package com.dagachi.app.schedule.service;

import java.util.List;
import java.util.Map;

import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.schedule.dto.ScheduleAndWriterProfileDto;

public interface ScheduleService {

	List<ClubSchedule> findSchedulesByClubId(int clubId);

	ScheduleAndWriterProfileDto findscheduleById(int no);

	ClubMember getWriterInfo(Map<String, Object> mIdAndcId);

}
