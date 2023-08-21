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
	
	private String memberId; // 회원 아이디
	private String password; // 비밀번호
	private String name; // 회원 아이디	
	private String nickname; //이름
	private String phoneNo;	 // 닉네임
	private String email;	 //전화번호
	private LocalDate birthday;	 //이메일
	private String gender; //생일
	private String mbti; // 성별
	private String address; //MBTI
	private int reportCount; //신고 당한 횟수
	private LocalDateTime enrollDate; // 가입일	
	private LocalDateTime withdrawalDate; //탈퇴일
	private LocalDateTime passwordChangeDate; //비밀번호 변경일	
	private LocalDateTime lastLoginDate; // 마지막 로그인날짜
	private String status; // 활성화 여부 

}
