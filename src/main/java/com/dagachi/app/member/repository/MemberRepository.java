package com.dagachi.app.member.repository;


import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;
import org.springframework.security.core.userdetails.UserDetails;

import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.Member;


@Mapper
public interface MemberRepository {

	@Insert("insert into member values (#{memberId}, #{password},#{name}, #{nickname}, #{phoneNo}, #{email}, #{birthday, jdbcType=DATE}, #{gender}, #{mbti},  #{address}, 0, SYSDATE, NULL, SYSDATE, NULL, 'Y')")
	int insertMember(MemberCreateDto member);
	
	UserDetails loadUserByUsername(String username);
	
	@Select("select * from member where member_id =#{memberId}")
	Member findMemberById(String memberId);
	
	@Select("select * from member")
	List<Member> adminMemberList(RowBounds rowBounds);
	
	@Select("select * from member where ${column} like '%' || #{keyword} || '%'")
	List<Member> memberSearch(String keyword, String column, RowBounds rowBounds);
	
	@Select("select * from member where withdrawal_date is null")
	List<Member> adminQuitMemberList();
	
	@Select("select * from member where ${column} like '%' || #{keyword} || '%' and withdrawal_date is null")
	List<Member> quitMemberSearch(String keyword, String column);
	
	@Select("select count(*) from member")
	int getTotalCount();
	

}
