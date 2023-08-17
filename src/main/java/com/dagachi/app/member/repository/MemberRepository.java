package com.dagachi.app.member.repository;


import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;

import com.dagachi.app.member.dto.MemberCreateDto;


@Mapper
public interface MemberRepository {

	@Insert("insert into member values (#{memberId}, #{password},#{name}, #{nickname}, #{phoneNo}, #{email}, #{birthday, jdbcType=DATE}, #{gender}, #{mbti},  #{address}, 0, SYSDATE, NULL, SYSDATE, NULL, 'Y')")
	int insertMember(MemberCreateDto member);
	UserDetails loadUserByUsername(String username);


}
