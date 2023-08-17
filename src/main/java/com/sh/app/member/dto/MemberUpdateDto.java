package com.sh.app.member.dto;

import java.time.LocalDate;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;

import com.sh.app.member.entity.Member;

import lombok.Data;

@Data
public class MemberUpdateDto {
	@NotBlank(message = "이름은 필수입니다.") // null, "", "  " 모두 허용하지 않음
	private String name;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthday;
	
	@Email(message = "유효한 이메일을 작성해주세요.") // "" 허용
	private String email;

	public Member toMember() {
		return Member.builder()
			.name(name)
			.birthday(birthday)
			.email(email)
			.build();
	}
}
