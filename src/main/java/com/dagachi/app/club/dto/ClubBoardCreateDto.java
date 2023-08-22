package com.dagachi.app.club.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import com.dagachi.app.club.entity.ClubBoard;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ClubBoardCreateDto {

	@NotBlank(message = "제목은 필수입니다.")
	private String title;
	@Min (value = 0,message = "게시글 타입은 필수입니다.")
	private int type;
	@NotBlank(message = "내용은 필수입니다.")
	private String content;
	
	public ClubBoard toBoard() {
		return ClubBoard.builder()
				.title(title)
				.type(type)
				.content(content)
				.build();
	}
	
}
