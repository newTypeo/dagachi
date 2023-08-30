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
	private String memberId;// 아이디 
	
	private String password;// 비밀번호 
	
	private String name;// 이름
	
	private String nickname;// 닉네임 
	
	private String phoneNo;	// 핸드폰 
	
	private String email;	// 이메일 
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;// 생일 
	
	private String mbti;// mbti 
	
	private String activityArea;// 주소 

	private String gender;// 성별 
	
	private String mainAreaId; // 주 활동 지역
	
	private List<String> interest;// 관심사

}
