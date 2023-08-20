package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClubBoardAttachment {
	
	private int id;
	private int boardId;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createAt;
	private char thumbnail;
	
}
