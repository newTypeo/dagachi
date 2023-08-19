package com.dagachi.app.club.dto;

import lombok.Data;

@Data
public class ClubCreateDto {
	private String clubName;
	private String activityArea;
	private String category;
	private String tags;
	private String domain;
	private String introduce;
	private String enrollQuestion;
}
