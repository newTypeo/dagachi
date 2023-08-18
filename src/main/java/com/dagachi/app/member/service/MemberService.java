package com.dagachi.app.member.service;


import javax.validation.Valid;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.Member;



public interface MemberService extends UserDetailsService {
	int insertMember(@Valid MemberCreateDto member);

	Member findMemberById(String memberId);
	
	
}
