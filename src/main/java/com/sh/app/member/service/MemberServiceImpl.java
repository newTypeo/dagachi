package com.sh.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.app.member.dto.MemberCreateDto;
import com.sh.app.member.entity.Member;
import com.sh.app.member.repository.MemberRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberRepository memberRepository;
	
	@Override
	public int insertMember(MemberCreateDto member) {
		int result = 0;
		// member테이블 등록
		result = memberRepository.insertMember(member);
		// authority테이블 등록
		result = memberRepository.insertAuthority(member);
		return result;
	}
	@Override
	public Member findMemberById(String memberId) {
		return memberRepository.findMemberById(memberId);
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
	public int updateMember(Member member) {
		return memberRepository.updateMember(member);
	}
}





