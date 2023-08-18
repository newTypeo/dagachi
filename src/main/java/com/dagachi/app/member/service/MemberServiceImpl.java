package com.dagachi.app.member.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.repository.MemberRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberRepository memberRepository;

	@Override
	public int insertMember(MemberCreateDto member) {
		int result = 0;
		result = memberRepository.insertMember(member);
		return result;
	}
	
	@Override
	public List<Member> adminMemberList(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberRepository.adminMemberList(rowBounds);
	}
	
	@Override
	public List<Member> memberSearch(String keyword, String column, Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberRepository.memberSearch(keyword, column, rowBounds);
	}
	
	@Override
	public List<Member> adminQuitMemberList() {
		return memberRepository.adminQuitMemberList();
	}
	
	@Override
	public List<Member> quitMemberSearch(String keyword, String column) {
		return memberRepository.quitMemberSearch(keyword, column);
	}
	
	@Override
	public int getTotalCount() {
		return memberRepository.getTotalCount();
	
	}	
	
	/**
	 * Spring Security에 의해 db사용자를 조회할때 사용
	 * - username(pk)컬럼값으로 사용자/권한 정보 조회
	 * - username에 해당하는 사용자가 없는 경우 UsernameNotFoundException 던져야 한다.
	 */
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDetails memberDetails = memberRepository.loadUserByUsername(username);
		log.debug("memberDetails = {}", memberDetails);
		if(memberDetails == null)
			throw new UsernameNotFoundException(username);
		return memberDetails;
	}

	@Override
	public Member findMemberById(String memberId) {
		return memberRepository.findMemberById(memberId);
	}

}
