package com.dagachi.app.admin.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.NotNull;

import com.dagachi.app.member.dto.MemberCreateDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminInquiryCreateDto {
	private String inquiryId;
	private String memberId;
	private String title;
	private String content; 
	private int type;
	private int open;
	
}
