package com.dagachi.app.schedule.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.dagachi.app.club.dto.ClubScheduleAndMemberDto;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.club.entity.ClubSchedulePlace;
import com.dagachi.app.schedule.dto.ScheduleCreateDto;
import com.dagachi.app.schedule.dto.ScheduleDetailsDto;
import com.dagachi.app.schedule.entity.ClubScheduleEnrollMemberDetail;
import com.dagachi.app.schedule.entity.ClubSchedulePlaceDetail;

@Mapper
public interface ScheduleRepository {

	List<ClubScheduleAndMemberDto> findSchedulesByDomain(String domain);

	@Select("select cs.*, mp.original_filename, mp.renamed_filename, m.nickname from club_schedule cs join member_profile mp on (cs.writer = mp.member_id) left join member m on (cs.writer = m.member_id) where cs.schedule_id = #{no} and cs.status = 'Y'")
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

	@Insert("insert into club_schedule values (seq_club_schedule_id.nextval, #{clubId}, #{title}, #{writer}, #{content}, #{startDate}, #{endDate}, #{expence}, #{capacity}, default, default, default)")
	@SelectKey(
			before = false, 
			keyProperty = "scheduleId", 
			resultType = int.class,
			statement = "select seq_club_schedule_id.currval from dual")
	int insertSchedule(ScheduleCreateDto scheduleCreateDto);

	@Insert("insert into club_schedule_place values (seq_club_schedule_place_id.nextval, #{scheduleId}, #{name}, #{address}, #{details}, #{sequence}, #{startTime})")
	int insertSchedulePlace(ClubSchedulePlace place);

	@Update("update club_schedule set status = 'N' where schedule_id = #{no}")
	int updateScheduleStatus(int no);

	@Select("select club_member_role from club_member where club_id = #{clubId} and member_id = #{myId}")
	int getMyRole(Map<String, Object> mIdAndcId);

}
