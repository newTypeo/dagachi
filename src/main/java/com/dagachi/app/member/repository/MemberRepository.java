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
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.member.dto.MemberCreateDto;
import com.dagachi.app.member.entity.ActivityArea;
import com.dagachi.app.member.entity.CbcLike;
import com.dagachi.app.member.entity.Member;
import com.dagachi.app.member.entity.MemberDetails;
import com.dagachi.app.member.entity.MemberInterest;
import com.dagachi.app.member.entity.MemberLike;
import com.dagachi.app.member.entity.MemberProfile;


@Mapper
public interface MemberRepository {
	
	
	// 멤버 회원가입 추가 ( 지우지마삼 )
	@Insert("insert into member values (#{memberId}, #{password},#{name}, #{nickname}, #{phoneNo}, #{email}, #{birthday, jdbcType=DATE}, #{gender}, #{mbti},  #{address}, 0, SYSDATE, NULL, SYSDATE, NULL, 'Y')"
	) 
	int insertMember(MemberCreateDto member);

	// 지역

	@Insert("INSERT INTO activity_area values(#{memberId}, #{mainAreaId}, #{sub1AreaId}, #{sub2AreaId})"
	) 
	void insertActivityArea(MemberCreateDto member);

	// 관심사

	@Insert("INSERT INTO member_interest values(#{memberId}, #{interest})") 
	void insertMemberInterest(MemberCreateDto member);

	// 회원가입 ------------------
	
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
	
//	/*임시 회원가입 (지우지 마삼) */
//	@Insert("insert into member values (#{memberId}, #{password},#{name}, #{nickname}, #{phoneNo}, #{email}, #{birthday, jdbcType=DATE}, #{gender}, #{mbti},  #{address}, 0, SYSDATE, NULL, SYSDATE, NULL, 'Y')")
//	int insertMember(MemberCreateDto member);

	@Insert("insert into admin_Inquiry values (seq_Inquiry_id.nextval,#{memberId},#{title} ,#{content}, SYSDATE ,#{type},1,NULL,NULL,#{open},NULL)")
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

	@Update("update member set name = #{name}, nickname=#{nickname}, phone_no = #{phoneNo}, address=#{address}, mbti =#{mbti}, birthday = #{birthday, jdbcType=DATE}, gender = #{gender} where member_id = #{memberId}")
	int updateMember(Member member);

	@Update("update member_profile set original_filename = #{originalFilename}, renamed_filename = #{renamedFilename} where member_id = #{memberId}")
	int updateMemberProfile(MemberProfile memberProfile);
	
	@Select("select * from admin_Inquiry order by Inquiry_id desc")
	List<AdminInquiry> memberAdminInquiryList();
	
	@Insert("insert into member_like values(seq_member_like_id.nextval, #{memberId}, #{loginMemberId}, default)")
	int memberLike(Map<String, Object> params);
	
	@Delete("delete from member_like where member_Id = #{memberId} and like_sender = #{loginMemberId}")
	int cancelMemberLike(Map<String, Object> params);

	@Select("select * from member_like where member_id = #{loginMemberId} order by like_id")
	List<MemberLike> findAllLikeMe(String loginMemberId);

	@Select("select count(*) from member_like where member_id = #{memberId}")
	int checkDuplicateMemberId(String memberId);

	@Select("select * from member_interest where member_id = #{memberId}")
	List<MemberInterest> findMemberInterestsByMemberId(String memberId);

	@Select("select * from club_member where member_id = #{memberId}")
	List<ClubMember> findClubMemberByMemberId(String memberId);
	
}
