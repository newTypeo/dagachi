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
public class MamberCreateDto {
	
	
	@NotBlank(message = "이름은 필수입니다.") 
	private String memberId;
	
	@NotBlank(message = "이름은 필수입니다.")
	@Pattern(regexp = "\\^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@!#_]).{8,}$", message = "비밀번호는 영문자/숫자 4글자이상이어야 합니다.")
	private String password;
	
	@NotBlank(message = "이름은 필수입니다.")
	private String name;	
	
	@NotBlank(message = "이름은 필수입니다.") 
	private String nickname;
	
	@NotBlank(message = "이름은 필수입니다.") 
	private String phoneNo;	
	
	@NotBlank(message = "이름은 필수입니다.")
	private String email;	
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDateTime birthday;	
	
	private String gender;	
	
	private String mbti;	
	
	@NotBlank(message = "주소는 필수입니다.") 
	private String address;	
	
	

}
