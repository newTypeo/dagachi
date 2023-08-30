package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;
import com.dagachi.app.club.dto.BoardCommentDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder(toBuilder = true)
public class BoardComment {
	private int commentId;
	private int boardId;
	private String writer;
	private Integer commentRef;
	private String content;
	private LocalDateTime createdAt;
	private Status status;
	private int commentLevel;
	
}
