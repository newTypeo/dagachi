package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import com.dagachi.app.club.entity.ClubProfile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubSearchDto {
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
	private int profileClubId;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime profileCreatedAt;
	private int memberCount;
}
