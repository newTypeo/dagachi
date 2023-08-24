package com.dagachi.app.member.repository;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;
import org.springframework.security.core.userdetails.UserDetails;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberProfile;


@Mapper
public interface MemberRepository {
	
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

	@Update("update member set status = 'N' where member_id = #{memberId}")
	int memberDelete(String memberId);

	@Select("select * from member where member_Id = #{memberId}")
	Member findMemberBymemberId(String memberId);


	
	/*
	 * // 멤버 회원가입 추가 ( 지우지마삼 )
	 * 
	 * @Insert("insert into member values (#{memberId}, #{password},#{name}, #{nickname}, #{phoneNo}, #{email}, #{birthday, jdbcType=DATE}, #{gender}, #{mbti},  #{address}, 0, SYSDATE, NULL, SYSDATE, NULL, 'Y')"
	 * ) int insertMember(MemberDetails member1);
	 * 
	 * // 지역
	 * 
	 * @Insert("INSERT INTO activity_area values(#{memberId}, #{main_area_id}, #{sub1_area_id}, #{sub2_area_id})"
	 * ) void insertActivityArea(MemberDetails member1);
	 * 
	 * // 관심사
	 * 
	 * @Insert("INSERT INTO member_interest values(#{memberId}, #{Interest})") void
	 * insertMemberInterest(MemberDetails member1);
	 * 
	 * // 프로필 사진
	 * 
	 * @Insert("INSERT INTO member_profile values(#{memberId},#{original_filename},#{renamed_filename},default)"
	 * ) int insertMemberProfile(MemberProfile memberProfile);
	 */

	/*임시 회원가입 (지우지 마삼) */
	@Insert("insert into member values (#{memberId}, #{password},#{name}, #{nickname}, #{phoneNo}, #{email}, #{birthday, jdbcType=DATE}, #{gender}, #{mbti},  #{address}, 0, SYSDATE, NULL, SYSDATE, NULL, 'Y')")
	int insertMember(MemberCreateDto member);

	@Insert("insert into admin_Inquiry values (seq_Inquiry_id.nextval,#{memberId},#{title} ,#{content}, SYSDATE ,#{type},0,NULL,NULL,#{open},NULL)")
	int InquiryCreate(AdminInquiryCreateDto inquiry);
	
	@Select("select * from activity_area where member_id = #{memberId}")
	ActivityArea findActivityAreaById(String memberId);


	@Select("select * from member_profile where member_id = #{memberId}")
	MemberProfile findMemberProfile(String memberId);

	@Select("select * from club_member a join member_profile b on a.member_id=b.member_id where club_id = #{clubId}")
	List<MemberProfile> findMemberProfileByClubId(int clubId);

	@Select("select * from member where email = #{email}")
	Member findMemberByEmail(String email);

	@Select("select * from member where name = #{username}")
	Member findMemberByName(String username);

	@Select("select * from admin_Inquiry")
	List<AdminInquiry> memberAdminInquiryList();
	
}
