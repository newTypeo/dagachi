package com.dagachi.app.club.entity;

import java.time.LocalDateTime;
import java.util.List;

import com.dagachi.app.member.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
public class ClubBoardDetails extends ClubBoard{

		private Member member;
		private List<ClubBoardAttachment> attachments;
		
}
