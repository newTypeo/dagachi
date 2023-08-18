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
	@Pattern(regexp = "^[a-z0-9]{1,10}$/",
	message = "아이디는 소문자 영어, 숫자만 포함 10자리 미만이여야 합니다.")
	private String memberId;// 아이디 
	
	@NotBlank(message = "비밀번호 필수 입력 값입니다.")
	@Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,}$",
	message = "대소문자 영어, 숫자, 그리고 특수 기호를 포함해야합니다.")
	private String password;// 비밀번호 
	
	@NotBlank(message = "이름 필수 입력 값입니다.")
	@Pattern(regexp =  "^[가-힣]{2,8}$",
	message = "이름은 한글로만 2~8글자로 이루어져야 합니다.")
	private String name;// 이름
	
	@NotBlank(message = "닉네임 필수 입력 값입니다.") 
	@Pattern(regexp =  "^[가-힣]{2,8}$",
	message = "닉네임은 추후 변경이 가능합니다.")
	private String nickname;// 닉네임 
	
	@NotBlank(message = "핸드폰 필수 입력 값입니다.") 
	@Pattern(regexp =  "^\\+(?:[0-9] ?){6,14}[0-9]$",
	message = "핸드폰 양식에 맞게 작성하세요.")
	private String phoneNo;	// 핸드폰 
	
	@NotBlank(message = "이메일 필수 입력 값입니다.")
	@Pattern(regexp =  "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
	message = "이메일 양식에 맞게 작성하세요.")
	private String email;	// 이메일 
	
    @NotNull(message = "생년월일은 필수 입력 값입니다.")
    private LocalDate birthday;// 생일 
	
	@NotBlank(message = "성별 필수 입력 값입니다.") 
	private String gender;// 성별 
	
	private String originalFilename;// 원본 파일 저장명
	
	private String renamedFilename;// 저장 파일명
	
	private int mainAreaId; // 주 활동 지역
	
	private int sub1AreaId;// 서브 활동지역1
	
	private int sub2AreaId;// 서브 활동지역2
	
	@NotBlank(message = "관심사 필수") 
	private String interest;// 관심사

	@NotBlank(message = "mbti 필수") 
	private String mbti;// mbti 
	
	@NotBlank(message = "주소 필수") 
	private String address;// 주소 
	

	

}
