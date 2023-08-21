package com.dagachi.app.member.entity;

import lombok.Data;

@Data // 회원  권한
public class Authority {
	
	private String memberId;
	private String auth;

}
