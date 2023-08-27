package com.dagachi.app.club.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ClubEnrollDto {
	private int clubId;
	private String memberId;
	private String answer;
}
