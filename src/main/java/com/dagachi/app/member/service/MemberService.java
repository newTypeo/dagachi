package com.dagachi.app.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.dto.MemberKakaoDto;
import com.dagachi.app.member.dto.MemberKakaoUpdateDto;
import com.dagachi.app.member.dto.MemberPwUpdateDto;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberInterest;
import com.dagachi.app.member.entity.MemberLike;
import com.dagachi.app.member.entity.MemberProfile;

public interface MemberService extends UserDetailsService {

	Member findMemberById(String memberId);
	
	List<Member> adminMemberList(Map<String, Object> params);

	List<Member> adminQuitMemberList(Map<String, Object> params);

	List<Member> adminReportMemberList(Map<String, Object> params);

	List<Member> quitMemberSearch(String keyword, String column);

	int getTotalCount();
	
	int memberDelete(String memberId);

	Member findMemberBymemberId(String memberId);
	
//	/*임시로그인*/
//	int insertMember(MemberCreateDto member);

	int InquiryCreate(AdminInquiryCreateDto inquiry);

	ActivityArea findActivityAreaById(String memberId);
	
	
	MemberProfile findMemberProfile(String memberId);

	List<MemberProfile> findMemberProfileByClubId(int clubId);

	Member findMemberByName(String username);

	Member findMemberByEmail(String email);


	int memberLike(Map<String, Object> params);

	int UpdateMember(Member member);

	int updateMemberProfile(MemberProfile memberProfile);
	
	List<AdminInquiry> memberAdminInquiryList();

	List<MemberInterest> findMemberInterestsByMemberId(String memberId);

	List<ClubMember> findClubMemberByMemberId(String memberId);
	
	List<MemberLike> findAllLikeMe(String loginMemberId);

	int checkDuplicateMemberId(String memberId);

	int insertMember(MemberCreateDto member);

	int cancelMemberLike(Map<String, Object> params);
	
	Member findmemberIdByEmail(String email);
	
	int KakaoMember(MemberDetails memberDetails);

	int kakaoUpadteCreate(MemberKakaoUpdateDto member);
	
	int memberPwUpdate(MemberPwUpdateDto memberPwUpdateDto);

	int checkKakao(String memberId);
	
	int buyCreateClubTicket(String memberId);

	Member checkNickNameDuplicate(String nickname);

	Member checkEmailDuplicate(String email);
	
	int checkDuplicateMemberIdAndMyId(Map<String, Object> params);

}