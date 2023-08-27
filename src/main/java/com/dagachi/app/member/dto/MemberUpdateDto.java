package com.dagachi.app.member.dto;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.member.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder // 부모필드까지 설정가능한 Builder
public class MemberUpdateDto extends Member{

	private String name;
	private String nickname;
	private String phoneNo;
	private String address;
	private String gender;
	private String mbti;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthday;
	
	
}
