package com.dagachi.app.schedule.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.dagachi.app.club.entity.ClubSchedule;

@Mapper
public interface scheduleRepository {

	@Select("select * from club_schedule where club_id = #{clubId}")
	List<ClubSchedule> findSchedulesByClubId(int clubId);

}
