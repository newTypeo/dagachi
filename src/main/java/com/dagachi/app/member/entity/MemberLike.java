package com.dagachi.app.member.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberLike {
	
	private int likeId;
	private String memberId;
	private String likeSender;
	private LocalDateTime createAt;

}
