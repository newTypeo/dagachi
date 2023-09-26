package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ClubDetailDto {
	
	private String clubName;
	private LocalDateTime createdAt;
	private int clubId;
	private int type;
	private String font;
	private String backgroundColor;
	private String fontColor;
	private String pointColor;
	private String title;
	private String mainImage;
	private String mainContent;
	private int memberCount ;
	private int memberRole;
}
