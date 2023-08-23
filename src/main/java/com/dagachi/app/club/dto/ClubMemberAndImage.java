package com.dagachi.app.club.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClubMemberAndImage {
	
	private String memberId;
	private String name;
	private String nickname;
	private String gender;
	private String mbti;
	private String email;
	private String renamedFilename;
	
}
