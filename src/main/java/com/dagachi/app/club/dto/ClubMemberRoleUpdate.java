package com.dagachi.app.club.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ClubMemberRoleUpdate {
	private String memberId;
	private int clubMemberRole;
}
