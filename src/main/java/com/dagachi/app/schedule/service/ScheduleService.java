package com.dagachi.app.schedule.service;

import java.util.List;
import java.util.Map;

import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.schedule.dto.ScheduleDetailsDto;

public interface ScheduleService {

	List<ClubSchedule> findSchedulesByClubId(int clubId);

	ScheduleDetailsDto findscheduleById(int no);

	ClubMember getWriterInfo(Map<String, Object> mIdAndcId);

	ClubScheduleEnrollMember findEnrollMember(ClubScheduleEnrollMember memberInfo);

	int insertEnrollMember(ClubScheduleEnrollMember memberInfo);

	int deleteEnrollMember(ClubScheduleEnrollMember memberInfo);

}
