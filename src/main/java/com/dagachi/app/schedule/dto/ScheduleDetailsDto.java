package com.dagachi.app.schedule.dto;

import java.util.List;

import com.dagachi.app.club.entity.ClubSchedule;
import com.dagachi.app.club.entity.ClubScheduleEnrollMember;
import com.dagachi.app.schedule.entity.ClubScheduleEnrollMemberDetail;
import com.dagachi.app.schedule.entity.ClubSchedulePlaceDetail;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class ScheduleDetailsDto extends ClubSchedule {
	
	private List<ClubScheduleEnrollMemberDetail> enrollMembers;
	private List<ClubSchedulePlaceDetail> places;
	
	private String originalFilename; // 원본 파일명
	private String renamedFilename;// 저장 파일명
	
	private String nickname;
}
