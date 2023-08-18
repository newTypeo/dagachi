package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class JoinClubMember {
	private String memberId;
	private String name;
	private String nickName;
	private LocalDateTime enrollAt;
	private int clubMemberRole;
}
