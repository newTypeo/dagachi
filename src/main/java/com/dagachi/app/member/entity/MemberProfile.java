package com.dagachi.app.member.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data // 회원 프로필 사진
public class MemberProfile {
	
	private String memberId;
	private String originalFilename; // 원본 파일명
	private String renamedFilename;// 저장 파일명
	private LocalDateTime createdAt;//변경일

}
