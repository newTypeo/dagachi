package com.dagachi.app.member.service;


import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.Member;



public interface MemberService extends UserDetailsService {
	int insertMember(@Valid MemberCreateDto member);

	List<Member> adminMemberList(Map<String, Object> params);

	List<Member> memberSearch(String keyword, String column, Map<String, Object> params);

	List<Member> adminQuitMemberList();

	List<Member> quitMemberSearch(String keyword, String column);

	int getTotalCount();
}
