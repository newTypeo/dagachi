package com.dagachi.app.club.dto;

import com.dagachi.app.club.entity.BoardComment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder(toBuilder = true)
@ToString(callSuper = true)
public class BoardCommentDto extends BoardComment{
	private String profile;
}
