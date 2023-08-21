package com.dagachi.app.member.repository;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;
import org.springframework.security.core.userdetails.UserDetails;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;


@Mapper
public interface MemberRepository {

	@Insert("insert into member values (#{memberId}, #{password},#{name}, #{nickname}, #{phoneNo}, #{email}, #{birthday, jdbcType=DATE}, #{gender}, #{mbti},  #{address}, 0, SYSDATE, NULL, SYSDATE, NULL, 'Y')")
	int insertMember(MemberCreateDto member);
	
	MemberDetails loadUserByUsername(String memberId);
	
	@Select("select * from member where member_id =#{memberId}")
	Member findMemberById(String memberId);
	
	//회원 목록 조회 및 검색
	List<Member> adminMemberList(RowBounds rowBounds, Map<String, Object> params);
	List<Member> adminMemberList(Map<String, Object> params);
	//탈퇴회원 목록 조회 및 검색
	List<Member> adminQuitMemberList(RowBounds rowBounds, Map<String, Object> params);
	List<Member> adminQuitMemberList(Map<String, Object> params);
	//신고회원 목록 조회 및 검색
	List<Member> adminReportMemberList(RowBounds rowBounds, Map<String, Object> params);
	List<Member> adminReportMemberList(Map<String, Object> params);

	@Select("select count(*) from member")
	int getTotalCount();


	

	

}
