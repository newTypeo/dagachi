package com.dagachi.app.chat.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubInfo {
	
	private int clubId;
	private String clubName;
	private String renamedFilename;
}
