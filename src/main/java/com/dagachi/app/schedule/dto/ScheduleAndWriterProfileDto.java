package com.dagachi.app.schedule.dto;

import com.dagachi.app.club.entity.ClubSchedule;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class ScheduleAndWriterProfileDto extends ClubSchedule {
	private String originalFilename; // 원본 파일명
	private String renamedFilename;// 저장 파일명
	
	private String nickname;
}
