package com.dagachi.app.club.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchClubBoard {
	private String searchKeywordVal;
	private String searchTypeVal;
	private int boardTypeVal;
}
