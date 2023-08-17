package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ClubProfile {
	private int clubId;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
}
