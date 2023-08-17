package com.dagachi.app.member.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
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
	
	
	@NotBlank(message = "아이디 필수") 
	private String memberId;
	
	@NotBlank(message = "비밀번호 필수")
	private String password;
	
	@NotBlank(message = "이름 필수")
	private String name;	
	
	@NotBlank(message = "닉네임 필수") 
	private String nickname;
	
	@NotBlank(message = "핸드폰 필수") 
	private String phoneNo;	
	
	@NotBlank(message = "이메일 필수")
	private String email;	
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    @NotNull(message = "생일을 필수")
    private LocalDate birthday;
	
	@NotBlank(message = "성별 필수") 
	private String gender;	

	private String mbti;	
	
	@NotBlank(message = "주소 필수") 
	private String address;	
	
	

}
