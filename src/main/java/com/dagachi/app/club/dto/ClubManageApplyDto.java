package com.dagachi.app.club.dto;

import lombok.Data;

@Data
public class ClubManageApplyDto {
	private int clubId;
	private String memberId;
	private boolean permit;
}
