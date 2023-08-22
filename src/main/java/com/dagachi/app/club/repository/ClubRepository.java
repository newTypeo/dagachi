package com.dagachi.app.club.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.dagachi.app.club.dto.BoardAndImageDto;
import com.dagachi.app.club.dto.ClubAndImage;
import com.dagachi.app.club.dto.ClubMemberRole;
import com.dagachi.app.club.dto.ClubMemberRoleUpdate;
import com.dagachi.app.club.dto.JoinClubMember;
import com.dagachi.app.club.dto.KickMember;
import com.dagachi.app.club.dto.ClubSearchDto;
import com.dagachi.app.club.dto.GalleryAndImageDto;
import com.dagachi.app.club.dto.ManageMember;
import com.dagachi.app.club.entity.Club;
import com.dagachi.app.club.entity.ClubApply;
import com.dagachi.app.club.entity.ClubBoard;
import com.dagachi.app.club.entity.ClubBoardAttachment;
import com.dagachi.app.club.entity.ClubBoardDetails;
import com.dagachi.app.club.entity.ClubDetails;
import com.dagachi.app.club.entity.ClubGalleryAttachment;
import com.dagachi.app.club.entity.ClubLayout;
import com.dagachi.app.club.entity.ClubMember;
import com.dagachi.app.club.entity.ClubProfile;
import com.dagachi.app.club.entity.ClubRecentVisited;
import com.dagachi.app.club.entity.ClubTag;
import com.dagachi.app.member.entity.Member;


@Mapper
public interface ClubRepository {

   
   List<Club> adminClubList(RowBounds rowBounds, Map<String, Object> params); 
   List<Club> adminClubList(Map<String, Object> params);
   
   @Select("SELECT c.*, p.*, cm.member_count " +
               "FROM club c " +
               "JOIN club_profile p ON c.club_id = p.club_id " +
               "LEFT JOIN (SELECT club_id, COUNT(member_id) AS member_count FROM club_member GROUP BY club_id) cm " +
               "ON c.club_id = cm.club_id")
   List<ClubAndImage> clubList();
    
   
   @Select("select * from member")
   List<Member> adminMemberList();

   
   List<ClubSearchDto> clubSearch(RowBounds rowBounds, Map<String, Object> params);
   List<ClubSearchDto> clubSearch(Map<String, Object> params);
   
   @Select("select club_id from club where domain = #{domain}")
   int clubIdFindByDomain(String domain);

   
   List<ClubBoard> boardList(int boardType);

   
   @Select("select count(*) from club_member where club_id = #{clubId}")
   int countClubMember(int clubId);
   
   
   @Update("update club set status = 'N' where club_id = #{clubId}")
   int clubDisabled(int clubId);

   
   @Select("select * from club_member where club_id = #{clubId} and club_member_role != 3")
   List<ClubMember> clubMemberByFindAllByClubId(int clubId);

   
   JoinClubMember clubMemberInfoByFindByMemberId(String memberId);
   
   

   


	
	List<ClubBoard> boardList(ClubBoard clubBoard);

	@Select("select * from club where domain= #{domain}")
	Club findByDomain(String domain);

	@Select("select * from club_board where club_id= #{clubId} and board_id =#{boardId}")
	ClubBoard findByBoard(ClubBoard _clubBoard);

	@Select("select * from club_board where board_id= #{boardId}")
	ClubBoard findByBoardId(int boardId);

	@Update("update club_board set title=#{title}, content=#{content}, type=#{type} , status=#{status}, like_count=#{likeCount} where board_id=#{boardId}")
	int updateBoard(ClubBoard _board);




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
	
	@Select("select * from club_layout where club_Id = #{clubId}")
	ClubLayout findLayoutById(int clubId);
	
	@Insert("insert into club_board (board_id, club_id, writer, title, content, type) " +
	        "values (seq_club_board_id.nextval, #{clubId}, #{writer}, #{title}, #{content}, #{type})")
	@SelectKey(
			before = false, 
			keyProperty = "boardId", 
			resultType = int.class,
			statement = "select seq_club_board_id.currval from dual")
	int postBoard(ClubBoard clubBoard);
	
	@Insert("insert into club_board_attachment (id, board_id, original_filename, renamed_filename,created_at, thumbnail) " +
	        "values (seq_club_board_attachment_id.nextval, #{boardId}, #{originalFilename}, #{renamedFilename}, default , #{thumbnail})")
	int insetAttachment(ClubBoardAttachment attach);
	
	@Select("select * from club_board_attachment where board_id = #{no}")
	List<ClubBoardAttachment> findAttachments(int no);
	
	@Select("select * from club_board_attachment where id = #{attachNo}")
	ClubBoardAttachment findAttachment(int attachNo);
	

	@Select("select * from (SELECT a.*, b.count AS member_count FROM (SELECT c.*, i.member_id FROM club c JOIN member_interest i ON c.category = i.interest WHERE i.member_id = #{memberId}) a LEFT JOIN (SELECT club_id, COUNT(*) AS count FROM club_member GROUP BY club_id) b ON a.club_id = b.club_id) c left join (select * from club_profile) d on c.club_id = d.club_id")
	List<ClubAndImage> clubListById(String memberId);
	
	List<ClubSearchDto> searchClubWithFilter(Map<String, Object> params);
	List<ClubSearchDto> searchClubWithFilter(RowBounds rowBounds, Map<String, Object> params);

	@Select("select * from (select * from club_board cb left join club_board_attachment ca on cb.board_id = ca.board_id where (ca.thumbnail = 'Y' or ca.thumbnail is null) and club_id = #{clubId} order by cb.board_id desc) where rownum <= 100")
	List<BoardAndImageDto> findBoardAndImageById(int clubId);

	JoinClubMember hostFindByClubId(int clubId);
	
	@Select("select club_member_role from club_member where club_id = #{clubId} and member_id = #{loginMemberId}")
	int memberRoleFindByMemberId(ClubMemberRole clubMemberRole);
	
	@Select("select * from (select * from club_gallery cg left join club_gallery_attachment ca on cg.gallery_id = ca.gallery_id where (ca.thumbnail = 'Y' or ca.thumbnail is null) and club_id = #{clubId} order by cg.gallery_id desc) where rownum <= 6")
	List<GalleryAndImageDto> findgalleryById(int clubId);
	
	@Insert("insert into club_layout values (#{clubId}, default, default, default, default, default, default, default, default)")
	int insertLayout(int clubId);

	@Delete("delete from club_member where club_id = #{clubId} and member_id = #{memberId}")
	int kickMember(KickMember kickMember);
	
	@Insert("insert into recent_visit_list values(#{memberId}, #{clubId}, default)")
	int insertClubRecentVisitd(String memberId, int clubId);
	
	@Select("select * from recent_visit_list")
	List<ClubRecentVisited> findAllrecentVisitClubs();
	
	@Select("select count(*) from recent_visit_list where club_id = #{clubId}")
	int checkDuplicateClubId(int clubId);

	
}
   
