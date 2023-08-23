package com.dagachi.app.member.service;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;



public interface MemberService extends UserDetailsService {
	
	

	Member findMemberById(String memberId);
	
	List<Member> adminMemberList(Map<String, Object> params);

	List<Member> adminQuitMemberList(Map<String, Object> params);

	List<Member> adminReportMemberList(Map<String, Object> params);

	List<Member> quitMemberSearch(String keyword, String column);

	int getTotalCount();
	
	int memberDelete(String memberId);

	Member findMemberBymemberId(String memberId);
	/*임시로그인*/
	int insertMember(MemberCreateDto member);

	int InquiryCreate(AdminInquiryCreateDto inquiry);


}
