package com.dagachi.app.member.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberProfile {
	
	private String memberId;
	private String originalFilename; // 원본 파일명
	private String renamedFilename;// 저장 파일명
	private LocalDateTime createdAt;//변경일

}
