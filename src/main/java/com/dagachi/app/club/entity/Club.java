package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Club {
	private int clubId;
	private String clubName;
	private String activityArea;
	private String category;
	private LocalDateTime createdAt;
	private LocalDateTime lastActivityDate;
	private boolean status;
	private int reportCount;
	private String introduce;
	private String enrollQuestion;
	private String domain;
}
