package com.dagachi.app.schedule.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.schedule.repository.scheduleRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class scheduleServiceImpl implements scheduleService {

	@Autowired
	private scheduleRepository scheduleRepository;
	
	@Override
		public List<ClubSchedule> findSchedulesByClubId(int clubId) {
			return scheduleRepository.findSchedulesByClubId(clubId);
		}
}
