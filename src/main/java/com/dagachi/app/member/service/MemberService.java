package com.dagachi.app.member.service;


import javax.validation.Valid;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.member.dto.MemberCreateDto;



public interface MemberService extends UserDetailsService {
	int insertMember(@Valid MemberCreateDto member);
}
