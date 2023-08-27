package com.dagachi.app.admin.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminInquiryUpdateDto {
	private String inquiryId;
	private int status;  
	private String adminId;
	private String response;
	private int open;
	private LocalDateTime responseAt;

}
