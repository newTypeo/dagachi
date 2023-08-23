package com.dagachi.app.club.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubApply {
	private int clubId;
	private String memberId;
	private String answer;
}
