package com.dagachi.app.club.entity;

import com.dagachi.app.club.common.Status;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClubBoard {

	private int boardId;
	private int clubId;
	private String writer;
	private String title;
	private String content;
	private Status status;
	private int likeCount;
	
}
