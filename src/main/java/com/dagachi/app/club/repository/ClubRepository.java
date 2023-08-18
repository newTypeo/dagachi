package com.dagachi.app.club.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
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

	
	List<ManageMember> clubApplyByFindByClubId(int clubId);

	
	
	
}
