package com.dagachi.app.member.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.dagachi.app.club.entity.Club;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 나영
 * */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	private String memberId;
	private String password;
	private String name;	
	private String nickname;
	private String phoneNo;	
	private String email;	
	private LocalDate birthday;	
	private String gender;	
	private String mbti;	
	private String address;	
	private int reportCount;	
	private LocalDateTime enrollDate;	
	private LocalDateTime withdrawalDate;
	private LocalDateTime passwordChangeDate;	
	private LocalDateTime lastLoginDate;
	private String status; 

}
