package com.dagachi.app.club.dto;

import lombok.Data;

@Data
public class ClubStyleUpdateDto {
	private int clubId;
	private int type;
	private String font;
	private String backgroundColor;
	private String fontColor;
	private String pointColor;
}
