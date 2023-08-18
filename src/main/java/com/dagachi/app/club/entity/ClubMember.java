package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ClubMember {
	private String memberId;
	private int number;
	private LocalDateTime enrollAt;
	private LocalDateTime lastActivityDate;
	private int clubMemberRole;
	private int enrollCount;
}
