package com.dagachi.app.schedule.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.entity.ClubScheduleEnrollMember;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class ClubScheduleEnrollMemberDetail extends ClubScheduleEnrollMember {
	private String nickname; 
}
