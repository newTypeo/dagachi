package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class ClubProfile extends Club {
	private int clubId;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
}
