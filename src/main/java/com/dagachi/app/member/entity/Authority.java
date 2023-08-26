package com.dagachi.app.member.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubProfile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor // 회원  권한
public class Authority extends Club{
	
	private String memberId;
	private String auth;

}
