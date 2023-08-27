package com.dagachi.app.club.dto;

import lombok.Data;

@Data
public class ClubAndImage {
	private int clubId;
	private String clubName;
	private String category;
	private boolean status;
	private int reportCount;
	private String introduce;
	private String domain;
	private String renamedFilename;
	private int MemberCount;
	private String clubTag;
}
