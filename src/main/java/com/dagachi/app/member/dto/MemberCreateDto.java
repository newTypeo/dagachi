package com.dagachi.app.member.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.dagachi.app.member.entity.MemberDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberCreateDto {
	@NotBlank(message = "아이디는 필수입니다.")
	private String memberId;// 아이디 
	
	@NotBlank(message = "비밀번호는 필수입니다.")
	private String password;// 비밀번호 
	
	@NotBlank(message = "이름은 필수입니다.")
	private String name;// 이름
	
	@NotBlank(message = "닉네임은 필수입니다.")
	private String nickname;// 닉네임 
	
	@NotBlank(message = "핸드폰 번호는 필수입니다.")
	private String phoneNo;	// 핸드폰 
	
	@NotBlank(message = "이메일은 필수입니다.")
	private String email;	// 이메일 
	
	@NotBlank(message = "아이디는 필수입니다.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;// 생일 
	
	@NotBlank(message = "mbti는 필수입니다.")
	private String mbti;// mbti 
	@NotBlank(message = "아이디는 필수입니다.")
	
	@NotBlank(message = "주소는 필수입니다.")
	private String activityArea;// 주소 
	
	@NotBlank(message = "성별 필수입니다.")
	private String gender;// 성별 
	
	@NotBlank(message = "활동지역 필수입니다.")
	private String mainAreaId; // 주 활동 지역

	@NotBlank(message = "관심사는 필수입니다.")
	private List<String> interest;// 관심사

}
