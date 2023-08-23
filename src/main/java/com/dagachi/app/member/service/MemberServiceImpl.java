package com.dagachi.app.member.service;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberProfile;
import com.dagachi.app.member.repository.MemberRepository;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberRepository memberRepository;

	@Override/*임시 회원가입*/
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

	/* 회원가입 (지우지마삼)
	 * @Override public int insertMember(MemberDetails member1) {
	 * 
	 * int result = 0;
	 * 
	 * result = memberRepository.insertMember(member1); log.debug("member = " +
	 * member1);
	 * 
	 * MemberProfile memberProfile = ((MemberDetails) member1).getMemberProfile();
	 * if(memberProfile != null) { memberProfile.setMemberId(member1.getMemberId());
	 * result = memberRepository.insertMemberProfile(memberProfile); }
	 * 
	 * memberRepository.insertActivityArea(member1);
	 * memberRepository.insertMemberInterest(member1);
	 * 
	 * 
	 * return result; }
	 */
	@Override
	public List<Member> quitMemberSearch(String keyword, String column) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	
	@Override
	public int memberDelete(String memberId) {
		return memberRepository.memberDelete(memberId);
	}

	@Override
	public Member findMemberBymemberId(String memberId) {
		return memberRepository.findMemberBymemberId(memberId);
	}

	@Override
	public ActivityArea findActivityAreaById(String memberId) {
		return memberRepository.findActivityAreaById(memberId);
	}
	public MemberProfile findMemberProfile(String memberId) {
		return memberRepository.findMemberProfile(memberId);
	}
	
	@Override
	public List<MemberProfile> findMemberProfileByClubId(int clubId) {
		return memberRepository.findMemberProfileByClubId(clubId);
	}
}
