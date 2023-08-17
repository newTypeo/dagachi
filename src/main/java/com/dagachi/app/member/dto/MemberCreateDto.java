package com.dagachi.app.member.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberCreateDto {
	
	
	@NotBlank(message = "필수") 
	private String memberId;
	
	@NotBlank(message = "필수")
	private String password;
	
	@NotBlank(message = "필수.")
	private String name;	
	
	@NotBlank(message = "필수") 
	private String nickName;
	
	@NotBlank(message = "필수") 
	private String phoneNo;	
	
	@NotBlank(message = "필수")
	private String email;	
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDateTime birthday;	
	
	private String gender;	
	
	private String mbti;	
	
	@NotBlank(message = "주소는 필수입니다.") 
	private String address;	
	
	

}
