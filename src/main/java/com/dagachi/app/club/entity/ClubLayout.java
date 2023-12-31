package com.dagachi.app.club.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ClubLayout {
	private int clubId;
	private int type;
	private String font;
	private String backgroundColor;
	private String fontColor;
	private String pointColor;
	private String title;
	private String mainImage;
	private String mainContent;
}
