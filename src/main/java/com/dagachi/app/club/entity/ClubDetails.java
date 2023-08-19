package com.dagachi.app.club.entity;

import java.util.List;

import com.dagachi.app.member.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder // 부모필드까지 설정가능한 Builder
public class ClubDetails extends Club {
	private Member member;
	private List<String> tagList;
	private ClubProfile clubProfile;
}
