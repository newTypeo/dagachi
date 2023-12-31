package com.dagachi.app.schedule.service;

import java.util.List;
import java.util.Map;

import com.dagachi.app.club.dto.ClubScheduleAndMemberDto;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.schedule.dto.ScheduleCreateDto;
import com.dagachi.app.schedule.dto.ScheduleDetailsDto;

public interface ScheduleService {

	List<ClubScheduleAndMemberDto> findSchedulesByDomain(String domain);

	ScheduleDetailsDto findscheduleById(int no);

	ClubMember getWriterInfo(Map<String, Object> mIdAndcId);

	ClubScheduleEnrollMember findEnrollMember(ClubScheduleEnrollMember memberInfo);

	int insertEnrollMember(ClubScheduleEnrollMember memberInfo);

	int deleteEnrollMember(ClubScheduleEnrollMember memberInfo);

	int insertSchedule(ScheduleCreateDto scheduleCreateDto);

	int updateScheduleStatus(int no);

	int getMyRole(Map<String, Object> mIdAndcId);

}
