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
	
	@NotBlank(message = "아이디는 필수 입력 값입니다.")
	private String memberId;// 아이디 
	
	@NotBlank(message = "비밀번호 필수 입력 값입니다.")
	private String password;// 비밀번호 
	
	@NotBlank(message = "이름 필수 입력 값입니다.")
	private String name;// 이름
	
	@NotBlank(message = "닉네임 필수 입력 값입니다.") 
	private String nickname;// 닉네임 
	
	@NotBlank(message = "핸드폰 필수 입력 값입니다.") 
	private String phoneNo;	// 핸드폰 
	
	@NotBlank(message = "이메일 필수 입력 값입니다.")
	private String email;	// 이메일 
	
    @NotNull(message = "생년월일은 필수 입력 값입니다.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;// 생일 
	
	@NotBlank(message = "성별 필수 입력 값입니다.") 
	private String gender;// 성별 
	
	private String originalFilename;// 원본 파일 저장명
	
	private String renamedFilename;// 저장 파일명
	
	private int mainAreaId; // 주 활동 지역
	
	private int sub1AreaId;// 서브 활동지역1
	
	private int sub2AreaId;// 서브 활동지역2
	
	private String interest;// 관심사

	@NotBlank(message = "mbti 필수") 
	private String mbti;// mbti 
	
	@NotBlank(message = "주소 필수") 
	private String address;// 주소 
	

	

}
