package com.sh.app.member.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.member.entity.Member;
import com.sh.app.member.dto.MemberCreateDto;


public interface MemberService extends UserDetailsService {

	int insertMember(MemberCreateDto member);

	Member findMemberById(String memberId);

	int updateMember(Member member);

	List<Member> adminMemberList();

}
