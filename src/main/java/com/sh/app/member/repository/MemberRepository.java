package com.sh.app.member.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.app.member.dto.MemberCreateDto;
import com.sh.app.member.entity.Member;
import com.sh.app.member.entity.MemberDetails;

@Mapper
public interface MemberRepository {

	@Insert("insert into member values (#{memberId}, #{password}, #{name}, #{birthday, jdbcType=DATE}, #{email, jdbcType=VARCHAR}, default)")
	int insertMember(MemberCreateDto member);
	
	@Insert("insert into authority values (#{memberId}, 'ROLE_USER')")
	int insertAuthority(MemberCreateDto member);

	@Select("select * from member where member_id = #{memberId}")
	Member findMemberById(String memberId);

	MemberDetails loadUserByUsername(String username);

	@Update("update member set name = #{name}, birthday = #{birthday}, email = #{email} where member_id = #{memberId}")
	int updateMember(Member member);
	

}
