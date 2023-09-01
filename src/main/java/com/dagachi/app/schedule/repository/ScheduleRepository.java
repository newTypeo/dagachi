package com.dagachi.app.schedule.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.schedule.dto.ScheduleDetailsDto;
import com.dagachi.app.schedule.entity.ClubScheduleEnrollMemberDetail;
import com.dagachi.app.schedule.entity.ClubSchedulePlaceDetail;

@Mapper
public interface ScheduleRepository {

	@Select("select * from club_schedule where club_id = #{clubId}")
	List<ClubSchedule> findSchedulesByClubId(int clubId);

	@Select("select cs.*, mp.original_filename, mp.renamed_filename, m.nickname from club_schedule cs join member_profile mp on (cs.writer = mp.member_id) left join member m on (cs.writer = m.member_id) where schedule_id = #{no}")
	ScheduleDetailsDto findScheduleById(int no);

	@Select("select * from club_member where member_id = #{memberId} and club_id = #{clubId}")
	ClubMember getWriterInfo(Map<String, Object> mIdAndcId);

	@Select("select * from club_schedule_place where schedule_id = #{no} order by sequence")
	List<ClubSchedulePlaceDetail> getPlaces(int no);

	@Select("select csem.*, m.nickname from club_schedule_enroll_member csem join member m on (csem.member_id = m.member_id) where schedule_id = #{no}")
	List<ClubScheduleEnrollMemberDetail> getEnrollMembers(int no);

	@Select("select * from club_schedule_enroll_member where club_id = #{clubId} and schedule_id = #{scheduleId} and member_id = #{memberId}")
	ClubScheduleEnrollMember findEnrollMember(ClubScheduleEnrollMember memberInfo);

	@Insert("insert into club_schedule_enroll_member values (#{memberId}, #{clubId}, #{scheduleId}, default)")
	int insertEnrollMember(ClubScheduleEnrollMember memberInfo);

	@Delete("delete from club_schedule_enroll_member where member_id = #{memberId} and club_id = #{clubId} and schedule_id = #{scheduleId}")
	int deleteEnrollMember(ClubScheduleEnrollMember memberInfo);

}
