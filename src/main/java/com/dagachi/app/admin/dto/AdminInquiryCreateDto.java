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
	private String InquiryId;
	private String writer;
	private String title;
	private String content; 
	private LocalDateTime createdAt;
	private int type;
	private int status; 
	private String adminId;
	private String response;
	

}
