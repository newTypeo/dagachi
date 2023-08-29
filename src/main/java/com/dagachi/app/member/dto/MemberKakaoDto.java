package com.dagachi.app.member.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberKakaoDto {
	private String memberId; // 회원 아이디
	private String password; // 비밀번호
	private String name; // 회원 아이디	
	private String email;	 //전화번호
	
}