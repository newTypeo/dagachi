package com.dagachi.app.schedule.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.club.entity.ClubSchedulePlace;
import com.dagachi.app.schedule.dto.ScheduleCreateDto;
import com.dagachi.app.schedule.dto.ScheduleDetailsDto;
import com.dagachi.app.schedule.entity.ClubScheduleEnrollMemberDetail;
import com.dagachi.app.schedule.entity.ClubSchedulePlaceDetail;
import com.dagachi.app.schedule.repository.ScheduleRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleRepository scheduleRepository;
	
	@Override
	public List<ClubSchedule> findSchedulesByClubId(int clubId) {
		return scheduleRepository.findSchedulesByClubId(clubId);
	}
	
	@Override
	public ScheduleDetailsDto findscheduleById(int no) {
		ScheduleDetailsDto schedule = scheduleRepository.findScheduleById(no);
		List<ClubSchedulePlaceDetail> places = scheduleRepository.getPlaces(no);
		schedule.setPlaces(places);
		List<ClubScheduleEnrollMemberDetail> enrollMembers = scheduleRepository.getEnrollMembers(no);
		schedule.setEnrollMembers(enrollMembers);
		return schedule;
	}
	
	@Override
	public ClubMember getWriterInfo(Map<String, Object> mIdAndcId) {
		return scheduleRepository.getWriterInfo(mIdAndcId);
	}
	
	@Override
	public ClubScheduleEnrollMember findEnrollMember(ClubScheduleEnrollMember memberInfo) {
		return scheduleRepository.findEnrollMember(memberInfo);
	}
	
	@Override
	public int insertEnrollMember(ClubScheduleEnrollMember memberInfo) {
		return scheduleRepository.insertEnrollMember(memberInfo);
	}
	
	@Override
	public int deleteEnrollMember(ClubScheduleEnrollMember memberInfo) {
		return scheduleRepository.deleteEnrollMember(memberInfo);
	}
	
	@Override
	public int insertSchedule(ScheduleCreateDto scheduleCreateDto) {
		int result = 0;
		result = scheduleRepository.insertSchedule(scheduleCreateDto);
		int scheduleId = scheduleCreateDto.getScheduleId();
		for (ClubSchedulePlace place : scheduleCreateDto.getPlaces()) {
			place.setScheduleId(scheduleId);
			result = scheduleRepository.insertSchedulePlace(place);
		}
		return result;
	}
	
	@Override
	public int updateScheduleStatus(int no) {
		return scheduleRepository.updateScheduleStatus(no);
	}
	
	@Override
	public int getMyRole(Map<String, Object> mIdAndcId) {
		return scheduleRepository.getMyRole(mIdAndcId);
	}
}

