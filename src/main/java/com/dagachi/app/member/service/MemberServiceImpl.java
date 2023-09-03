package com.dagachi.app.member.service;

import java.util.Arrays;
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

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.dto.MemberKakaoDto;
import com.dagachi.app.member.dto.MemberKakaoUpdateDto;
import com.dagachi.app.member.dto.MemberPwUpdateDto;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.CbcLike;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberInterest;
import com.dagachi.app.member.entity.MemberLike;
import com.dagachi.app.member.entity.MemberProfile;
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
	    int result = 0;

	    result = memberRepository.insertMember(member);
	    log.debug("member = " + member);

	    memberRepository.insertActivityArea(member);

	    List<String> interestList = member.getInterest();

	    for (String interest : interestList) {
	        memberRepository.insertMemberInterest(member.getMemberId(), interest);
	    }

	    return result;
	}
	

//	@Override/*임시 회원가입*/
//	public int insertMember(MemberCreateDto member) {
//		return memberRepository.insertMember(member);
//	}
	
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
	
	@Override
	public int InquiryCreate(AdminInquiryCreateDto inquiry) {
		return memberRepository.InquiryCreate(inquiry);
	}

	/**
	 * Spring Security에 의해 db사용자를 조회할때 사용
	 * - username(pk)컬럼값으로 사용자/권한 정보 조회
	 * - username에 해당하는 사용자가 없는 경우 UsernameNotFoundException 던져야 한다.
	 */
	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		
		UserDetails memberDetails = memberRepository.loadUserByUsername(memberId);
		Member member = memberRepository.findMemberById(memberId);
		
		if(memberDetails == null || "N".equals(member.getStatus()))
			throw new UsernameNotFoundException(memberId);
		return memberDetails;
	}
	@Override
	public Member findMemberById(String memberId) {
		return memberRepository.findMemberById(memberId);
	}


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
	
	@Override
	public Member findMemberByEmail(String email) {
		return memberRepository.findMemberByEmail(email);
	}
	
	@Override
	public Member findMemberByName(String username) {
		return memberRepository.findMemberByName(username);
	}
	
	@Override
	public int memberLike(Map<String, Object> params) {
		return memberRepository.memberLike(params);
	}
	
	@Override
	public int cancelMemberLike(Map<String, Object> params) {
		return memberRepository.cancelMemberLike(params);
	}
	
	public int UpdateMember(Member member) {
		int result = 0;	
		result = memberRepository.updateMember(member);
		return result;
	}
	
	@Override
	public int updateMemberProfile(MemberProfile memberProfile) {
		int result = 0;
		result = memberRepository.updateMemberProfile(memberProfile);
		return result;
	}
	
	@Override
	public List<AdminInquiry> memberAdminInquiryList() {
		return memberRepository.memberAdminInquiryList();
	}
	
	@Override
	public List<MemberInterest> findMemberInterestsByMemberId(String memberId) {
		return memberRepository.findMemberInterestsByMemberId(memberId);
	}
	
	@Override
	public List<ClubMember> findClubMemberByMemberId(String memberId) {
		return memberRepository.findClubMemberByMemberId(memberId);
	}
		
	public List<MemberLike> findAllLikeMe(String loginMemberId) {
		return memberRepository.findAllLikeMe(loginMemberId);
	}
	
	@Override
	public int checkDuplicateMemberId(String memberId) {
		return memberRepository.checkDuplicateMemberId(memberId);
	}


	@Override
	public int KakaoMember(MemberKakaoDto memberKakaoDto) {
		return memberRepository.KakaoMember(memberKakaoDto);
	}
	
	@Override
	public Member findmemberIdByEmail(String email) {
		return memberRepository.findmemberIdByEmail(email);
	}


	@Override
	public int kakaoUpadteCreate(MemberCreateDto member) {
	    int result = 0;

	    result = memberRepository.kakaoUpadteCreate(member);
	    log.debug("member = " + member);

	    memberRepository.insertActivityArea(member);
	    List<String> interestList = member.getInterest();

	    for (String interest : interestList) {
	        memberRepository.insertMemberInterest(member.getMemberId(), interest);
	    }
	    return result;
	}
	
	@Override
	public int memberPwUpdate(MemberPwUpdateDto memberPwUpdateDto) {
		return memberRepository.memberPwUpdate(memberPwUpdateDto);
	}

	@Override
	public UserDetails checkKakao(String memberId) {
		return memberRepository.checkKakao(memberId);
	}
	@Override
	public int buyCreateClubTicket(String memberId) {
		return memberRepository.buyCreateClubTicket(memberId);
	}


	@Override
	public Member checkNickNameDuplicate(String nickname) {
		return memberRepository.checkNickNameDuplicate(nickname);
	}


	@Override
	public Member checkEmailDuplicate(String email) {
		return memberRepository.checkEmailDuplicate(email);
	}
	
	@Override
	public int checkDuplicateMemberIdAndMyId(Map<String, Object> params) {
		return memberRepository.checkDuplicateMemberIdAndMyId(params);
	}
	
}
