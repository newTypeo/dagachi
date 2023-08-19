package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
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
