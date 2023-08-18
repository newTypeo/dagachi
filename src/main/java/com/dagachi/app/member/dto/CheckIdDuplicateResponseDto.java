package com.dagachi.app.member.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CheckIdDuplicateResponseDto {
		
		private String memberId;
		
		//중복 검사 여부 컬럼 ( 중복없음 true, 중복false ) 
		private boolean available; 
	

}
