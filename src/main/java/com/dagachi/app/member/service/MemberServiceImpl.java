package com.dagachi.app.member.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.repository.MemberRepository;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberRepository memberRepository;

	@Override
	public int insertMember(MemberCreateDto member) {
		return memberRepository.insertMember(member);
	}
	
	@Override
	public List<Member> adminMemberList(Map<String, Object> params) {
		if((String) params.get("getCount") != null) {
			return memberRepository.adminMemberList(params);
		}
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberRepository.adminMemberList(rowBounds, params);
	}
	
	@Override
	public List<Member> adminQuitMemberList(Map<String, Object> params) {
		if((String) params.get("getCount") != null) {
		return memberRepository.adminQuitMemberList(params);
		}
		
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberRepository.adminQuitMemberList(rowBounds, params);
	}
	
	@Override
	public List<Member> adminReportMemberList(Map<String, Object> params) {
		if((String) params.get("getCount") != null) {
			return memberRepository.adminReportMemberList(params);
			}
			
			int limit = (int) params.get("limit");
			int page = (int) params.get("page");
			int offset = (page - 1) * limit;
			RowBounds rowBounds = new RowBounds(offset, limit);
			return memberRepository.adminReportMemberList(rowBounds, params);
	}

	/**
	 * Spring Security에 의해 db사용자를 조회할때 사용
	 * - username(pk)컬럼값으로 사용자/권한 정보 조회
	 * - username에 해당하는 사용자가 없는 경우 UsernameNotFoundException 던져야 한다.
	 */
	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		
		UserDetails memberDetails = memberRepository.loadUserByUsername(memberId);
		if(memberDetails == null)
			throw new UsernameNotFoundException(memberId);
		return memberDetails;
	}
	@Override
	public Member findMemberById(String memberId) {
		return memberRepository.findMemberById(memberId);
	}
	
	@Override
	public int memberDelete(String memberId) {
		return memberRepository.memberDelete(memberId);
	}

	@Override
	public Member findMemberBymemberId(String memberId) {
		return memberRepository.findMemberBymemberId(memberId);
	}


}
