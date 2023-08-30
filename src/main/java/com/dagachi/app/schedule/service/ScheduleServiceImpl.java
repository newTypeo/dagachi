package com.dagachi.app.schedule.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.schedule.dto.ScheduleAndWriterProfileDto;
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
	public ScheduleAndWriterProfileDto findscheduleById(int no) {
		return scheduleRepository.findScheduleById(no);
	}
	
	@Override
	public ClubMember getWriterInfo(Map<String, Object> mIdAndcId) {
		return scheduleRepository.getWriterInfo(mIdAndcId);
	}
}

