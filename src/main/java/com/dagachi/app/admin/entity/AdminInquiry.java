package com.dagachi.app.admin.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.entity.Club;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class AdminInquiry {
	private String inquiryId;
	private String writer;
	private String title;
	private String content; 
	private LocalDateTime createdAt;
	private int type;
	private int status; 
	private String adminId;
	private String response;
	private int open;
	private LocalDateTime responseAt;
	
}
