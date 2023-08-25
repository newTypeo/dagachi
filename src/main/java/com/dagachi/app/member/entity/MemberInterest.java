package com.dagachi.app.member.entity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubProfile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberInterest {
	
	private String memberId;
	private String interest;

}
