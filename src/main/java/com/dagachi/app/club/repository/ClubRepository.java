package com.dagachi.app.club.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.entity.Member;


@Mapper
public interface ClubRepository {

   @Select("select * from club where ${column} like '%' || #{keyword} || '%'")
   List<Club> adminClubSearch(String keyword, String column);

   
   @Select("select * from club where status = 'Y' order by club_id desc")
   List<Club> adminClubList(); 

   
   @Select("SELECT c.*, p.*, cm.member_count " +
               "FROM club c " +
               "JOIN club_profile p ON c.club_id = p.club_id " +
               "LEFT JOIN (SELECT club_id, COUNT(member_id) AS member_count FROM club_member GROUP BY club_id) cm " +
               "ON c.club_id = cm.club_id")
   List<ClubAndImage> clubList();
    
   
   @Select("select * from member")
   List<Member> adminMemberList();

   
   List<ClubSearchDto> clubSearch(String inputText);
   
   
   @Select("select club_id from club where domain = #{domain}")
   int clubIdFindByDomain(String domain);

   
   List<ClubBoard> boardList(int boardType);

   
   @Select("select count(*) from club_member where club_id = #{clubId}")
   int countClubMember(int clubId);
   
   
   @Update("update club set status = 'N' where club_id = #{clubId}")
   int clubDisabled(int clubId);

   
   @Select("select * from club_member where club_id = #{clubId}")
   List<ClubMember> clubMemberByFindAllByClubId(int clubId);

   
   JoinClubMember clubMemberInfoByFindByMemberId(String memberId);
   
   

   


	
	@Update("update club_member set club_member_role = #{clubMemberRole} where member_id = #{memberId}")
	int clubMemberRoleUpdate(ClubMemberRoleUpdate member);





	
	List<ManageMember> clubApplyByFindByClubId(int clubId);

	
	@Insert("insert into club values (seq_club_id.nextVal, #{clubName}, #{activityArea}, #{category}, default, sysdate, default, 0, #{introduce}, #{enrollQuestion}, #{domain})")
	@SelectKey(
			before = false, 
			keyProperty = "clubId", 
			resultType = int.class,
			statement = "select seq_club_id.currval from dual")
	int insertClub(Club club);

	@Insert("insert into club_profile values (#{clubId}, #{originalFilename}, #{renamedFilename}, default)")
	int insertClubProfile(ClubProfile clubProfile);

	@Insert("insert into club_tag values (#{clubId}, #{tag})")
	int insertClubTag(ClubTag clubTag);

	@Select("select * from club where club_Id = #{clubId}")
	Club findClubById(int clubId);

	@Select("select * from club_profile where club_Id = #{clubId}")
	ClubProfile findClubProfileById(int clubId);

	@Select("select * from club_tag where club_Id = #{clubId}")
	List<ClubTag> findClubTagById(int clubId);

	@Update("update club set club_name = #{clubName}, activity_area=#{activityArea}, category=#{category}, introduce=#{introduce}, enroll_question = #{enrollQuestion} where club_id = #{clubId}")
	int updateClub(ClubDetails club);
	
	@Delete("delete club_tag where club_id=#{clubId}")
	int deleteClubTag(ClubDetails club);

	@Update("update club_profile set original_filename = #{originalFilename}, renamed_filename=#{renamedFilename} where club_id=#{clubId}")
	int updateClubProfile(ClubProfile clubProfile);

	
	

	

	
	
	
}
   
