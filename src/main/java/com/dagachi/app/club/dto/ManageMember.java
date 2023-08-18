package com.dagachi.app.club.dto;

import com.dagachi.app.member.entity.Member;

import lombok.Data;

@Data
public class ManageMember {
	private String memberId;
	private String answer;
	private String name;
	private String nickname;
}
