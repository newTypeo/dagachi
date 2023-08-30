package com.dagachi.app.member.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MemberPwUpdateDto {

	private String password;
	private String email;
	
	
}
