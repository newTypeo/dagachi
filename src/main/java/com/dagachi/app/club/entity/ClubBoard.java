package com.dagachi.app.club.entity;

import java.time.LocalDateTime;
import java.util.List;

import com.dagachi.app.club.common.Status;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ClubBoard {

	private int boardId;
	private int clubId;
	private String writer;
	private String title;
	private String content;
	private LocalDateTime createdAt;
	private int type;
	private Status status;
	private int likeCount;
	
}
