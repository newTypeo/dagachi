package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;

import lombok.Data;

@Data
public class BoardAndImageDto {
	
	private int boardId;
	
	private int clubId;
	private String writer;
	private String title;
	private String content;
	private LocalDateTime createdAt;
	private int type;
	private Status status;
	private int likeCount;
	
	private int id;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createAt;
	private char thumbnail;

}
