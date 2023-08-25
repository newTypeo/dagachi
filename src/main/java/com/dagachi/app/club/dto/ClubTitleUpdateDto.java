package com.dagachi.app.club.dto;

import java.time.LocalDate;

import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.member.dto.MemberUpdateDto;
import com.dagachi.app.member.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ClubTitleUpdateDto extends ClubLayout{
	
	private String title;
	private String mainImage;
	private String mainContent;
}
