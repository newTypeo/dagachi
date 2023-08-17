package com.sh.app.member.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.sh.app.member.dto.MemberCreateDto;
import com.sh.app.member.entity.Member;

public interface MemberService extends UserDetailsService {

	int insertMember(MemberCreateDto member);

	Member findMemberById(String memberId);

	int updateMember(Member member);
	
}
